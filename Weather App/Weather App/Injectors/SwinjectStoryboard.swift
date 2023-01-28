//
//  SwinjectStoryboard.swift
//  Weather App
//
//  Created by Dusan Brkic on 17.8.22..
//

import Foundation
import SwinjectStoryboard
import FirebaseCrashlytics

extension SwinjectStoryboard {
    @objc class public func setup() {
        let keychainServiceName = "is.symphony.Weather-App"
        let db = CoreDataStack(modelName: "DataModel")

        // add repos
        defaultContainer.register(FavoriteCityRepository.self, name: String(
            describing: FavoriteCityRepository.self)) {
                resolver in
                guard let dabaseInstance = resolver.resolve(
                    DatabaseCRUD.self,
                    name: String(describing: DatabaseCRUD.self)) else {
                    fatalError()
                }
                return FavoriteCityRepositoryImpl(instance: dabaseInstance)
            }.inObjectScope(.container)
        defaultContainer.register(DatabaseInstance.self, name: String(
            describing: DatabaseInstance.self)) { _ in
                let instance = db
                instance.inilizalize()
                return instance
        }

        defaultContainer.register(DatabaseCRUD.self, name: String(
            describing: DatabaseCRUD.self)) { _ in
                db
        }

        // add services
        defaultContainer.register(FavoriteCityService.self, name: String(
            describing: FavoriteCityService.self)) {
                resolver in
                guard let repository = resolver.resolve(
                    FavoriteCityRepository.self,
                    name: String(describing: FavoriteCityRepository.self)
                ) else {
                    fatalError()
                }
                return FavoriteCityServiceImpl(favoriteCitiesRepository: repository)
            }

        defaultContainer.register(Logger.self, name: String(
            describing: Logger.self)) { _ in
                #if DEBUG
                    return ConsoleLogger()
                #else
                    return FirebaseLogger(instance: Crashlytics.crashlytics())
                #endif
            }

        defaultContainer.register(CurrentWeatherService.self, name: String(
            describing: CurrentWeatherService.self)) {
                resolver in
                guard let logger = resolver.resolve(
                    Logger.self,
                    name: String(describing: Logger.self)) else {
                    fatalError()
                }
                return CurrentWeatherServiceImpl(logger: logger)
            }
        defaultContainer.register(KeychainService.self, name: String(
            describing: KeychainService.self)) {
                _ in KeychainServiceImpl(serviceName: keychainServiceName)
            }
        defaultContainer.register(WeatherIconService.self, name: String(
            describing: WeatherIconService.self)) {
                _ in WeatherIconServiceImpl() }
        defaultContainer.register(HourlyForecastService.self, name: String(
            describing: HourlyForecastService.self)) {
                _ in HourlyForecastServiceImpl() }
        defaultContainer.register(WeatherAPICredentialsService.self, name: String(
            describing: WeatherAPICredentialsService.self)) { resolver in
                guard let keychainService = resolver.resolve(
                        KeychainService.self,
                        name: String(describing: KeychainService.self)
                ) else { fatalError() }
                return WeatherAPICredentialsServiceImpl(keychainService: keychainService) }
        defaultContainer.register(AuthenticationService.self, name: String(
            describing: AuthenticationService.self)) { resolver in
                guard let keychainService = resolver.resolve(
                        KeychainService.self,
                        name: String(describing: KeychainService.self)
                ) else { fatalError() }
                return GoogleAuthenticationServiceImpl(keychainService: keychainService) }
        defaultContainer.register(CitySearchService.self, name: String(
            describing: CitySearchService.self)) {
                _ in CitySearchServiceImpl() }

        // add use cases
        defaultContainer.register(WeatherUseCase.self,
                                  name: String(describing: WeatherUseCase.self)
        ) { resolver in
            guard
                let currentWeatherService = resolver.resolve(
                    CurrentWeatherService.self,
                    name: String(describing: CurrentWeatherService.self)
                ),
                let weatherIconService = resolver.resolve(
                    WeatherIconService.self,
                    name: String(describing: WeatherIconService.self)
                ),
                let hourlyForecastService = resolver.resolve(
                    HourlyForecastService.self,
                    name: String(describing: HourlyForecastService.self)
                ),
                let keychainService = resolver.resolve(
                    WeatherAPICredentialsService.self,
                    name: String(describing: WeatherAPICredentialsService.self)
                ) else {
                fatalError()
            }
            return WeatherUseCaseImpl(currentWeatherService: currentWeatherService,
                                      weatherIconService: weatherIconService,
                                      hourlyForecastService: hourlyForecastService,
                                      credentialsService: keychainService
            )
        }

        // add controllers
        defaultContainer.storyboardInitCompleted(HomeViewController.self) { resolver, controller in
            controller.weatherUseCase = resolver.resolve(
                WeatherUseCase.self,
                name: String(describing: WeatherUseCase.self)
            )
            controller.weatherAPICredentialsService = resolver.resolve(
                WeatherAPICredentialsService.self,
                name: String(describing: WeatherAPICredentialsService.self)
            )
            controller.authService = resolver.resolve(
                AuthenticationService.self,
                name: String(describing: AuthenticationService.self)
            )
        }

        defaultContainer.storyboardInitCompleted(CitySearchViewController.self) {
            resolver, controller in
            controller.citySearchService = resolver.resolve(
                CitySearchService.self,
                name: String(describing: CitySearchService.self)
            )
            controller.favoriteCityService = resolver.resolve(
                FavoriteCityService.self,
                name: String(describing: FavoriteCityService.self)
            )
        }

        defaultContainer.storyboardInitCompleted(FavoriteCitiesViewCotroller.self) {
            resolver, controller in
            controller.favoriteCityService = resolver.resolve(
                FavoriteCityService.self,
                name: String(describing: FavoriteCityService.self)
            )
            controller.weatherUseCase = resolver.resolve(
                WeatherUseCase.self,
                name: String(describing: WeatherUseCase.self)
            )
        }
    }
}
