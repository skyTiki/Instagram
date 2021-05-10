//
//  Comment.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/05/10.
//

import Foundation
import Firebase

class Comment {
    var id: String
    var content: String?
    var name: String?
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        
        let commentDic = document.data()
        self.name = commentDic["name"] as? String
        self.content = commentDic["content"] as? String
    }
}
