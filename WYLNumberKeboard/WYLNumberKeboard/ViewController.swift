//
//  ViewController.swift
//  WYLNumberKeboard
//
//  Created by 王延磊 on 2022/7/26.
//

import UIKit
import SVProgressHUD
import MBProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyBoard = WYLNumberKeyboardView.init(self.myTextField, nil) { _ in
            print("提现")
        }
        myTextField.inputView = keyBoard
        
        
        let count = getFirstPositive(10, 30)
        print(count!)
        
    }
    @IBAction func type1(_ sender: UIButton) {
        MBProgressHUD.showLoading("正在加载", "loading_dynamic_icon")
        _ = EliminateIfElse.check(items: [DetermineType.Type1])
//        MBProgressHUD.hiden()
    }
    
    @IBAction func type2(_ sender: Any) {
        
        _ = EliminateIfElse.check(items: [DetermineType.Type2])
        MBProgressHUD().hide(animated: true)
    }
    
    
    @IBAction func type3(_ sender: Any) {
        _ = EliminateIfElse.check(items: [DetermineType.Type3])
        
    }
    @IBAction func type4(_ sender: Any) {
        _ = EliminateIfElse.check(items: [DetermineType.Type4])
    }
    
    @IBAction func type5(_ sender: Any) {
        _ = EliminateIfElse.check(items: [DetermineType.Type5])
    }
    
    @IBAction func type6(_ sender: Any) {
        _ = EliminateIfElse.check(items: [DetermineType.Type6])
    }
    
    @IBAction func type7(_ sender: Any) {
        _ = EliminateIfElse.check(items: [DetermineType.Type7])
    }
    
    @IBAction func toOCVC(_ sender: Any) {
        let ocVC = OCVC()
        self.present(ocVC, animated: true, completion: nil)
        
    }
    
    func getFirstPositive(_ v1: Int, _ v2: @autoclosure () -> Int) -> Int? {
        
        return v1 < 0 ? v1 : v2()
    }
    
    
}

class FileManager {
    public static let shared = {
        return FileManager()
    }
    
    private init() { }
}
