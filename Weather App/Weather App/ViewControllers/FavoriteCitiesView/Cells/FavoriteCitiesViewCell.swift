//
//  FavoriteCitiesViewCell.swift
//  Weather App
//
//  Created by Dusan Brkic on 19.8.22..
//

import UIKit
import SwiftVideoBackground
import CoreLocation

class FavoriteCitiesViewCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!

    // use cases
    weak var delegate: FetchFavouriteCitiesDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func updateFields(with city: FavoriteCityEntity) {
        delegate?.fetchWeather(for: city) { response in
            let mainWeather = response.currentWeather.weather.first!.main
            self.cityNameLabel.text = response.currentWeather.name
            self.temperatureLabel.text = String(Int(response.currentWeather.main.temp.rounded()))
            self.weatherImage.image = UIImage(data: response.currentWeatherIcon!)
            self.weatherDescriptionLabel.text = mainWeather
        }
    }
}
