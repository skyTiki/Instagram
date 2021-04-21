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
            if email.isEmpty || passwoerd.isEmpty {
                HUD.shared.showError(withStatus: "入力値に空の項目があります")
                return
            }
            
            HUD.shared.show()
            
            // ログイン（Firebase）
            Auth.auth().signIn(withEmail: email, password: passwoerd) { (authDataResult, error) in
                
                // エラー有無の判定
                if let error = error {
                    HUD.shared.showError(withStatus: "ログインに失敗しました。")
                    print("ログインに失敗しました", error.localizedDescription)
                    return
                }
                
                HUD.shared.dismiss()
                HUD.shared.showSuccess(withStatus: "ログインに成功しました")
                // エラーがなければ問題ないため画面閉じる
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        // テキストの文字取得
        if let email = emailTextfield.text, let password = passwordTextField.text, let displayName = displayNameTextField.text {
            
            // 空文字かどうか判定
            if email.isEmpty || password.isEmpty || displayName.isEmpty {
                HUD.shared.showError(withStatus: "入力値に空の項目があります")
                return
            }
            
            HUD.shared.show()
            
            // アカウント作成(FirebaseのCreateメソッド)
            Auth.auth().createUser(withEmail: email, password: password) { (authresult, error) in
                // errorがあったら早期リターン
                if let  error = error {
                    HUD.shared.showError(withStatus: "アカウント作成に失敗しました。\n \n　メールの形式、またはパスワード文字数が６文字以上であることを確認してください。")
                    print("アカウント作成に失敗しました", error.localizedDescription)
                    return
                }
                
                // 表示名を設定
                // 現在のユーザーを取得
                if let user = Auth.auth().currentUser {
                    // ユーザー情報変更要求オブジェクト
                    let changeRequest = user.createProfileChangeRequest()
                    // 変更要求
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { error in
                        if let error = error {
                            HUD.shared.showError(withStatus: "表示名の登録に失敗しました。")
                            print("表示名の登録に失敗しました", error.localizedDescription)
                            return
                        }
                        
                        HUD.shared.dismiss()
                        HUD.shared.showSuccess(withStatus: "アカウント作成に成功しました")
                        // 画面閉じる
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
