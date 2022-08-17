//
//  EliminateIfElse.swift
//  WYLNumberKeboard
//
//  Created by 王延磊 on 2022/8/11.
//

import Foundation
import SVProgressHUD
class EliminateIfElse {
    class func check(items: [DetermineType]) -> Bool {
        for item in items {
            let result = item.check()
            if !result {
                item.handle()
                return false
            }
        }
        return true
    }
}


enum DetermineType {
    case Type1
    case Type2
    case Type3
    case Type4
    case Type5
    case Type6
    case Type7
    
    func check() -> Bool {
        return false
    }
    
    func handle() {
        switch self {
        case .Type1:
            handleType1()
        case .Type2:
            handleType2()
        case .Type3:
            handleType3()
        case .Type4:
            handleType4()
        case .Type5:
            handleType5()
        case .Type6:
            handleType6()
        case .Type7:
            handleType7()
        }
    }
}

extension DetermineType {
    func handleType1() {
        print("type1")
    }
    
    func handleType2() {
        print("type2")
    }
    func handleType3() {
        print("type3")
    }
    func handleType4() {
        print("type4")
    }
    func handleType5() {
        print("type5")
    }
    func handleType6() {
        print("type6")
    }
    func handleType7() {
        print("type7")
    }
}



