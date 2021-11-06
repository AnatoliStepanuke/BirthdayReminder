import UIKit

final class PersonInfoTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var surnameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    // MARK: - Lyfecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        backgroundColor = .clear
        selectionStyle = .none
    }
}
