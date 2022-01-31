import UIKit

final class TrashTableViewController: UITableViewController {
    // MARK: - Properties
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
        tableView.register(UINib(
            nibName: "PersonInfoTableViewCell",
            bundle: nil
        ), forCellReuseIdentifier: "PersonInfoTableViewCell")
        tableView.backgroundColor = AppColor.shadow
        tableView.separatorStyle = .none
    }

    private func setupNavigationController() {
        title = "Trash"
        navigationController?.navigationBar.prefersLargeTitles = true
        let deleteAllButton = UIBarButtonItem(
            title: "Delete All",
            style: .plain,
            target: self,
            action: #selector(deleteAllUsersInGarbage))
        deleteAllButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = deleteAllButton
    }

    // MARK: - Actions
    // MARK: Objc Methods
    @objc private func deleteAllUsersInGarbage() {
        let alert = UIAlertController(
            title: "Do you really want to wipe out all info in Trash?",
            message: "This action is can't be reverted",
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.deletedUsers.removeAll()
            UserManager.instance.updateDeletedUsersFromUserDefaults(updatedDeletedUsers: self.deletedUsers)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deletedUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PersonInfoTableViewCell",
            for: indexPath
        ) as? PersonInfoTableViewCell else {
            fatalError("DequeueReusableCell failed while casting.")
        }
        cell.configure(using: deletedUsers[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let restoreAction = UIContextualAction(
            style: .normal,
            title: "Restore",
            handler: { (_:UIContextualAction, _:UIView, _:(Bool) -> Void) in
            UserManager.instance.restoreDeletedUserFromTrash(deletedUser: self.deletedUsers.remove(at: indexPath.row))
            UserManager.instance.updateDeletedUsersFromUserDefaults(updatedDeletedUsers: self.deletedUsers)
        })
        restoreAction.backgroundColor = .systemGreen

        return UISwipeActionsConfiguration(actions: [restoreAction])
    }

    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .normal,
            title: "Delete",
            handler: { (_:UIContextualAction, _:UIView, _:(Bool) -> Void) in
            self.deletedUsers.remove(at: indexPath.row)
            UserManager.instance.updateDeletedUsersFromUserDefaults(updatedDeletedUsers: self.deletedUsers)
        })
        deleteAction.backgroundColor = .systemRed

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    // MARK: - Deinit
    deinit {
        print("TrashTableViewController is deleted")
    }
}
