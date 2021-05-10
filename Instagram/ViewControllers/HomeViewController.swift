//
//  HomeViewController.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/04/15.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 投稿データ
    var postArray: [PostData] = []
    
    // データ更新時の監視用
    var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // xib 登録
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser != nil {
            // listnerを登録して投稿データを監視
            let postsRef = Firestore.firestore().collection(Const.PostPath).order(by: "date", descending: true)
            listener = postsRef.addSnapshotListener({ (querySnapshot, error) in
                if let error = error {
                    print("snapShotの取得に失敗しました。", error.localizedDescription)
                }
                
                self.postArray = querySnapshot!.documents.map({ document in
                    let postData = PostData(document: document)
                    return postData
                })
                
                self.tableView.reloadData()
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        listener?.remove()
    }
    
    
    // MARK: - TableViewDelegate, DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
        cell.setPostData(postArray[indexPath.row])
        cell.likeButton.addTarget(self, action: #selector(handleButton(_:forEvent:)), for: .touchUpInside)
        cell.commentButton.addTarget(self, action: #selector(handleCommentButton(_:forEvent:)), for: .touchUpInside)
        return cell
    }
    
    @objc func handleButton(_ sender: UIButton, forEvent event: UIEvent) {
        
        // タップ場所からテーブルのIndexPath取得
        let touch = event.allTouches?.first
        let point = touch!.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: point)!
        
        
        let postData = postArray[indexPath.row]
        
        // 更新処理
        if let myId = Auth.auth().currentUser?.uid {
            // 更新用のデータ
            var updateValue: FieldValue
            
            // すでにいいねしているかどうか判定
            if postData.isLiked {
                updateValue = FieldValue.arrayRemove([myId])
            } else {
                updateValue = FieldValue.arrayUnion([myId])
            }
            
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            postRef.updateData(["likes" : updateValue])
            
        }
    }
    
    // コメント入力ボタン
    @objc func handleCommentButton(_ sender: UIButton, forEvent event: UIEvent) {
        
        // セルの特定
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: point)!
        
        let cell = tableView.cellForRow(at: indexPath) as! PostTableViewCell
        
        guard let commentContent = cell.commentTextField.text else { return }
        
        HUD.show()
        
        let commentRef = Firestore.firestore().collection(Const.CommentPath).document()
        
        guard let userName = Auth.auth().currentUser?.displayName else { return }
        
        let comment = [
            "id" : postArray[indexPath.row].id,
            "name" : userName,
            "content" : commentContent
        ]
        
        commentRef.setData(comment)
        
        cell.commentTextField.text = ""
        cell.commentTextField.endEditing(true)
        
        HUD.showSuccess(withStatus: "コメントの投稿に成功しました")
        
    }
}
