//
//  MBProgressHUDExtension.swift
//  WYLNumberKeboard
//
//  Created by 王延磊 on 2022/8/11.
//

import Foundation
import UIKit
import FLAnimatedImage
import RxSwift

extension MBProgressHUD {
    
    
    class func showLoading(_ title: String, _ icon: String) {
        
        let view = UIApplication.shared.keyWindow ?? UIView()
        guard let loadingURL = Bundle.main.url(forResource: icon, withExtension: "gif") else {
            return
        }
        
        
        let loadingIV = FLAnimatedImageView()
        loadingIV.invalidateIntrinsicContentSize()
        loadingIV.sd_setImage(with: loadingURL, completed: nil)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
        hud.customView = loadingIV
        hud.minShowTime = 1
        // 再设置模式
        hud.mode = .customView
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        hud.show(animated: true)
    }
    
    class func hiden() {
        let view = UIApplication.shared.keyWindow ?? UIView()
        MBProgressHUD.hide(for: view, animated: true)
    }
}


extension FLAnimatedImageView {
    open override var intrinsicContentSize: CGSize {
        CGSize(width: 37, height: 37)
    }
}

