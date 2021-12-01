import Foundation

// MARK: - Constructs
struct User: Codable {
    let name: String
    let surname: String
    let date: Date
}

// MARK: - Construct extensions
extension User: CustomStringConvertible {
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return "\(dateFormatter.string(from: date))"
    }
}
