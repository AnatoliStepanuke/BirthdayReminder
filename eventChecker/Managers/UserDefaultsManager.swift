import Foundation

struct UserManager {
    // MARK: - Constants
    // MARK: - Private
    private let defaults = UserDefaults.standard

    // MARK: - Public
    static let instance = UserManager()
    
    // MARK: - Helpers
    func saveUsersToUserDefaults(item: User) {
        var users = getUsersFromUserDefaults()
        users.append(item)
        if let encodedData = try? JSONEncoder().encode(users) {
            defaults.setValue(encodedData, forKey: Constants.UserDefaults.userList)
        }
    }
    
    func getUsersFromUserDefaults() -> [User] {
        if let decodedData = defaults.data(forKey: Constants.UserDefaults.userList) {
            let users = try? JSONDecoder().decode([User].self, from: decodedData)
            if let resultUsers = users {
                return resultUsers
            }
        }
        return []
    }
    
    func deleteUsersFromUserDefaults(updatedUsers: Array<User>) {
        var users = getUsersFromUserDefaults()
        users = updatedUsers
        if let encodedData = try? JSONEncoder().encode(users) {
            defaults.setValue(encodedData, forKey: Constants.UserDefaults.userList)
        }
    }
}

enum Constants {
    enum UserDefaults {
        static let userList = "userList"
    }
}
