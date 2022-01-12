import UIKit
import UserNotifications

final class ScreenForSaveViewController: UIViewController {
    // MARK: - Constants
    private let gregorianCalendar = Calendar.init(identifier: .gregorian)
    private var dateComponents = DateComponents()
    private let date = Date()
    
    // MARK: - Outlets
    @IBOutlet weak private var enterInfoLabel: UILabel!
    @IBOutlet weak private var nameField: UITextField!
    @IBOutlet weak private var surnameField: UITextField!
    @IBOutlet weak private var datePicker: UIDatePicker!
    @IBOutlet weak private var timePicker: UIDatePicker!
    @IBOutlet weak private var saveButton: UIButton!
    
    // MARK: - Actions
    @IBAction private func saveButtonAction(_ sender: Any) {
        let saveName = nameField.text!
        let saveSurname = surnameField.text!
        let selectedDate = datePicker.date
        let selectedTime = timePicker.date
        
        if (saveName.isEmpty) || (saveSurname.isEmpty) {
            alertEmptyField(title: "Attention", message: "Please, fill all fields")
        } else {
            let user = User(name: saveName, surname: saveSurname, dateOfBirth: selectedDate, timeOfNotification: selectedTime)
            UserManager.instance.saveUserToUserDefaults(user: user)
            NotificationManager.instance.createNotification(user: user)
            alertSucceededSaving(title: "Saving succeeded", message: "")
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationController()
        setupFields()
        setupDatePicker()
        setupSaveButton()
    }
    
    // MARK: - Setups
    private func setupView() {
        view.backgroundColor = AppColor.shadow
    }
    
    private func setupNavigationController() {
        title = "New Info"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupFields() {
        nameField.roundedTextField()
        surnameField.roundedTextField()
        nameField.backgroundColorTextField()
        surnameField.backgroundColorTextField()
    }
    
    private func setupSaveButton() {
        saveButton.roundedButton()
        saveButton.backgroundColorButton()
        saveButton.setTitle("Save", for: .normal)
    }
    
    private func setupDatePicker() {
        dateComponents.year = -100
        let minDate = gregorianCalendar.date(byAdding: dateComponents, to: date)
        datePicker.minimumDate = minDate
        dateComponents.year = 0
        let maxDate = gregorianCalendar.date(byAdding: dateComponents, to: date)
        datePicker.maximumDate = maxDate
    }
    
    // MARK: - Helpers
    private func alertEmptyField(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func alertSucceededSaving(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Touche responders
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Deinit
    deinit {
        print("ScreenForSaveViewController is deleted")
    }
}
