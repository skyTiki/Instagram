//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/04/15.
//

import UIKit

class ImageSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            print(image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel")
        dismiss(animated: true, completion: nil)
    }
    
    
}
