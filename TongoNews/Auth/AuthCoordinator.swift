//
//  AuthCoordinator.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit

protocol AuthCoordinatorType: CoordinatorType {
    
}

final class AuthCoordinator: AuthCoordinatorType {
    func asRoutable() -> UIViewController {
        return UIViewController()
    }
    
    func start() {
        
    }
}
