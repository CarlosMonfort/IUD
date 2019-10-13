//
//  DetailInteractor.swift
//  IUD
//
//  Created by Carlos Monfort on 11/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

class DetailInteractor {
    
    var presenter: DetailOutputInteractorProtocol?
    
    // MARK: - Get User
    func getUserData(_ id: Int) {
        let usersRequest = APIRequest(method: .get, path: "/\(id)")
        APIClient.shared.performGetRequest(usersRequest) { (result) in
            switch result {
            case .success(let response):
                self.manageGetUserResponse(response)
            case .failure(let responseError):
                self.presenter?.detailOutputError(error: responseError)
            }
        }
    }
    
    func manageGetUserResponse(_ response: Data?) {
        do {
            guard let data = response else { self.presenter?.detailOutputError(error: .noData); return }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategyFormatters = [DateFormatter.iso8601Full, DateFormatter.iso8601Short]
            let user = try decoder.decode(User.self, from: data)
            let items = self.userToDetailItems(user)
            self.presenter?.detailUserDataFetched(user: user, items: items)
        } catch {
            self.presenter?.detailOutputError(error: .decodingFailure)
        }
    }
    
    // MARK: - Delete User
    func deleteUserData(_ id: Int) {
        let deleteUserRequest = APIRequest(method: .delete, path: "/\(id)")
        APIClient.shared.performRequest(deleteUserRequest) { (result) in
            switch result {
            case .success( _):
                self.presenter?.detailProcessFinished(error: nil)
            case .failure(let responseError):
                self.presenter?.detailOutputError(error: responseError)
            }
        }
    }
    
    // MARK: - Update User
    func updateUser(user: User, name: String?, date: Date?, time: Date?) {
        let newName: String! = name ?? user.name
        let newBirthday: Date! = date ?? user.birthdate
        let newTime: Date! = time ?? user.birthdate
        guard let newDate = combineDateAndTime(date: newBirthday, time: newTime) else { return }
        let newUser = User(id: user.id, name: newName, birthdate: newDate)
        putUserData(newUser)
    }
    
    func putUserData(_ user: User) {
        do {
            let putRequest = try APIRequest(method: .put, path: "", user: user)
            APIClient.shared.performRequest(putRequest) { (result) in
                switch result {
                case .success( _):
                    self.presenter?.detailProcessFinished(error: nil)
                case .failure(let responseError):
                    self.presenter?.detailOutputError(error: responseError)
                }
            }
        } catch {
            self.presenter?.detailOutputError(error: .unexpectedError)
        }
    }
    
    // MARK: - Post User
    func createUser(name: String, date: Date, time: Date) {
        let newName: String! = name
        let newBirthday: Date! = date
        let newTime: Date! = time
        guard let newDate = combineDateAndTime(date: newBirthday, time: newTime) else { return }
        let newUser = User(id: 28900, name: newName, birthdate: newDate)
        putUserData(newUser)
    }
    
    func postUserData(_ user: User) {
        do {
            let putRequest = try APIRequest(method: .post, path: "", user: user)
            APIClient.shared.performRequest(putRequest) { (result) in
                switch result {
                case .success( _):
                    self.presenter?.detailProcessFinished(error: nil)
                case .failure(let responseError):
                    self.presenter?.detailOutputError(error: responseError)
                }
            }
        } catch {
            self.presenter?.detailOutputError(error: .unexpectedError)
        }
    }
    
    // MARK: - User To Items
    func userToDetailItems(_ user: User) -> [DetailItem] {
        let nameItem = NameItem(user.name ?? "No name")
        let birthdayItem = BirthdayItem(user.birthdate)
        let timeItem = HourItem(user.birthdate)
        let items: [DetailItem] = [nameItem, birthdayItem, timeItem]
        
        return items
    }
    
    func getEmptyItems() {
        let nameItem = NameItem("Nombre")
        let today = Date()
        let birthdayItem = BirthdayItem(today)
        let timeItem = HourItem(today)
        let items: [DetailItem] = [nameItem, birthdayItem, timeItem]
        self.presenter?.detailUserDataFetched(user: nil, items: items)
    }
    
    // MARK: - Date
    func combineDateAndTime(date: Date, time: Date) -> Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)

        var components = DateComponents()
        components.year = dateComponents.year
        components.month = dateComponents.month
        components.day = dateComponents.day
        components.hour = timeComponents.hour
        components.minute = timeComponents.minute
        components.second = timeComponents.second
        
        let newDate = calendar.date(from: components)
        return newDate
    }
}

extension DetailInteractor: DetailInputInteractorProtocol {
    
    func detailInputGetUser(id: Int) {
        getUserData(id)
    }
    
    func detailInputDeleteUser(id: Int) {
        deleteUserData(id)
    }
    
    func detailInputUpdateUser(currentUser: User?, name: String?, date: Date?, time: Date?) {
        if let user = currentUser {
            updateUser(user: user, name: name, date: date, time: time)
        } else {
            let newName = name ?? "Name"
            let newDate = date ?? Date()
            let newTime = time ?? Date()
            createUser(name: newName, date: newDate, time: newTime)
        }
    }
    
    func detailInputGetEmptyItems() {
        getEmptyItems()
    }
}
