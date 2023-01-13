//
//  String+Extension.swift
//  MiddleMall
//
//  Created by 无名 on 2019/12/4.
//  Copyright © 2019 无名. All rights reserved.
//

import Foundation
import UIKit
 // MARK: Get


struct RegexHelper {
    let regex: NSRegularExpression
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }

    func math(_ input: String) -> Bool {
        let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
        return matches.count > 0
        
    }
}
/**
 precedencegroup  定义一个操作符的优先级别
 associativity          定义了结合律,即如果多个同类的操作符顺序出现的计算顺序.
 higherThan           运算的优先级,点积运算是优于乘法运算的. 除了  higherThan(高于)  也支持使用 lowerThan来指定优先级低于某个其他组
 infix                       表示要定义的是一个中位操作符,即前后都是输入
 **/
precedencegroup MatchPrecedence {
    associativity: none
    higherThan: DefaultPrecedence
}
infix operator =~: MatchPrecedence
// MARK: 验证字符串格式 =~   电话、邮箱、纯数字、身份证号、网址链接
extension String {
    enum StringType: Int {
        /// 电话号码
        case TEL = 0,

        /// 邮箱
        EMAIL,
        
        /// 纯数字
        NUMBER,
        
        /// 身份证号码
        IDCARD,
        
        /// 连接
        URL
    }

    /// 判断字符串类型
    /// - Parameter lhs: 判断内容
    /// - Parameter type: 目标类型
    static func=~(lhs: String, type: StringType) -> Bool {
        var rhs: String?
        switch type {
        case .EMAIL:
            rhs = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            
        case .TEL:
            
            let rhs0 = "^1(3[0-9]|4[01456879]|5[0-35-9]|6[2567]|7[0-8]|8[0-9]|9[0-35-9])\\d{8}$"

            let result: Bool = String.judgmentCalls(rhs: rhs0, lhs: lhs)
            return result
            /**
             * 手机号码:
             * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
             * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
             * 联通号段: 130,131,132,155,156,185,186,145,176,1709
             * 电信号段: 133,153,180,181,189,177,1700
             */
            let rhs1 = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$"
            let rhs2 = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
            let rhs3 = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)"
            let rhs4 = "^(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)"
            let rhs5 = "^1(3[0-9]|4[01456879]|5[0-35-9]|6[2567]|7[0-8]|8[0-9]|9[0-35-9])\\d{8}$"
            
            let result1: Bool = String.judgmentCalls(rhs: rhs1, lhs: lhs)
            let result2: Bool = String.judgmentCalls(rhs: rhs2, lhs: lhs)
            let result3: Bool = String.judgmentCalls(rhs: rhs3, lhs: lhs)
            let result4: Bool = String.judgmentCalls(rhs: rhs4, lhs: lhs)
            let result5: Bool = String.judgmentCalls(rhs: rhs5, lhs: lhs)
            if result1 || result2 || result3 || result4 || result5 {
                return true
            } else {
                return false
            }
        case .NUMBER:
            let content = lhs.trimmingCharacters(in: NSCharacterSet.decimalDigits)
            if content.count > 0 {
                return false
            } else {
                return true
            }
        case .IDCARD:
            rhs = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        case .URL:
            rhs = "[a-zA-z]+://[^\\s]*"
        }
        return String.judgmentCalls(rhs: rhs!, lhs: lhs)
    }

    static func judgmentCalls(rhs: String, lhs: String) -> Bool {
        do {
            return try RegexHelper(rhs).math(lhs)
        } catch _ {
            return false
        }
    }

    /// 截取  开始到指定位置
    /// - Parameter index: 截取终点
    func mySubstring(to index: NSInteger) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }

    /// 截取  指定位置到末尾
    /// - Parameter index: 截取起点
    func mySubstring(from index: NSInteger) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }

    /// 指定位置向后截取指定长度
    /// - Parameter location: 起点
    /// - Parameter long: 长度
    func mySubstring(start location: NSInteger, length long: NSInteger) -> String {
        var len = long
        if len == -1 {
            len = self.count - location
        }
        let start = self.index(startIndex, offsetBy: location)
        let end = self.index(start, offsetBy: len)
        return String(self[start ..< end])
    }

    /// 指定字符之前的文本
    /// - Parameter str: 指定字符
    /// - Parameter include: true 包含指定字符 false 不包含指定字符
    func mySubstring(before str: Character, includeOrNot include: Bool) -> String {
        if !self.contains(str) {
            return self
        }

        if include {
            return String(self[...(self.firstIndex(of: str) ?? self.endIndex)])
        }
        return String(self[..<(self.firstIndex(of: str) ?? self.endIndex)])
    }

   /// 指定字符之后的文本
    /// - Parameter str: 指定字符
    /// - Parameter include: true 包含指定字符 false 不包含指定字符
    func mySubstring(after str: Character, includeOrNot include: Bool) -> String {
        if !self.contains(str) {
            return self
        }
        if include {
            let start = self.index((self.firstIndex(of: str) ?? self.endIndex), offsetBy: 0)
            return String(self[start..<self.endIndex])
        }

        let start = self.index((self.firstIndex(of: str) ?? self.endIndex), offsetBy: 1)
        return String(self[start..<self.endIndex])
    }

    /// 获取文本宽度
    /// - Parameter fontSize: 文字大小
    /// - Parameter height: 控件高度
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT),
                                                                    height: height),
                                                                    options: .usesLineFragmentOrigin,
                                                                    attributes: [NSAttributedString.Key.font: font],
                                                                    context: nil)
        return ceil(rect.width)
    }
    
    func replacePhone() -> String {
        if (self =~ .NUMBER) && self.count == 11 {
            let start = self.index(self.startIndex, offsetBy: 3)
            let end = self.index(self.startIndex, offsetBy: 7)
            let range = Range(uncheckedBounds: (lower: start, upper: end))
            return self.replacingCharacters(in: range, with: "****")
        } else {
            return self
        }
    }
    
    func handleStringToDic() -> [String: Any]? {
        if self.isEmpty {
            return nil
        }
        let jsonData = self.data(using: Encoding.utf8)
        
        var dic: [String: Any]?
        do {
            dic = try JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers) as? [String: Any]
        } catch {
            dic = nil
        }
        
        return dic
    }
    
    /// 设置行间距
    /// - Parameter normalString: 需要设置行间距的文本
    /// - Parameter font: 字体大小
    /// - Parameter linspace: 期望行间距大小
    func setLineSpacing(font: CGFloat,
                        linspace: CGFloat) -> NSAttributedString {
        
        if self.isEmpty {
            return NSAttributedString.init(string: "", attributes: [:])
        }
        
        let attributeDict = NSMutableDictionary.init(capacity: 3)
        
        attributeDict.setValue(UIFont.systemFont(ofSize: font),
                               forKey: NSAttributedString.Key.font.rawValue)
        
        let paraStyle = NSMutableParagraphStyle.init()
        paraStyle.lineSpacing = linspace
        
        attributeDict.setValue(paraStyle,
                               forKey: NSAttributedString.Key.paragraphStyle.rawValue)
        return NSAttributedString.init(string: self,
                                       attributes: attributeDict
                                        as? [NSAttributedString.Key: Any])
    }
}
