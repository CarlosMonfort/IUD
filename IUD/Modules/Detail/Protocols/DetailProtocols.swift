//
//  DetailProtocols.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

protocol DetailViewProtocol: class {
    // Presenter -> View
    func detailViewUpdateItems(items: [DetailItem])
    func detailViewPresentAlert(_ title: String, _ description: String)
    func detailViewError(error: APIError)
}

protocol DetailPresenterProtocol: class {
    // View -> Presenter
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInputInteractorProtocol? { get set }
    var wireframe: DetailWireframeProtocol? { get set }
    var user: User? { get set }
    
    func detailPresenterViewDidLoad(from view: DetailViewController)
    func detailPresenterBarBtDeletePressed()
    func detailPresenterBarBtUndoPressed()
    func detailPresenterBarBtSavePressed()
    func detailPresenterUserNameChanges(_ newName: String)
    func detailPresenterUserDateChanges(_ newDate: Date)
    func detailPresenterUserTimeChanges(_ newTime: Date)
}

protocol DetailInputInteractorProtocol: class {
    // Presenter -> Interactor
    var presenter: DetailOutputInteractorProtocol? { get set }
    
    func detailInputGetUser(id: Int)
    func detailInputDeleteUser(id: Int)
    func detailInputUpdateUser(currentUser: User?, name: String?, date: Date?, time: Date?)
    func detailInputGetEmptyItems()
}

protocol DetailOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func detailUserDataFetched(user: User?, items: [DetailItem])
    func detailProcessFinished(error: APIError?)
    func detailOutputError(error: APIError)
}

protocol DetailWireframeProtocol: class {
    // Presenter -> Wireframe
    static func dCreateDetailModule(from view: DetailViewController, with user: User?)
}
