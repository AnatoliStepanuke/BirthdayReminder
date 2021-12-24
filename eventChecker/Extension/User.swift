import Foundation
import UIKit

// MARK: - Constructs
struct User: Codable {
    let name: String
    let surname: String
    let dateOfBirth: Date
    let timeOfNotification: Date
    var id: String = UUID().uuidString
}

// MARK: - Construct extensions
extension User: CustomStringConvertible {
    var description: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let message = """
        name - \(name)
        surname - \(surname)
        date - \(dateFormatter.string(from: dateOfBirth))
        """
        return message
    }
    
    var dateDescription: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: dateOfBirth)
    }
}
