import Foundation

class UserManager {
    // MARK: - Constants
    // MARK: - Private
    private let defaults = UserDefaults.standard
    
    // MARK: - Public
    static let instance = UserManager()
    
    // MARK: - Init
    private init(){ }
    
    // MARK: - Helpers
    private func encode(users: [User]) {
        if let encodedData = try? JSONEncoder().encode(users) {
            return defaults.setValue(encodedData, forKey: Constants.UserDefaults.userList)
        }
    }
    
    private func decode() -> [User] {
        if let decodedData = defaults.data(forKey: Constants.UserDefaults.userList) {
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
        encode(users: users)
    }
        
    func getUsersFromUserDefaults() -> [User] {
        decode()
    }
    
    func updateUsersFromUserDefaults(updatedUsers: Array<User>) {
        var users = getUsersFromUserDefaults()
        users = updatedUsers
        encode(users: users)
    }
}
