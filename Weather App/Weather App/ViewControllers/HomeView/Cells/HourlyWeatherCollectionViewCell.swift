//
//  HourlyWeatherCollectionViewCell.swift
//  Weather App
//
//  Created by Dusan Brkic on 15.8.22..
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(with data: ForecastDTO, and icon: Data?) {
        self.temperatureLabel.text = String(Int(data.main.temp.rounded()))
        do {
            self.hourLabel.text = try String(DateExtractor().getHours(from: data.dateTime))
        } catch {
            self.hourLabel.text = "NN"
        }
        guard let icon = icon else {
            self.weatherImage.image = UIImage(named: "WeatherPlaceholder")
            return
        }
        self.weatherImage.image = UIImage(data: icon)
    }
}
