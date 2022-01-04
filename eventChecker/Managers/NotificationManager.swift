import Foundation
import UserNotifications

final class NotificationManager {
    // MARK: - Constants
    // MARK: - Private
    private let content = UNMutableNotificationContent()
    private let center = UNUserNotificationCenter.current()
    private let calendar = Calendar.current
    
    // MARK: - Public
    static let instance = NotificationManager()
    
    // MARK: - Init
    private init(){ }
    
    // MARK: - Setups
    private func setupContentNotification(user: User) {
        let yearOfBirth = calendar.dateComponents([.year], from: user.dateOfBirth, to: Date())
        let message = "Today \(user.name) \(user.surname) is celebrating \(yearOfBirth.year!) years!"
        content.body = message
        content.sound = UNNotificationSound.default
    }
    
    private func setupTriggerNotification(user: User) -> UNCalendarNotificationTrigger {
        var date = calendar.dateComponents([.month, .day], from: user.dateOfBirth)
        let time = calendar.dateComponents([.hour, .minute], from: user.timeOfNotification)
        date.hour = time.hour
        date.minute = time.minute
        return UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
    }
    
    private func setupRequestNotification(user: User) {
        let request = UNNotificationRequest(identifier: user.id, content: content, trigger: setupTriggerNotification(user: user))
        center.add(request, withCompletionHandler: nil)
    }
        
    // MARK: - API
    func createNotification(user: User) {
        setupContentNotification(user: user)
        setupRequestNotification(user: user)
    }
    
    func deleteNotification(idUser: String) {
        center.removePendingNotificationRequests(withIdentifiers: [idUser])
    }
    
    func restoreDeletedNotification(user: User) {
        setupRequestNotification(user: user)
    }
}
