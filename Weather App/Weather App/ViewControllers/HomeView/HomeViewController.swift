//
//  HomeViewController.swift
//  Weather App
//
//  Created by Dusan Brkic on 11.8.22..
//

import UIKit
import SwiftVideoBackground

class HomeViewController: UIViewController {
    // view elements
    @IBOutlet weak var hourlyWeatherCollectionView: UICollectionView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var weatherStatus: UILabel!

    let showFavouritesSegue = "showFavourites"

    // utilities
    let locationManager = LocationInstanceManager()
    let alertBuilder = UIAlertBuilder()
    let localURLBuilder = LocalURLBuilder()

    // use cases
    var weatherUseCase: WeatherUseCase?

    // services
    var weatherAPICredentialsService: WeatherAPICredentialsService?
    var authService: AuthenticationService?

    // data
    var hourlyForecasts: [ForecastDTO] = []
    var hourlyForecastIcons: [Data?] = []
    let usingCurrLocSetKey = "UsingCurrentLocationSet"
    let usingCurrLocKey = "UsingCurrentLocation"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserCredentials()
        setUpLocationManager()
        setUpCollectionView()
    }

    func setUpLocationManager() {
        locationManager.locationDelegate = self
        self.locationManager.requestLocationAuthorization()
    }

    func setUpCollectionView() {
        self.hourlyWeatherCollectionView.delegate = self
        self.hourlyWeatherCollectionView.dataSource = self
        let xibId = String(describing: HourlyWeatherCollectionViewCell.self)
        let nib = UINib(nibName: xibId, bundle: nil)
        self.hourlyWeatherCollectionView.register(nib,
                                                  forCellWithReuseIdentifier: xibId)
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.hourlyWeatherCollectionView.backgroundView = blurEffectView
    }

    func setupUserCredentials() {
        guard let weatherAPICredentialsService = weatherAPICredentialsService else {
            return
        }
        do {
            try weatherAPICredentialsService.setupUserCredentials()
        } catch {
            let alert = self.alertBuilder.buildDismissibleAlert(
                with: "Credentials Error",
                and: "Error setting up your credentials, try restarting the app.")
            self.present(alert, animated: true)
        }
    }

    @IBAction func refreshBtnTapped(_ sender: Any) {
        self.locationManager.startUpdating()
    }

    @IBAction func googleSignInButtonTapped(_ sender: Any) {
        authService?.authenticateUser(in: self)
    }

    @IBAction func addFavouriteCityButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: showFavouritesSegue, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Create a new variable to store the instance of FavoriteCitiesViewController
        let favCitiesVC = segue.destination as? FavoriteCitiesViewCotroller
        favCitiesVC?.delegate = self
    }

    func updateWeather(lat: String, lon: String) {
        Task {
            do {
                guard let weatherUseCase = weatherUseCase else {
                    return
                }

                let response = try await weatherUseCase.getWeather(lat: lat,
                                                                   lon: lon)
                let mainWeather = response.currentWeather.weather.first!.main
                self.locationNameLabel.text = response.currentWeather.name
                self.temperatureLabel.text = String(Int(response.currentWeather.main.temp.rounded()))
                self.weatherIcon.image = UIImage(data: response.currentWeatherIcon!)
                self.weatherStatus.text = mainWeather
                self.hourlyForecasts = response.hourlyForecast.forecasts
                self.hourlyForecastIcons = response.hourlyForecastIcons
                self.hourlyWeatherCollectionView.reloadData()
                guard let videoURL = localURLBuilder.buildURLToAssets(
                    with: mainWeather, of: "mp4") else {
                    view.backgroundColor = .black
                    return
                }
                VideoBackground.shared.play(view: view, url: videoURL)
            } catch _ {
                let retryAction = {
                    self.locationManager.startUpdating()
                }
                let alert = self.alertBuilder.buildRetryableAlert(
                    with: NSLocalizedString("Weather Error", comment: ""),
                    and: "Error getting weather, try again later.",
                    action: retryAction)
                self.present(alert, animated: true)
            }
        }
    }
}

extension HomeViewController: LocationsDelegate {
    func didGetCurrentLocation(lon: String,
                               lat: String) {
        updateWeather(lat: lat, lon: lon)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyForecasts.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let xibId = String(describing: HourlyWeatherCollectionViewCell.self)
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: xibId, for: indexPath) as? HourlyWeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(with: hourlyForecasts[indexPath.row], and: hourlyForecastIcons[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 100
        let height = 100
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: FavoriteCitiesViewDelegate {
    func didSelectCity(lat: String, lon: String) {
        updateWeather(lat: lat, lon: lon)
    }
}
