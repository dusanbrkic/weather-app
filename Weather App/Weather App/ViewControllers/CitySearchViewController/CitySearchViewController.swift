//
//  CitySearchViewController.swift
//  Weather App
//
//  Created by Dusan Brkic on 19.8.22..
//

import Foundation
import UIKit

class CitySearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    // services
    var citySearchService: CitySearchService?
    var favoriteCityService: FavoriteCityService?
    var searchController: UISearchController?

    // data
    var searchResults: [SearchedCityDTO] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let xibId = String(describing: CitySearchViewCell.self)
        let nib = UINib(nibName: xibId, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: xibId)
        self.tableView.separatorStyle = .none
    }
}

extension CitySearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let xibId = String(describing: CitySearchViewCell.self)
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: xibId, for: indexPath) as? CitySearchViewCell else {
            return UITableViewCell()
        }
        let result = searchResults[indexPath.row]
        cell.updateFields(with: result)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedCity = searchResults[indexPath.row]
        favoriteCityService?.saveFavoriteCity(from: tappedCity)
        self.searchController?.isActive = false
    }
}

extension CitySearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.searchController = searchController
        let searchText = searchController.searchBar.text!
        Task {
            do {
                guard let retVal = try await self.citySearchService?.searchCity(
                    with: searchText) else {
                    return
                }
                self.searchResults = retVal.data
                self.tableView.reloadData()
            } catch {

            }
        }
    }
}
