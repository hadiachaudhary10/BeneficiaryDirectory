//
//  NetworkManager.swift
//  BeneficiariesTestProject
//
//  Created by Dev on 21/03/2024.
//

import Foundation

enum ResulType: Error {
    case Fetching
    case Success
    case NoData
    
}

class NetworkManager {
    let apiHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(apiHandler: APIHandlerDelegate = APIHandler(), responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T: Codable>(type: T.Type, url: URL) async throws -> T {
        do {
            let apiResponse = try await apiHandler.fetchData(url: url)
            return try responseHandler.fetchModel(type: type, data: apiResponse)
        } catch{
            throw error
        }
    }
}

protocol APIHandlerDelegate {
    func fetchData(url: URL) async throws -> Data
}

class APIHandler: APIHandlerDelegate {
    func fetchData(url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ResulType.NoData
            }
            return data
        } catch {
            throw error
        }
    }
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data) throws -> T
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw error
        }
    }
}
