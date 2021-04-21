//
//  SettingViewController.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/04/15.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    @IBOutlet weak var newDisplayNameTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 現在の表示名を出力
        if let user = Auth.auth().currentUser {
            newDisplayNameTextFiled.text = user.displayName
        }
    }
    
    // 表示名修正
    @IBAction func handleChangeDisplayNameButton(_ sender: Any) {
        
        guard let newDisplayName = newDisplayNameTextFiled.text else { return }
        if newDisplayName.isEmpty { HUD.shared.showError(withStatus: "表示名を入力してください。"); return }
        
        HUD.shared.show()
        if let createProfileChangeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
            createProfileChangeRequest.displayName = newDisplayName
            createProfileChangeRequest.commitChanges { error in
                if let error = error {
                    HUD.shared.showError(withStatus: "表示名の変更に失敗しました。")
                    print("表示名の変更失敗", error.localizedDescription)
                    return
                }
                HUD.shared.dismiss()
                HUD.shared.showSuccess(withStatus: "表示名を変更しました。")
                
                self.view.endEditing(true)
            }
        }
    }
    
    // ログアウト
    @IBAction func handleLogoutButton(_ sender: Any) {
        try? Auth.auth().signOut()
        
        guard let loginVC = storyboard?.instantiateViewController(identifier: "Login") else { return }
        present(loginVC, animated: true, completion: nil)
        
        // 次回ログイン時にホーム画面を選択状態にする
        tabBarController?.selectedIndex = 0
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
