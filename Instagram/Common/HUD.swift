//
//  HUD.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/04/21.
//

import Foundation
import SVProgressHUD


class HUD {
    static let shared = HUD()
    
    func showSuccess(withStatus: String?) {
        SVProgressHUD.showSuccess(withStatus: withStatus)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            SVProgressHUD.dismiss()
        }
    }
    
    func showError(withStatus: String?) {
        SVProgressHUD.showError(withStatus: withStatus)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            SVProgressHUD.dismiss()
        }
    }
    
    // HUDをこのクラスだけで管理するため、下記メソッドもこのクラスから呼ばせる
    func show() {
        SVProgressHUD.show()
    }
    
    func dismiss() {
        SVProgressHUD.dismiss()
    }
    
}
