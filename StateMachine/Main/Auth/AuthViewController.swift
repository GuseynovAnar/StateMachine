//
//  AuthViewController.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class AuthViewController: UIViewController {
    private lazy var userName = UILabel().style {
        $0.backgroundColor = UIColor.lightGray
        $0.contentMode = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.layer.cornerRadius = 10
    }
    private lazy var password = UILabel().style {
        $0.backgroundColor = UIColor.lightGray
        $0.contentMode = .center
        $0.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        $0.layer.cornerRadius = 10
    }
       
    private lazy var button = UIButton().style {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        $0.tintColor = UIColor.blue
        $0.layer.cornerRadius = 10
        $0.backgroundColor = store.state.authorized ? UIColor.green : UIColor.blue
        $0.text(store.state.authorized ? "login" : "start")
        $0.height(50).width(120)
        $0.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }
    
    var changeScene: (() -> Void)?
       
    private let store: AuthStore
    init(_ store: AuthStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
        observe()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
       
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
       
    private func observe() {
        store.observable.subscribe(self) { (object, state) in
            object.handleChanges(newState: state)
        }
    }
       
    private func setupView() {
        view.backgroundColor = UIColor.white
        view.sv(button, userName, password)
        view.layout(
            |-50-userName-50-|,
            10,
            |-50-password-50-|
        )
        userName.centerVertically()
        button.Bottom == view.Bottom - 50
        button.centerHorizontally()
    }
       
    private func handleChanges(newState: AuthState) {
        button.text(newState.authorized ? "login" : "start")
        button.backgroundColor = newState.authorized ? UIColor.green : UIColor.blue
        userName.text = newState.name
        password.text = newState.password
    }
    
    @objc private func pressButton() {
        if store.state.authorized {
            store.logout()
            changeScene?()
            changeScene = nil
        } else {
            store.login()
        }
    }
}
