//
//  PostData.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/04/27.
//

import Foundation
import Firebase

class PostData {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.name = postDic["name"] as? String
        
        self.caption = postDic["caption"] as? String
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        
        if let myid = Auth.auth().currentUser?.uid {
            // likesの中に自分のidが含まれている場合（いいねしているかどうか）
            if self.likes.contains(myid) {
                self.isLiked = true
            }
        }
        
    }
}
