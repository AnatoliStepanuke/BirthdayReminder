import Foundation
import UserNotifications

final class NotificationManager {
    // MARK: - Constants
    // MARK: - Private
    private let content = UNMutableNotificationContent()
    private let center = UNUserNotificationCenter.current()
    
    // MARK: - Public
    static let instance = NotificationManager()
    
    // MARK: - Init
    private init(){ }
    
    // MARK: - Setups
    private func setupContentNotification(user: User) {
        let message = "Today \(user.name) \(user.surname) is celebrating birthday!"
        content.body = message
        content.sound = UNNotificationSound.default
    }
    
    private func setupTriggerNotification(user: User) -> UNCalendarNotificationTrigger {
        var date = Calendar.current.dateComponents([.month, .day], from: user.date)
        let time = Calendar.current.dateComponents([.hour, .minute], from: user.time)
        date.hour = time.hour
        date.minute = time.minute
        return UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
    }
    
    private func setupRequestNotification(user: User) {
        let request = UNNotificationRequest(identifier: user.id, content: content, trigger: setupTriggerNotification(user: user))
        center.add(request, withCompletionHandler: nil)
    }
        
    // MARK: - Helpers
    func createNotification(user: User) {
        setupContentNotification(user: user)
        setupRequestNotification(user: user)
    }
    
    func deleteNotification(user: User) {
        center.removePendingNotificationRequests(withIdentifiers: [user.id])
    }
    
    func restoreDeletedNotification(user: User) {
        setupRequestNotification(user: user)
    }
}
