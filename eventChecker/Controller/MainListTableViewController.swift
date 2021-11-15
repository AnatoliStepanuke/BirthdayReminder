import UIKit

final class MainListTableViewController: UITableViewController {
    // MARK: - Constants
    private let backgroundShadow = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    
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
        navigationItem.rightBarButtonItem = plusButton
        plusButton.tintColor = .black
    }
    
    // MARK: - Actions
    // MARK: Objc Methods
    @objc private func openScreenForSaveVCDidTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ScreenForSaveViewController = storyboard.instantiateViewController(withIdentifier: "ScreenForSaveViewController")
        navigationController?.pushViewController(ScreenForSaveViewController, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfoTableViewCell", for: indexPath) as! PersonInfoTableViewCell
        if let decodedData = UserDefaults.standard.data(forKey: "userList"),
           let user = try? JSONDecoder().decode(User.self, from: decodedData) {
            cell.configure(using: user)
        }
        
        return cell
    }
}
