import UIKit

final class ScreenForStoringDeletedUsersTableViewController: UITableViewController {
    //MARK: - Constants
    private let backgroundShadow = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    
    //MARK: - Properties
    private var deletedUsers: [String] = ["dsd", "dfdf", "fdfdfd"] {
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
    
    // MARK: - Setups
    private func setupTableView() {
        tableView.register(UINib(nibName: "PersonInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonInfoTableViewCell")
        tableView.backgroundColor = backgroundShadow
        tableView.separatorStyle = .none
    }
    
    private func setupNavigationController() {
        title = "Deleted Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deletedUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfoTableViewCell", for: indexPath) as! PersonInfoTableViewCell
//        cell.configure(using: deletedUsers[indexPath.row])
        
        return cell
    }
}
