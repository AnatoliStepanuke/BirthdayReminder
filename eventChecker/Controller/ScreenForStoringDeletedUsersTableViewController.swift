import UIKit

final class ScreenForStoringDeletedUsersTableViewController: UITableViewController {
    //MARK: - Constants
    private let backgroundShadow = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    
    //MARK: - Properties
    private var deletedUsers: [User] = [] {
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
        deletedUsers = UserManager.instance.getDeletedUsersFromUserDefautls()
    }
    
    // MARK: - Setups
    private func setupTableView() {
        tableView.register(UINib(nibName: "PersonInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonInfoTableViewCell")
        tableView.backgroundColor = backgroundShadow
        tableView.separatorStyle = .none
    }
    
    private func setupNavigationController() {
        title = "Garbage"
        navigationController?.navigationBar.prefersLargeTitles = true
        let deleteAll = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(deleteAllUsersInGarbage))
        deleteAll.tintColor = .red
        navigationItem.rightBarButtonItem = deleteAll
    }
    
    // MARK: - Actions
    // MARK: Objc Methods
    @objc private func deleteAllUsersInGarbage() {
        deletedUsers.removeAll()
        UserManager.instance.updateDeletedUsersFromUserDefaults(updatedDeletedUsers: deletedUsers)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deletedUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfoTableViewCell", for: indexPath) as! PersonInfoTableViewCell
        cell.configure(using: deletedUsers[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UserManager.instance.updateDeletedUsersFromUserDefaults(updatedDeletedUsers: deletedUsers)
        }
        
//        if editingStyle == .insert {
//
//        }
    }
}
