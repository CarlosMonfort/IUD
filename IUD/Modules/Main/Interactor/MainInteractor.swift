//
//  MainInteractor.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class MainInteractor {
    
    // MARK: - Variables
    var presenter: MainOutputInteractorProtocol?
    
    // MARK: - Get Users
    func getUsersData() {
        let getUsers = GetUsers()
        let usersRequest = APIRequest(method: getUsers.method, path: getUsers.path.value())
        APIClient.shared.performGetRequest(usersRequest) { (result) in
            switch result {
            case .success(let response):
                self.manageGetUsersResponse(response)
            case .failure(let responseError):
                self.presenter?.mainOutputError(error: responseError)
            }
        }
    }
    
    func manageGetUsersResponse(_ response: Data?) {
        do {
            guard let data = response else { self.presenter?.mainOutputError(error: .noData); return }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategyFormatters = [DateFormatter.iso8601Full, DateFormatter.iso8601Short]
            let users = try decoder.decode([User].self, from: data)
            self.presenter?.mainOutputUsersDataFetched(users: users)
        } catch {
            self.presenter?.mainOutputError(error: .decodingFailure)
        }
    }
}

extension MainInteractor: MainInputInteractorProtocol {
    
    func mainInputGetUsers() {
        getUsersData()
    }
}
