import Foundation

let dateFormatter = DateFormatter()

// MARK: - Constructs
struct User: Codable {
    let name: String
    let surname: String
    let date: Date
}

// MARK: - Construct extensions
extension User: CustomStringConvertible {
    var description: String {
        dateFormatter.dateStyle = .long
        return "\(dateFormatter.string(from: date))"
    }
}
