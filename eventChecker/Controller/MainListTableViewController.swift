import UIKit

final class MainListTableViewController: UITableViewController {
    // MARK: - Properties
    private var users: [User] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle 
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
        tableView.register(UINib(
            nibName: "PersonInfoTableViewCell",
            bundle: nil
        ), forCellReuseIdentifier: "PersonInfoTableViewCell")
        tableView.backgroundColor = AppColor.shadow
        tableView.separatorStyle = .none
    }

    private func setupNavigationController() {
        title = "Birthdays List"
        navigationController?.navigationBar.prefersLargeTitles = true
        let plusButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(openScreenForSaveVCDidTapped)
        )
        plusButton.tintColor = AppColor.plusButtonColor
        let trashButton = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(openTrashTableVCDidTapped)
        )
        trashButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = plusButton
        navigationItem.leftBarButtonItem = trashButton
    }

    // MARK: - Actions
    // MARK: Objc Methods
    @objc private func openScreenForSaveVCDidTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screenForSaveViewController = storyboard.instantiateViewController(
            withIdentifier: "ScreenForSaveViewController"
        )
        navigationController?.pushViewController(screenForSaveViewController, animated: true)
    }

    @objc private func openTrashTableVCDidTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let trashTableViewController = storyboard.instantiateViewController(withIdentifier: "TrashTableViewController")
        navigationController?.pushViewController(trashTableViewController, animated: true)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PersonInfoTableViewCell",
            for: indexPath
        ) as? PersonInfoTableViewCell else {
            fatalError("DequeueReusableCell failed while casting.")
        }
        cell.configure(using: users[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .normal,
            title: "Move to Trash",
            handler: { (_:UIContextualAction, _:UIView, _:(Bool) -> Void) in
            UserManager.instance.saveDeletedUserToUserDefaults(deletedUser: self.users.remove(at: indexPath.row))
            UserManager.instance.updateUsersFromUserDefaults(updatedUsers: self.users)
        })
        deleteAction.backgroundColor = .systemRed

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
