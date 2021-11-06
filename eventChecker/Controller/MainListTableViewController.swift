import UIKit

final class MainListTableViewController: UITableViewController {
    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationController()
    }

    // MARK: - Setups
    private func setupTableView() {
        tableView.register(UINib(nibName: "PersonInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonInfoTableViewCell")
        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        tableView.separatorStyle = .none
    }
    
    private func setupNavigationController() {
        title = "Birthdays List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfoTableViewCell", for: indexPath)
        return cell
    }
}
