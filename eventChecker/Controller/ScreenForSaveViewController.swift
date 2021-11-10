import UIKit

final class ScreenForSaveViewController: UIViewController {
    // MARK: - Constants
    let backgroundShadow = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    
    //MARK: - Outlets
    @IBOutlet weak private var enterInfoLabel: UILabel!
    @IBOutlet weak private var nameField: UITextField!
    @IBOutlet weak private var surnameField: UITextField!
    @IBOutlet weak private var datePicker: UIDatePicker!
    @IBOutlet weak private var saveButton: UIButton!
    
    //MARK: - Actions
    @IBAction private func datePickerAction(_ sender: Any) {
        datePicker.addTarget(self, action: #selector(datePickerDidTapped(sender:)), for: UIControl.Event.valueChanged)
    }
    
    @IBAction private func saveButtonAction(_ sender: Any) {
        let saveName = nameField.text!
        let saveSurname = surnameField.text!
        print(saveName + " " + saveSurname)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationController()
        setupEnterInfoLabel()
        setupFields()
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
    
    //MARK: Objc Methods
    @objc private func datePickerDidTapped(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        let saveDate = dateFormatter.string(from: datePicker.date)
        print(saveDate)
    }
}
