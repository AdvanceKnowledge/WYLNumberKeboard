//
//  MyView.swift
//  WYLNumberKeboard
//
//  Created by 王延磊 on 2022/8/3.
//

import UIKit

private class MyView: UIView {
    
//    var name = ""
    var sec = SecondView()
    let minuteInterval = 5
    func down() {
        let minutes = 60
        for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
            
        }
    }
    

}

open class SecondView: UIView {
    
}
