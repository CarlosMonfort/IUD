//
//  MainProtocols.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

protocol MainViewProtocol: class {
    // Presenter -> View
    func mainViewUpdateUsers(with users: [User])
    func mainViewError(error: APIError)
}

protocol MainPresenterProtocol: class {
    // View -> Presenter
    var view: MainViewProtocol? { get set }
    var interactor: MainInputInteractorProtocol? { get set }
    var wireframe: MainWireframeProtocol? { get set }
    
    func mainPresenterViewDidLoad(from view: MainViewController)
    func mainPresenterViewWillAppear()
    func mainPresenterGetUsers()
    func mainPresenterPresentDetail(from user: User?)
}

protocol MainInputInteractorProtocol: class {
    // Presenter -> Interactor
    var presenter: MainOutputInteractorProtocol? { get set }
    
    func mainInputGetUsers()
}

protocol MainOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func mainOutputUsersDataFetched(users: [User])
    func mainOutputError(error: APIError)
}

protocol MainWireframeProtocol: class {
    // Presenter -> Wireframe
    static func mCreateMainModule() -> UIViewController
    func mainWirePresentDetail(from view: UIViewController, with user: User?)
}
