//
//  WYLNumberKeyboardView.swift
//  WYLNumberKeboard
//
//  Created by 王延磊 on 2022/7/26.
//

import UIKit
import SnapKit
typealias OneParameterBlock = (Any?) -> Void
class WYLNumberKeyboardView: UIView {
    
    var textField: UITextField?
    var textView: UITextView?
    
    var withdrawalBlcok: OneParameterBlock?
    
    private let keyboardScreenHeight = UIScreen.main.bounds.size.height
    private let keyboardScreenWidth = UIScreen.main.bounds.size.width
    private var dwithdrawalButton = UIButton()
    /// 单个按钮的基本宽度
    private let itemWidth = (UIScreen.main.bounds.size.width - 50.0)/4.0
    
    private let itemHegiht = 50
    
    private let lineSpace = 10.0
    @objc init(_ textField: UITextField?, _ textView: UITextView?, _ withdrawalBlcok:  OneParameterBlock?) {

        super.init(frame: .zero)
        self.textField = textField
        self.textView = textView
        self.withdrawalBlcok = withdrawalBlcok
        self.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        self.frame = CGRect(x: 0, y: keyboardScreenHeight - 243, width: keyboardScreenWidth, height: (50 * 4) + (lineSpace * 6))
        self.setupKeyBoard()
        self.textField?.reloadInputViews()
        self.textView?.reloadInputViews()
    }
    
    
    func setupKeyBoard() {
        var lastbtn: UIButton!
        for i in 1..<10 {
            let button = createItem(title: "\(i)")
            let remainder = (i - 1)%3
            let shang = (i - 1)/3
            self.addSubview(button)
            button.snp.makeConstraints { make in
                make.width.equalTo(itemWidth)
                make.height.equalTo(itemHegiht)
                make.top.equalToSuperview().inset(Int(lineSpace) + (shang * (itemHegiht + Int(lineSpace))))
                make.left.equalTo(Int(lineSpace) + (remainder * (Int(itemWidth) + Int(lineSpace))))
            }
            lastbtn = button
        }
        
        let zeroButton = createItem(title: "0")
        self.addSubview(zeroButton)
        zeroButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(lineSpace)
            make.width.equalTo(2 * itemWidth + lineSpace)
            make.height.equalTo(itemHegiht)
            make.top.equalTo(lastbtn.snp.bottom).offset(lineSpace)
        }
        
        let pointButton = createItem(title: ".")
        self.addSubview(pointButton)
        pointButton.snp.makeConstraints { make in
            make.left.equalTo(zeroButton.snp.right).offset(lineSpace)
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemHegiht)
            make.top.equalTo(lastbtn.snp.bottom).offset(lineSpace)
        }
        
        let deleteButton = createItem(title: "")
        deleteButton.setImage(UIImage.init(named: "keyBoardDelete"), for: .normal)
        self.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.left.equalTo(lastbtn.snp.right).offset(lineSpace)
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemHegiht)
            make.top.equalToSuperview().inset(lineSpace)
        }
        
        
        let normalIg = colorToImage(color: UIColor.init(red: 116/255, green: 118/255, blue: 220/255, alpha: 1),
                                    size: CGSize(width: 50, height: 50))
        
        let disIg = colorToImage(color: UIColor.init(red: 200/255, green: 200/255, blue: 234/255, alpha: 1),
                                 size: CGSize(width: 50, height: 50))
        
        dwithdrawalButton = createItem(title: "提现")
        dwithdrawalButton.setBackgroundImage(normalIg, for: .normal)
        dwithdrawalButton.setBackgroundImage(disIg, for: .disabled)
        dwithdrawalButton.setTitleColor(.white, for: .normal)
        dwithdrawalButton.isEnabled = false
        self.addSubview(dwithdrawalButton)
        dwithdrawalButton.snp.makeConstraints { make in
            make.left.equalTo(lastbtn.snp.right).offset(lineSpace)
            make.width.equalTo(itemWidth)
            make.height.equalTo((itemHegiht * 3) + (Int(lineSpace) * 2))
            make.top.equalTo(deleteButton.snp.bottom).offset(lineSpace)
        }
    }
    
    
    func createItem(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(clickAction(sender:)),
                         for: .touchUpInside)
        
        let highlightedIg = colorToImage(color: UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 0.3),
                                         size: CGSize(width: itemWidth, height: CGFloat(itemHegiht)))
        
        button.imageView?.contentMode = .scaleToFill
        button.setBackgroundImage(highlightedIg, for: .highlighted)
        return button
    }
    
    
    @objc func clickAction(sender: UIButton) {
        
        if self.textField != nil {
            handleField(currentTextField: self.textField!, currentTitle: sender.currentTitle!)
            
        }
        
        if self.textView != nil {
            handleTextView(currentTextView: self.textView!, currentTitle: sender.currentTitle!)
        }
        
    }
    
    func handleField(currentTextField: UITextField, currentTitle: String) {
        guard let text = currentTextField.text else {
            return
        }
        currentTextField.text = validationInputContent(text: text,
                                                       currentTitle: currentTitle,
                                                       currentContent: currentTextField.text)
    }
    
    func handleTextView(currentTextView: UITextView, currentTitle: String) {
        guard let text = currentTextView.text else {
            return
        }
        
        currentTextView.text = validationInputContent(text: text,
                                                      currentTitle: currentTitle,
                                                      currentContent: currentTextView.text)
    }
    
    func validationInputContent(text: String, currentTitle: String, currentContent: String?) -> String? {
        var content = currentContent ?? ""
        if currentTitle == "" {
            if content.count != 0 {
                content.removeLast()
            }
            return content

        } else if currentTitle == "提现" {
            self.withdrawalBlcok!(nil)
            return currentContent
        }
        
        content = (currentContent ?? "") + currentTitle
        
        /// 4.检查小数点后位数限制 (小数点后最多输入2位)
        if let ran = text.range(of: "."), text.count - NSRange(ran, in: text).location > 2 {
            content = currentContent ?? ""
        }
        
        /// 5.检查首位输入是否为0
        if text == "0", currentTitle != "." {
            content = currentTitle
        }

        /// a.首位小数点替换为0.
        if text.count == 0, currentTitle == "." {
            content = "0."
            return "0."
        }
        
        /// b.禁止多次输入小数点
        if text.range(of: ".") != nil, currentTitle == "." {
            content = currentContent ?? ""
        }
        
        if content.count != 0 {
            dwithdrawalButton.isEnabled = true
        } else {
            dwithdrawalButton.isEnabled = false
        }
        return content
    }
    
    /// 颜色生成图片
    /// - Parameter color: 颜色
    /// - Parameter size: 生成的图片大小
    func colorToImage(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        //创建图片
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()//创建图片上下文
        context?.setFillColor(color.cgColor)//设置当前填充颜色的图形上下文
        context?.fill(rect)//填充颜色
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
