//
//  FavoriteCitiesViewDelegate.swift
//  Weather App
//
//  Created by Dusan Brkic on 22.8.22..
//

import Foundation

protocol FavoriteCitiesViewDelegate: AnyObject {
    func didSelectCity(lat: String, lon: String)
}
