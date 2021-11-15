import Foundation

let dateFormatter = DateFormatter()

// MARK: - Constructs
class User: Codable {
    let name: String
    let surname: String
    let date: Date
    
    internal init(name: String, surname: String, date: Date) {
        self.name = name
        self.surname = surname
        self.date = date
    }
}

// MARK: - Construct extensions
extension User: CustomStringConvertible {
    var description: String {
        dateFormatter.dateStyle = .long
        return "\(dateFormatter.string(from: date))"
    }
}
