import UIKit

final class ScreenForSaveViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak private var enterInfoLabel: UILabel!
    @IBOutlet weak private var nameField: UITextField!
    @IBOutlet weak private var surnameField: UITextField!
    @IBOutlet weak private var saveButton: UIButton!
    
    //MARK: - Actions
    @IBAction private func datePickerDidTapper(_ sender: Any) {
    }
    @IBAction private func saveButtonDidTapped(_ sender: Any) {
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        setupNavigationController()
        setupSaveButton()
    }
    
    //MARK: - Setups
    private func setupNavigationController() {
        title = "New Info"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSaveButton() {
        saveButton.roundedbutton()
    }
}
