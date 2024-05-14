//
//  ZipCiodeService.swift
//  Cadastro
//
//  Created by Gregory Luiz lopes freire on 10/05/24.
//

import Foundation

enum ZipCodeServiceError: Error {
    case invalidUrl
    case invalidResponse
    case decodingError
}

struct ZipCodeService {
    func getZipCodes(zipCode: String) async throws -> ZipCodeInfo {
        
        let urlString = "https://brasilapi.com.br/api/cep/v1/\(zipCode)"
        
        guard let url = URL(string: urlString) else {
            throw ZipCodeServiceError.invalidUrl
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ZipCodeServiceError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            let zipCodeInfo = try decoder.decode(ZipCodeInfo.self, from: data)
            return zipCodeInfo
  
        }catch {
            throw ZipCodeServiceError.decodingError
        }
    }
}
