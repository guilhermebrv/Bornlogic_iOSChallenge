//
//  DataParser.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 14/05/2024.
//

import Foundation

struct DataParser: DataParsingDelegate {
    func decodeData(_ data: Data) throws -> NewsData? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            return try decoder.decode(NewsData.self, from: data)
        } catch {
            throw NewsError.invalidData
        }
    }
}
