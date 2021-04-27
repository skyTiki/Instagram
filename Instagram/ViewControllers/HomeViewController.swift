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
        
        return cell
    }
}
