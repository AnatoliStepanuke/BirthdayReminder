import Foundation

let dateFormatter = DateFormatter()

struct User {
    let name: String
    let surname: String
    let date: Date
}

extension User: CustomStringConvertible {
    var description: String {
        dateFormatter.dateStyle = .long
        return "\(name) \(surname) \(dateFormatter.string(from: date))"
    }
}
