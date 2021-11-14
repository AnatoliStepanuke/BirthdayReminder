import Foundation

let dateFormatter = DateFormatter()

struct User {
    let name: String
    let surname: String
    let date: Date
    
    func userInfoToString() -> String {
        dateFormatter.dateStyle = .long
        return "\(name) \(surname) \(dateFormatter.string(from: date))"
    }
}
