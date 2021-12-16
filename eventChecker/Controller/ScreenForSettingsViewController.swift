import Foundation
import UIKit

final class ScreenForSettingsViewController: UIViewController {
    //MARK: - Constants
    private let backgroundShadow = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    
    //MARK: - Outlets
    //MARK: - Actions
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationController()
    }
    
    // MARK: - Setups
    private func setupView() {
        view.backgroundColor = backgroundShadow
    }
    
    private func setupNavigationController() {
        title = "Settings"
    }
}
