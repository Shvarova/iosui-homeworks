//
//  NetworkService.swift
//  Navigation
//
//  Created by Дина Шварова on 14.03.2023.
//

import Foundation

enum AppConfiguration: String {
    case people = "https://swapi.dev/api/people/"
    case starships = "https://swapi.dev/api/starships/"
    case planets = "https://swapi.dev/api/planets/"
}

struct NetworkService {
    static func request(configurations: AppConfiguration) {
        guard let url = URL(string: configurations.rawValue) else {
            print ("URL не найден")
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {return}
            let parsedData = String (data: data, encoding: .utf8)
            print("Данные: \(String(describing: parsedData))")
            
            if let error = error {
                print ("\n error.localizedDescription \(error.localizedDescription)\n")
                print("error.localizedDescription.debugDescription \(error.localizedDescription.debugDescription)\n")
                return
                // NSLocalizedDescription=The Internet connection appears to be offline., NSErrorFailingURLStringKey=https://swapi.dev/api/people/, NSErrorFailingURLKey=https://swapi.dev/api/people/, _kCFStreamErrorDomainKey=1
            }
            if let response = response as? HTTPURLResponse {
                print("\n response.allHeaderFields \(response.allHeaderFields)\n")
                print("\n response.statusCode \(response.statusCode)\n")
                return
            }
        }
        task.resume()
    }
}
