//
//  GroupsVC.swift
//  SpeakEasy
//
//  Created by Raajitha Vardhanapu on 11/24/23.
//

import UIKit
import CometChatUIKitSwift

class GroupsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cometChatConversationsWithMessages = CometChatConversationsWithMessages()
        cometChatConversationsWithMessages.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.pushViewController(cometChatConversationsWithMessages, animated: true)
    }
    
}
