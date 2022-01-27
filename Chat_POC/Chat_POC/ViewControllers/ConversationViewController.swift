//
//  ConversationViewController.swift
//  Chat_POC
//
//  Created by Vikram Batra on 27/01/22.
//

import UIKit

protocol SendIndexDelegateProtocol {
    func selectedIndex(index: Int)
}

class ConversationViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    var conversations : [ConversationModel]!
    var friendDetails: (String, Int) = ("",0)
    var delegate: SendIndexDelegateProtocol? = nil
    var isConversationUpdated: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = friendDetails.0
        conversations = LocalStorage.sharedInstance.getConversation(forFriend: friendDetails.0)
    }

    override func viewWillDisappear(_ animated: Bool) {
        if isConversationUpdated && self.delegate != nil {
            self.delegate?.selectedIndex(index: friendDetails.1)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.conversations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let conversation = conversations[indexPath.item]

        if conversation.type == .Sender {
            let cell : SenderCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "SenderCollectionViewCell", for: indexPath) as? SenderCollectionViewCell)!
            cell.senderNameLabel.text = "Me" //ToDo : should come from constants
            cell.senderMessageLabel.text = conversation.message
            return cell
        } else {
            let cell : ReceiverCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ReceiverCollectionViewCell", for: indexPath) as? ReceiverCollectionViewCell)!
            cell.receiverNameLabel.text = friendDetails.0
            cell.receiverMessageLabel.text = conversation.message
            return cell
        }
    }

    @IBAction func sendButtonAction(_ sender: Any) {
        //Sender
        //TODO : Add textfield validations
        self.updateConversation(withMessage: self.messageTextField.text!, andMessageType: .Sender)
        //Receiver
        self.updateConversation(withMessage: self.messageTextField.text!, andMessageType: .Receiver)

        conversations = LocalStorage.sharedInstance.getConversation(forFriend: friendDetails.0)
        self.collectionView.reloadData()
        self.isConversationUpdated = true
    }

    private func updateConversation(withMessage message: String, andMessageType messageType: MessageType) {
        LocalStorage.sharedInstance.updateConversation(forFriend: friendDetails.0, withConversation: ConversationModel(message: message, type: messageType))
    }
}
