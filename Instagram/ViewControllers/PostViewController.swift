//
//  PostViewController.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/04/15.
//

import UIKit
import Firebase

class PostViewController: UIViewController {
    
    var image: UIImage!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        // 画像の変換
        let jpegImage = image.jpegData(compressionQuality: 0.75)!
        // 画像と投稿のデータ格納先を定義
        let postRef = Firestore.firestore().collection(Const.PostPath).document()
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postRef.documentID + ".jpg")
        
        // HUD
        HUD.show()
        
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        // Storageに画像データをアップする
        imageRef.putData(jpegImage, metadata: metaData) { metadata, error in
            if let error = error {
                print(error)
                HUD.showError(withStatus: "画像のアップロードでエラーが発生しました。")
                
                // 先頭の画面に戻る
                UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
                return
            }
            
            // FireStoreに投稿データを保存
            // 保存用にデータをまとめておく
            let name = Auth.auth().currentUser?.displayName
            let postDoc = [
                "name" : name!,
                "caption" : self.titleTextField.text!,
                "date" : FieldValue.serverTimestamp()
            ] as [String : Any]
            
            postRef.setData(postDoc)
            
            HUD.showSuccess(withStatus: "投稿が完了しました。")
            
            // 先頭の画面に戻る
            UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
            
        }
        
        
    }
    @IBAction func handleCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
