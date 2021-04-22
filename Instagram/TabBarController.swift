//
//  TabBarController.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/04/15.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // アイコン
        tabBar.tintColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        // 背景色
        tabBar.barTintColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        
        self.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ログインされていなければ、ログイン画面を表示する
        if Auth.auth().currentUser == nil {
            let loginViewController = storyboard?.instantiateViewController(identifier: "Login")
            present(loginViewController!, animated: true, completion: nil)
        }
    }
    
    // タブがタップされた時に画面切り替えをするかどうか判定する
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // カメラアイコンタップ時は独自にモーダル遷移させる
        if viewController is ImageSelectViewController {
            guard let imageSelectViewController = storyboard?.instantiateViewController(identifier: "ImageSelect") else { return false }
            present(imageSelectViewController, animated: true)
            return false
        } else {
            return true
        }
    }
}
