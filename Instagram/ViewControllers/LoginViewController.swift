//
//  LoginViewController.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/04/14.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleLoginButton(_ sender: Any) {
        // テキストの文字取得
        if let email = emailTextfield.text, let passwoerd = passwordTextField.text {
            
            // 空文字判定
            if email.isEmpty || passwoerd.isEmpty { print("入力値に空の項目もくがありました。"); return }
            
            // サインイン（Firebase）
            Auth.auth().signIn(withEmail: email, password: passwoerd) { (authDataResult, error) in
                
                // エラー有無の判定
                if let error = error { print("ログインでエラーが発生しました。", error.localizedDescription); return }
                
                // エラーがなければ問題ないため画面閉じる
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        // テキストの文字取得
        if let email = emailTextfield.text, let password = passwordTextField.text, let displayName = displayNameTextField.text {
            
            // 空文字かどうか判定
            if email.isEmpty || password.isEmpty || displayName.isEmpty { print("入力テキストに空文字がありました"); return }
            
            // アカウント作成(FirebaseのCreateメソッド)
            Auth.auth().createUser(withEmail: email, password: password) { (authresult, error) in
                // errorがあったら早期リターン
                if let  error = error { print("アカウント作成処理で失敗しました。", error.localizedDescription); return }
                
                // 表示名を設定
                // 現在のユーザーを取得
                if let user = Auth.auth().currentUser {
                    // ユーザー情報変更要求オブジェクト
                    let changeRequest = user.createProfileChangeRequest()
                    // 変更要求
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { error in
                        if let error = error { print("表示名の登録で失敗しました。", error.localizedDescription); return }
                        
                        // 画面閉じる
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
}
