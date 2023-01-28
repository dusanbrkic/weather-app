//
//  CitySearchViewCell.swift
//  Weather App
//
//  Created by Dusan Brkic on 19.8.22..
//

import UIKit

class CitySearchViewCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func updateFields(with result: SearchedCityDTO) {
        let cityName = result.city
        let regionName = result.region
        let countryName = result.country
        self.cityNameLabel.text = "\(cityName), \(regionName), \(countryName)"
    }

}
