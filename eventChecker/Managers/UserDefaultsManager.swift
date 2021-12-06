import Foundation

final class UserManager {
    // MARK: - Constants
    // MARK: - Private
    private let defaults = UserDefaults.standard
    
    // MARK: - Public
    static let instance = UserManager()
    
    // MARK: - Init
    private init(){ }
    
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
    
    func saveUserToUserDefaults(item: User) {
        var users = getUsersFromUserDefaults()
        users.append(item)
        encode(users: users, key: Constants.UserDefaults.userList)
    }
        
    func getUsersFromUserDefaults() -> [User] {
        decode(key: Constants.UserDefaults.userList)
    }
    
    func updateUsersFromUserDefaults(updatedUsers: Array<User>) {
        var users = getUsersFromUserDefaults()
        users = updatedUsers
        encode(users: users, key: Constants.UserDefaults.userList)
    }
    
    func saveDeletedUserToUserDefaults(item: User) {
        var deletedUsers = getDeletedUsersFromUserDefautls()
        deletedUsers.append(item)
        encode(users: deletedUsers, key: Constants.UserDefaults.deleteUserList)
    }
    
    func getDeletedUsersFromUserDefautls() -> [User] {
        decode(key: Constants.UserDefaults.deleteUserList)
    }
    
    func updateDeletedUsersFromUserDefaults(updatedDeletedUsers: Array<User>) {
        var deletedUsers = getDeletedUsersFromUserDefautls()
        deletedUsers = updatedDeletedUsers
        encode(users: deletedUsers, key: Constants.UserDefaults.deleteUserList)
    }
}
