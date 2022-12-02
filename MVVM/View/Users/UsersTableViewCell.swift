import UIKit
class UsersTableViewCell : UITableViewCell {
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var urLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func bind(user: UserModel){
        loginLabel.text = user.login
        urLabel.text = user.html_url
    }
}
