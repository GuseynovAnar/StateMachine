//
//  HomeViewController.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class HomeViewController: UIViewController {
    private lazy var image = UIImageView().style {
        $0.backgroundColor =  UIColor.blue
        $0.size(200)
        $0.image("avatar")
        $0.layer.cornerRadius = store.state.avatarCorner
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private lazy var button = UIButton().style {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        $0.tintColor = UIColor.blue
        $0.layer.cornerRadius = 10
        $0.backgroundColor =  UIColor.blue
        $0.text("Change Rradius")
        $0.height(50).width(200)
        $0.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }
    
    private lazy var back = UIButton().style {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        $0.tintColor = UIColor.blue
        $0.layer.cornerRadius = 10
        $0.backgroundColor =  UIColor.red
        $0.text("log_out")
        $0.height(50).width(120)
        $0.addTarget(self, action: #selector(pressBack), for: .touchUpInside)
    }
    
    private let store: HomeStore
    init(_ store: HomeStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
        observe()
    }
    
    var changeScene: (() -> Void)?
    
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
        view.sv(button, image, back)
        image.centerInContainer()
        button.Bottom == view.Bottom - 50
        button.centerHorizontally()
        back.centerHorizontally()
        back.Top == view.Top + 100
    }
    
    private func handleChanges(newState: HomeState) {
        UIView.animate(withDuration: 0.2) {
            self.image.layer.cornerRadius = newState.avatarCorner
        }
    }
    
    @objc private func pressButton() {
        if image.bounds.height / 2 == store.state.avatarCorner {
            store.drowRoundedCorners()
        } else {
            store.onCircle()
        }
    }
    
    @objc private func pressBack() {
        changeScene?()
        changeScene = nil
    }
}
