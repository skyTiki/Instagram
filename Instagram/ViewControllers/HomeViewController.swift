//
//  HomeViewController.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/04/15.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 投稿データ
    var postArray: [PostData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // xib 登録
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
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
