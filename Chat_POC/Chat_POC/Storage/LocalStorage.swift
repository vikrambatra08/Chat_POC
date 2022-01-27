//
//  Storage.swift
//  Chat_POC
//
//  Created by Vikram Batra on 27/01/22.
//

import Foundation

class LocalStorage {

    static let sharedInstance = LocalStorage()

    private init() {}

    private var localData : [String:[ConversationModel]]!
    
    public func getMessageThreads() -> [[String : ConversationModel]] {
        return self.getLocalData().map{[$0.key : $0.value.last]}
    }
    
    public func getConversation(forFriend name: String) -> [ConversationModel]? {
        guard let conversations = self.getLocalData()[name] else { return nil}
        return conversations
    }

    public func updateConversation(forFriend friend: String, withConversation conversation: ConversationModel) {
        self.localData[friend]?.append(conversation)
    }

    private func getLocalData() -> [String:[ConversationModel]] {
        if localData == nil {
            localData = self.getExistingData()
        }
        return localData
    }

    //Exisitng hardocded data
    private func getExistingData() -> [String:[ConversationModel]] {

        var hardcodedData : [String:[ConversationModel]] = [:]

        //Existing Jone's conversation
        var joneConversation : [ConversationModel] = [ConversationModel]()
        joneConversation.append(ConversationModel(message: "How are you?", type: .Sender))
        joneConversation.append(ConversationModel(message: "How are you?", type: .Receiver))
        joneConversation.append(ConversationModel(message: "Good", type: .Sender))
        joneConversation.append(ConversationModel(message: "Good", type: .Receiver))
        hardcodedData["Jone"] = joneConversation

        //Existing Kent's conversation
        var kentConversation : [ConversationModel] = [ConversationModel]()
        kentConversation.append(ConversationModel(message: "Hello", type: .Sender))
        kentConversation.append(ConversationModel(message: "Hello", type: .Receiver))
        hardcodedData["Kent"] = kentConversation
        
        return hardcodedData
    }
}

extension Array {
    var last: ConversationModel {
        return self[self.endIndex - 1] as! ConversationModel
    }
}
