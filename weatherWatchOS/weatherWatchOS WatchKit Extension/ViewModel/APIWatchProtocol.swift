//
//  APIWatchProtocol.swift
//  weatherWatchOS
//
//  Created by Владислав Космачев.
//

import Foundation

protocol APIWatchProtocol {
    
    /// Функция получения данных
    /// - Parameters:
    ///     - lat: Широта
    ///     - lon: Долгота
    func getData(lat:Double, lon:Double)
    
    /// Функция получения данных о состоянии воздуха
    /// - Parameters:
    ///     - lat: Широта
    ///     - lon: Долгота
    func getAirPollution(lat:Double, lon:Double)
    
    /// Функция получения расширенных данных
    /// - Parameters:
    ///     - lat: Широта
    ///     - lon: Долгота
    func getExtendedData(lat:Double, lon:Double)
    
}
