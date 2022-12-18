//
//  SceneDelegate.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

/**
 Token para simular a authenticação de um usuário
 (ou você pode implementar a funcionalidade de login futuramente 😎🚀)
 
 * Você pode obter um novo token em https://casadocodigo-api.herokuapp.com/swagger-ui/index.html#/authentication-controller/authenticateUsingPOST utilizando as credenciais abaixo
 
 * * email: "admin@casadocodigo.com.br"
 * * senha: "123456"
 */
let tokenValue = "eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJDYXNhIGRvIEPDs2RpZ28gQVBJIiwic3ViIjoiMiIsImlhdCI6MTY3MTI5NzQ2NSwiZXhwIjoxNjcxOTAyMjY1fQ.0UzD1zdhUZMzcFTVTkyDJslJctl3IZCfZ23zBmxMKmg"

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // MARK: - simulação de um login
        let authentication = Authentication(
            token: tokenValue,
            user: .init(
                id: nil,
                email: "admin@casadocodigo.com.br",
                fullName: "Admin da Casa"
            )
        )
        
        let userAuthentication = UserAuthentication()
        userAuthentication.set(authentication)
        
        // MARK: - Setup
        let autoresAPI = AutoresAPI()
        let livrosAPI = LivrosAPI()
        
        let tabBarController = window!.rootViewController as! UITabBarController
        
        let livrosListViewController = (tabBarController.viewControllers![0] as! UINavigationController).topViewController as! LivrosListViewController
        livrosListViewController.livrosAPI = livrosAPI
        
        let autoresListViewController = (tabBarController.viewControllers![1] as! UINavigationController).viewControllers.first as! AutoresListViewController
        
        autoresListViewController.autoresAPI = autoresAPI
        autoresListViewController.livrosAPI = livrosAPI
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
