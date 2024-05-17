//
//  NewsViewModelDelegateMock.swift
//  Bornlogic_iOSChallengeTests
//
//  Created by Guilherme Viana on 17/05/2024.
//

import Foundation

class NewsViewModelDelegateMock: NewsViewModelDelegate {
    var didCallNewsDataDidUpdate = false
    var didCallNewsDataDidFailWithError = false
    var lastError: NewsError?

    func newsDataDidUpdate() {
        didCallNewsDataDidUpdate = true
    }

    func newsDataDidFailWithError(_ error: NewsError) {
        didCallNewsDataDidFailWithError = true
        lastError = error
    }
}
