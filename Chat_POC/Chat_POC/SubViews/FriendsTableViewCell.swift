//
//  FriendsTableViewCell.swift
//  Chat_POC
//
//  Created by Vikram Batra on 27/01/22.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(forFriend friendDict: [String : ConversationModel]) {
        self.nameLabel.text = friendDict.keys.first
        self.messageLabel.text = friendDict.values.first?.message
    }
}
