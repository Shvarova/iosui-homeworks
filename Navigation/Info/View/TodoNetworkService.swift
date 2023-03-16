//
//  TodoNetworkService.swift
//  Navigation
//
//  Created by Дина Шварова on 16.03.2023.
//

import Foundation

enum TodoNetworkError: Error {
    case invalidURL
    case unkonwnError(Error)
    case parseError
    case nilData
    case emptyData
    case invalidTitle
    case serializedError
}

struct TodoNetworkService {
    private let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")
    private let urlPlanets = URL(string: "https://swapi.dev/api/planets/1")
    
    func fetch(handler: @escaping (Result<String, TodoNetworkError>) -> Void) {
        guard let url = url else {
            handler (.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(.unkonwnError(error)))
                return
            }
            guard let data = data else {
                handler(.failure(.nilData))
                return
            }
            do {
                let serializedDictionary = try JSONSerialization.jsonObject(with: data, options: [])
                guard let dict = serializedDictionary as? [[String: Any]] else {
                    handler(.failure(.parseError))
                    return
                }
                guard let firstData = dict.first else {
                    handler(.failure(.emptyData))
                    return
                }
                guard let title = firstData["title"] as? String else {
                    handler(.failure(.invalidTitle))
                    return
                }
                handler(.success(title))
            } catch {
                handler(.failure(.serializedError))
            }
        }
        task.resume()
    }
    func fetchOrbitalPeriod(handler: @escaping (Result<String, TodoNetworkError>) -> Void) {
        guard let url = urlPlanets else {
            handler (.failure(.invalidURL))
            return
        }
                
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            guard let data = data else {
                handler(.failure(.nilData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let planet = try decoder.decode(PlanetsData.self, from: data)
                handler(.success(planet.orbitalPeriod))
            } catch {
                handler(.failure(.parseError))
            }
        })
        task.resume()
    }
}

struct PlanetsData: Encodable, Decodable {
    let orbitalPeriod: String
}
