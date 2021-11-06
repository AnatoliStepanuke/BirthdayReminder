import UIKit

final class ScreenForSaveViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var enterInfoLabel: UILabel!
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var surnameField: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    //MARK: - Actions
    @IBAction private func saveButtonDidTapped(_ sender: Any) {
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }
    
    //MARK: - Setups
    private func setupNavigationController() {
        title = "New Birthday"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
