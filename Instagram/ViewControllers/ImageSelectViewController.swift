//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/04/15.
//

import UIKit
import CLImageEditor

class ImageSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLImageEditorDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // ライブラリボタン
    @IBAction func handleLibraryButton(_ sender: Any) {
        presentPicker(sourceType: .photoLibrary)
    }
    
    // カメラボタン
    @IBAction func handleCameraButton(_ sender: Any) {
        presentPicker(sourceType: .camera)
    }
    
    // キャンセルボタン
    @IBAction func hundleCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // PickerControllerを表示する共通処理
    private func presentPicker(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = sourceType
            
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePickerController
    // 写真が選択もしくは撮影された時
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] != nil {
            let image = info[.originalImage] as! UIImage
            
            let editor = CLImageEditor(image: image)!
            editor.delegate = self
            editor.modalPresentationStyle = .fullScreen
            picker.present(editor, animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - CLImageEditor
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        let postViewController = storyboard?.instantiateViewController(identifier: "Post") as! PostViewController
        postViewController.image = image
        editor.present(postViewController, animated: true, completion: nil)
    }
    func imageEditorDidCancel(_ editor: CLImageEditor!) {
        dismiss(animated: true, completion: nil)
    }
    
}
