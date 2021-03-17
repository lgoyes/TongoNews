//
//  SceneDelegate.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    lazy var applicationCoordinator: AnyCoordinator<ApplicationCoordinator.Node> = {
        let coordinator = ApplicationCoordinator(navigationController: UINavigationController())
        return coordinator
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let appWindow = UIWindow(windowScene: windowScene)
        appWindow.rootViewController = applicationCoordinator.getRoutable()
        appWindow.makeKeyAndVisible()
        
        self.window = appWindow
        
        do {
            try applicationCoordinator.start()
        } catch {
            #if DEBUG
            if !isTestRunning() {
                assertionFailure(error.localizedDescription)
            }
            #endif
        }
    }
    
    private func isTestRunning() -> Bool {
        return SystemConfig.current == .test
    }
}
