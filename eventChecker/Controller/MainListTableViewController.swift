import UIKit

final class MainListTableViewController: UITableViewController {
    // MARK: - Constants
    private let backgroundShadow = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)

    // MARK: - Properties
    private var users: [User] = [] {
    didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = UserManager.instance.getUsersFromUserDefaults()
    }

    // MARK: - Setups
    private func setupTableView() {
        tableView.register(UINib(nibName: "PersonInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonInfoTableViewCell")
        tableView.backgroundColor = backgroundShadow
        tableView.separatorStyle = .none
    }
    
    private func setupNavigationController() {
        title = "Birthdays List"
        navigationController?.navigationBar.prefersLargeTitles = true
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openScreenForSaveVCDidTapped))
        plusButton.tintColor = .black
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(openTrashTableVCDidTapped))
        trashButton.tintColor = .systemRed
        let kebabButton = UIBarButtonItem(title: "\u{FE19}", style: .plain, target: self, action: #selector(openSсreenForSettingsVCDidTapped))
        kebabButton.tintColor = .black
        navigationItem.rightBarButtonItems = [kebabButton, plusButton]
        navigationItem.leftBarButtonItem = trashButton
    }
    
    // MARK: - Actions
    // MARK: Objc Methods
    @objc private func openScreenForSaveVCDidTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ScreenForSaveViewController = storyboard.instantiateViewController(withIdentifier: "ScreenForSaveViewController")
        navigationController?.pushViewController(ScreenForSaveViewController, animated: true)
    }
    
    @objc private func openTrashTableVCDidTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let TrashTableViewController = storyboard.instantiateViewController(withIdentifier: "TrashTableViewController")
        navigationController?.pushViewController(TrashTableViewController, animated: true)
    }
    
    @objc private func openSсreenForSettingsVCDidTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ScreenForSettingsViewController = storyboard.instantiateViewController(withIdentifier: "ScreenForSettingsViewController")
        navigationController?.pushViewController(ScreenForSettingsViewController, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfoTableViewCell", for: indexPath) as! PersonInfoTableViewCell
        cell.configure(using: users[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .normal, title:  "Move to Trash", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            UserManager.instance.saveDeletedUserToUserDefaults(deletedUser: self.users.remove(at: indexPath.row))
            UserManager.instance.updateUsersFromUserDefaults(updatedUsers: self.users)
        })
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
