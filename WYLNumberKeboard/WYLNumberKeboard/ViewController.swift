//
//  ViewController.swift
//  WYLNumberKeboard
//
//  Created by 王延磊 on 2022/7/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let keyBoard = WYLNumberKeyboardView.init(self.myTextField, nil) { _ in
            print("提现")
        }
        myTextField.inputView = keyBoard
        
    }
    @IBAction func toOCVC(_ sender: Any) {
        let ocVC = OCVC()
        self.present(ocVC, animated: true, completion: nil)
        
    }
}

