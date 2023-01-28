//
//  CoreDataStack.swift
//  Weather App
//
//  Created by Dusan Brkic on 23.8.22..
//

import Foundation
import CoreData

class CoreDataStack {

    private lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

}

extension CoreDataStack: DatabaseInstance {
    func inilizalize() {

    }

    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}

extension CoreDataStack: DatabaseCRUD {
    func saveFavouriteCity(with searchedCity: SearchedCityDTO) {
        let newFavCity = FavoriteCityEntity(context: managedContext)
        newFavCity.cityName = searchedCity.city
        newFavCity.lat = searchedCity.latitude
        newFavCity.lon = searchedCity.longitude
        do {
            try managedContext.save()
        } catch {}
    }

    func fetchAll() -> [FavoriteCityEntity] {
        do {
            return try managedContext.fetch(FavoriteCityEntity.fetchRequest())
        } catch {
            return []
        }
    }
}

protocol DatabaseInstance {
    func inilizalize()
    func saveContext()
}

protocol DatabaseCRUD {
    func saveFavouriteCity(with searchedCity: SearchedCityDTO)
    func fetchAll() -> [FavoriteCityEntity]
}
