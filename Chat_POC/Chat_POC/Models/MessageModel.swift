//
//  Model.swift
//  Chat_POC
//
//  Created by Vikram Batra on 27/01/22.
//

import Foundation

enum MessageType {
   case Sender
   case Receiver
}

struct ConversationModel {
    var message : String!
    var type : MessageType!
    
    init(message: String, type: MessageType) {
        self.message = message
        self.type = type
    }
}
