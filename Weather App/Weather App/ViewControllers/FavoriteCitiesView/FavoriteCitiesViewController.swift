//
//  FavoriteCitiesViewCotroller.swift
//  Weather App
//
//  Created by Dusan Brkic on 19.8.22..
//

import Foundation
import UIKit

class FavoriteCitiesViewCotroller: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    // services
    var favoriteCityService: FavoriteCityService?
    var weatherUseCase: WeatherUseCase?

    // delegates
    weak var delegate: FavoriteCitiesViewDelegate?

    // data
    var favCities: [FavoriteCityEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFavoriteCities()
        setUpNavBar()
        setUpTableView()
    }

    func setUpFavoriteCities() {
        favCities = favoriteCityService?.fetchAll() ?? []
        tableView.reloadData()
    }

    func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let xibId = String(describing: FavoriteCitiesViewCell.self)
        let nib = UINib(nibName: xibId, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: xibId)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

    func setUpNavBar() {
        title = "Favorite Cities"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let resultsController = storyboard.instantiateViewController(
            withIdentifier: "searchResults") as? CitySearchViewController
        navigationItem.searchController = UISearchController(
            searchResultsController: resultsController)
        let searchController = navigationItem.searchController
        searchController?.delegate = self
        searchController?.searchResultsUpdater = resultsController
        searchController?.obscuresBackgroundDuringPresentation = true
        searchController?.automaticallyShowsSearchResultsController = true
        navigationItem.hidesSearchBarWhenScrolling = false

    }

}

extension FavoriteCitiesViewCotroller: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let xibId = String(describing: FavoriteCitiesViewCell.self)
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: xibId, for: indexPath) as? FavoriteCitiesViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        let favCity = favCities[indexPath.row]
        cell.updateFields(with: favCity)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedCity = favCities[indexPath.row]
        delegate?.didSelectCity(lat: String(tappedCity.lat), lon: String(tappedCity.lon))
        navigationController?.popViewController(animated: true)
    }
 }

extension FavoriteCitiesViewCotroller: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        setUpFavoriteCities()
    }
}

extension FavoriteCitiesViewCotroller: FetchFavouriteCitiesDelegate {
    func fetchWeather(for favouriteCity: FavoriteCityEntity, completion: @escaping (WeatherDomain) -> Void) {
        Task {
            do {
                guard let weather = try await weatherUseCase?.getWeather(
                    lat: String(favouriteCity.lat),
                    lon: String(favouriteCity.lon)) else {
                    return
                }
                completion(weather)
            } catch { return }
        }
    }
}
