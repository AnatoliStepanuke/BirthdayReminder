import Foundation

final class UserManager {
    // MARK: - Constants
    // MARK: - Private
    private let defaults = UserDefaults.standard

    // MARK: - Public
    static let instance = UserManager()

    // MARK: - Init
    private init() { }

    // MARK: - Helpers
    private func encode(users: [User], key: String) {
        if let encodedData = try? JSONEncoder().encode(users) {
            return defaults.setValue(encodedData, forKey: key)
        }
    }

    private func decode(key: String) -> [User] {
        if let decodedData = defaults.data(forKey: key) {
            let users = try? JSONDecoder().decode([User].self, from: decodedData)
            if let resultUsers = users {
                return resultUsers
            }
        }
        return []
    }

    // MARK: - API
    func saveUserToUserDefaults(user: User) {
        var users = getUsersFromUserDefaults()
        users.append(user)
        encode(users: users, key: ConstantsUserDefaults.userList)
    }

    func getUsersFromUserDefaults() -> [User] {
        decode(key: ConstantsUserDefaults.userList)
    }

    func updateUsersFromUserDefaults(updatedUsers: [User]) {
        var users = getUsersFromUserDefaults()
        users = updatedUsers
        encode(users: users, key: ConstantsUserDefaults.userList)
    }

    func saveDeletedUserToUserDefaults(deletedUser: User) {
        var deletedUsers = getDeletedUsersFromUserDefautls()
        deletedUsers.append(deletedUser)
        encode(users: deletedUsers, key: ConstantsUserDefaults.deleteUserList)
        NotificationManager.instance.deleteNotification(idUser: deletedUser.id)
    }

    func getDeletedUsersFromUserDefautls() -> [User] {
        decode(key: ConstantsUserDefaults.deleteUserList)
    }

    func updateDeletedUsersFromUserDefaults(updatedDeletedUsers: [User]) {
        var deletedUsers = getDeletedUsersFromUserDefautls()
        deletedUsers = updatedDeletedUsers
        encode(users: deletedUsers, key: ConstantsUserDefaults.deleteUserList)
    }

    func restoreDeletedUserFromTrash(deletedUser: User) {
        var users = getUsersFromUserDefaults()
        users.append(deletedUser)
        encode(users: users, key: ConstantsUserDefaults.userList)
        NotificationManager.instance.restoreDeletedNotification(user: deletedUser)
    }
}
