//
//  WindowAnimationsTransition.swift
//  StateMachine
//
//  Created by Anar Guseynov on 11.02.2020.
//  Copyright © 2020 Anar Guseynov. All rights reserved.
//

import Foundation
import UIKit

struct TransitionOptions {
    enum Curve {
        case linear
        case easeIn
        case easeOut
        case easeInOut
        
        var timingFunction: CAMediaTimingFunction {
            switch self {
            case .linear: return CAMediaTimingFunction(name: .linear)
            case .easeIn: return CAMediaTimingFunction(name: .easeIn)
            case .easeOut: return CAMediaTimingFunction(name: .easeOut)
            case .easeInOut: return CAMediaTimingFunction(name: .easeInEaseOut)
            }
        }
    }
    
    enum Direction {
        case fade
        case toTop
        case toBottom
        case toLeft
        case toRight
        
        func transition(with type: CATransitionType = .push) -> CATransition {
            let transition = CATransition()
            switch self {
            case .fade:
                transition.type = .fade
                transition.subtype = nil
            case .toBottom:
                transition.type = type
                transition.subtype = .fromBottom
            case .toLeft:
                transition.type = type
                transition.subtype = .fromLeft
            case .toRight:
                transition.type = type
                transition.subtype = .fromRight
            case .toTop:
                transition.type = type
                transition.subtype = .fromTop
            }
            return transition
        }
    }
    
    var duration: TimeInterval
    var direction: Direction
    var style: Curve
    var transitionType: CATransitionType
    
    var animateTransition: CATransition {
        let transition = direction.transition(with: self.transitionType)
        transition.duration = duration
        transition.timingFunction = style.timingFunction
        return transition
    }
    
    static let `default` = TransitionOptions(duration: 0.2, direction: .fade, style: .linear, transitionType: .fade)
}

extension UIWindow {
    func changeRootViewController(vc: UIViewController?, options: TransitionOptions = .default, completion: @escaping () -> Void) {
        self.layer.add(options.animateTransition, forKey: "kCATransition")
        self.rootViewController = vc
        self.makeKeyAndVisible()
        completion()
    }
}

