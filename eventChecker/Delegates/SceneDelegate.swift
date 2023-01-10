import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    var window: UIWindow?

    // MARK: - UIScene
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) { }

    func sceneDidEnterBackground(_ scene: UIScene) { (UIApplication.shared.delegate as? AppDelegate)?.saveContext() }
}
