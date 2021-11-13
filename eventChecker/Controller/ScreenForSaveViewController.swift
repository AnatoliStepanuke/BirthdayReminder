import UIKit

final class ScreenForSaveViewController: UIViewController {
    // MARK: - Constants
    private let backgroundShadow = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    private let dateFormatter = DateFormatter()
    
    //MARK: - Outlets
    @IBOutlet weak private var enterInfoLabel: UILabel!
    @IBOutlet weak private var nameField: UITextField!
    @IBOutlet weak private var surnameField: UITextField!
    @IBOutlet weak private var datePicker: UIDatePicker!
    @IBOutlet weak private var saveButton: UIButton!
    
    //MARK: - Actions
    @IBAction private func saveButtonAction(_ sender: Any) {
        let saveName = nameField.text!
        let saveSurname = surnameField.text!
        let selectedDate = dateFormatter.string(from: datePicker.date)
        print(saveName + " " + saveSurname + " " + "\(selectedDate)")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationController()
        setupEnterInfoLabel()
        setupFields()
        setupDateStyle()
        setupSaveButton()
    }
    
    //MARK: - Setups
    private func setupView() {
        view.backgroundColor = backgroundShadow
    }
    
    private func setupNavigationController() {
        title = "New Info"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupEnterInfoLabel() {
        enterInfoLabel.backgroundColor = .white
        enterInfoLabel.layer.masksToBounds = true
        enterInfoLabel.layer.cornerRadius = 16
    }
    
    private func setupFields() {
        nameField.roundedTextField()
        surnameField.roundedTextField()
    }
    
    private func setupSaveButton() {
        saveButton.roundedButton()
        saveButton.backgroundColor = .white
    }
    
    private func setupDateStyle() {
        dateFormatter.dateStyle = DateFormatter.Style.medium
    }
}
