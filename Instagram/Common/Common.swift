//
//  Common.swift
//  Instagram
//
//  Created by takatoshi.ichige on 2021/04/21.
//

import Foundation
import SVProgressHUD


class Common {
    static let shared = Common()
    
    func hudShowSuccess(withStatus: String?) {
        SVProgressHUD.showSuccess(withStatus: withStatus)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            SVProgressHUD.dismiss()
        }
    }
    
    func hudShowError(withStatus: String?) {
        SVProgressHUD.showError(withStatus: withStatus)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            SVProgressHUD.dismiss()
        }
    }
}
