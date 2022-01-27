//
//  FriendsViewController.swift
//  Chat_POC
//
//  Created by Vikram Batra on 27/01/22.
//

import UIKit

class FriendsViewController: UITableViewController, SendIndexDelegateProtocol {
   
    var friends : [[String : ConversationModel]]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friends = LocalStorage.sharedInstance.getMessageThreads()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FriendsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell") as! FriendsTableViewCell
        cell.configureCell(forFriend: friends[indexPath.row])
       return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let conversationViewController = storyBoard.instantiateViewController(withIdentifier: "ConversationViewController") as! ConversationViewController
        conversationViewController.delegate = self
        conversationViewController.friendDetails = (friends[indexPath.row].keys.first!, indexPath.row)
        self.navigationController?.pushViewController(conversationViewController, animated: true)
    }
    
    func selectedIndex(index: Int) {
        friends = LocalStorage.sharedInstance.getMessageThreads()
        let indexPath = IndexPath(item: index, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
