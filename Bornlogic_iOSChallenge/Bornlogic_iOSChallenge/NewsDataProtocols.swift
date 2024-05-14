//
//  NewsDataProtocols.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 14/05/2024.
//

import Foundation

protocol NewsViewModelDelegate: AnyObject {
    func newsDataDidUpdate()
    func newsDataDidFailWithError(_ error: NewsError)
}
