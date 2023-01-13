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
        var a = 20
        print(" a = \(a)")
//        a = a >> 1
//        print(" a = \(a)")
        a = a << 2
        
        print(" a = \(a)")
        
        let keyBoard = WYLNumberKeyboardView.init(self.myTextField, nil) { _ in
            print("提现")
        }
        myTextField.inputView = keyBoard
        
        
        var layer = CALayer()
        
        self.view.layer.addSublayer(layer)
        let count = getFirstPositive(10, 30)
        print(count!)
        
        
        let point = (0,2)
        switch point {
        case (let x, 0):
            print("y is 0  X = \(x)")
        case (0, let y):
            print("x is 0 Y = \(y)")
            break
        case (let x, let y):
            print("X = \(x) Y = \(y)")
            break
        }
        if "13681230801" =~ .TEL {
            print("13681230801")
        } else {
            print("13681230801   error")
        }
        if "19531663160" =~ .TEL {
            print("19531663160")
        } else {
            print("19531663160 error")
        }
        
        
        
        
    }
    @IBAction func type1(_ sender: UIButton) {
        MBProgressHUD.showLoading("正在加载", "loading_dynamic_icon")
        _ = EliminateIfElse.check(items: [DetermineType.Type1])
        MBProgressHUD.hiden()
    }
    
    @IBAction func type2(_ sender: Any) {
        let l1 = ListNode()
        l1.val = 9
        let l2 = ListNode()
        l2.val = 9
        let l3 = ListNode()
        l3.val = 9
        let l4 = ListNode()
        l4.val = 9
        let l5 = ListNode()
        l5.val = 9
        let l6 = ListNode()
        l6.val = 9
        let l7 = ListNode()
        l7.val = 9
        
        l1.next = l2
        l2.next = l3
        l3.next = l4
        l4.next = l5
        l5.next = l6
        l6.next = l7
        
        let other1 = ListNode()
        other1.val = 9
        let other2 = ListNode()
        other2.val = 9
        let other3 = ListNode()
        other3.val = 9
        let other4 = ListNode()
        other4.val = 9
        
        other1.next = other2
        other2.next = other3
        other3.next = other4
        
        
       _ = Solution().addTwoNumbers(l1, other1)
        
        
        _ = Solution().findMedianSortedArrays([1,2,3], [3,4,2])
        _ = Solution().reverse(-123)
        _ = Solution().reverse(200)
        _ = Solution().myAtoi("-23ewe2wewh")
        _ = Solution().threeSum([0,0,0])
        _ = Solution().multiply("123", "232")
        _ = Solution().isPalindrome(121)
        _ = Solution().convert("0123456789", 4)
        _ = Solution().intToRoman(1233)
        _ = Solution().letterCombinations("234")
        _ = Solution().strStr("abc", "c")
        _ = Solution().lengthOfLastWord("   fly me   to   the moon  ")
        _ = Solution().plusOne([0])
//        _ = EliminateIfElse.check(items: [DetermineType.Type2])
//        MBProgressHUD().hide(animated: true)
    }
    
    
    @IBAction func type3(_ sender: Any) {
        _ = EliminateIfElse.check(items: [DetermineType.Type3])
        gcdSignal()
        
    }
    @IBAction func type4(_ sender: Any) {
        _ = EliminateIfElse.check(items: [DetermineType.Type4])
    }
    
    @IBAction func type5(_ sender: Any) {
        _ = EliminateIfElse.check(items: [DetermineType.Type5])
    }
//    CAEmitterCell
    @IBAction func type6(_ sender: Any) {
//        _ = EliminateIfElse.check(items: [DetermineType.Type6])
        let vc = YFSnowViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func type7(_ sender: Any) {
//        _ = EliminateIfElse.check(items: [DetermineType.Type7])
        
        let rippleVC = YFRippleViewController()
//        self.navigationController?.pushViewController(rippleVC, animated: true)
        self.present(rippleVC, animated: true, completion: nil)
        
        
    }
    
    
    /// 信号量 dispatch_semaphore_create (创建)、dispatch_semaphore_signal (发送)、dispatch_semaphore_wait (等待)、
    func gcdSignal() {
        let sem = DispatchSemaphore.init(value: 0)
        for i in 0..<3 {
            print("\(i)")
            timeConsumingAction(sem: sem)
            _ = sem.wait(timeout: DispatchTime.distantFuture)
        }
        
        DispatchQueue.main.async {
            print("END")
        }
    }
    
    func timeConsumingAction(sem: DispatchSemaphore) {
        sem.signal()
        sleep(5)
        
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



public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
 

class Solution {
    ///链表和
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var node1 = l1, node2 = l2, carry = 0, result: ListNode? = nil, tail: ListNode? = nil
        while (node1 != nil || node2 != nil) {
            //个位数
            let sum = (node1?.val ?? 0) + (node2?.val ?? 0) + carry
            if result == nil {
                tail = ListNode()
                tail?.val = sum%10
                result = tail
            } else {
                tail?.next = ListNode()
                tail?.next?.val = sum%10
                tail = tail?.next
            }
            carry = sum/10
            if node1 != nil {
                node1 = node1?.next
            }
            
            if node2 != nil {
                node2 = node2?.next
            }
            
        }
        if carry > 0 {
            tail?.next = ListNode()
            tail?.next?.val = carry
        }
        return result
    }
    
    
    /// 两个数组中位数
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        
        var result = nums1 + nums2
        result = result.sorted { (a, b) in
            return a < b
        }
        let median = result.count/2
        var mediannumber = 0.0
        
        if result.count%2 > 0 {
            //奇数
            mediannumber = Double(result[median])
        } else {
            
            let leftIndex = median - 1
            mediannumber = Double(result[leftIndex] + result[median])/2.0
        }
        
        return mediannumber
    }
    /// 整数反转
    func reverse(_ x: Int) -> Int {
        
        let isNegative = (x < 0)
        var count = x
        if isNegative {
            //负数转正数
            count = 0 - count
        }
        var result = 0
        while count > 0 {
            let result1  = count%10
            count = Int(count/10)
            result = result*10 + result1
        }
       
        if result > INT32_MAX || result < (0 - INT32_MAX - 1) {
            result = 0
        }
        
        return (isNegative ? (0 - result): result)
    }
    
    
    /// 承最多水的容器\\\ 最大面积
    /// - Parameter height: 数组
    /// - Returns:
    func maxArea(_ height: [Int]) -> Int {
        var maxItem = 0, left = 0, right = height.count - 1
        
        while left < right {
            let poor = right - left
            maxItem = max(maxItem, (poor * min(height[left], height[right])))
            if height[left] > height[right] {
                right -= 1
            } else {
                left += 1
            }
        }
        return maxItem
    }
    
    
    /// 三数之和
    /// - Parameter nums: 数组
    /// - Returns: 结果
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        let nums2 = nums.sorted(by: { $0 < $1 })
        
        for first in 0..<nums2.count {
            // 需要和上一次枚举的数不相同, 去重
            if first > 0 && (nums2[first] == nums2[first - 1]) {
                continue
            }
            
            // c 对应的指针初始指向数组的最右端
            var third = nums2.count - 1
            let target = -nums2[first]
            
            // 枚举 b
            for second in (first + 1)..<nums2.count {
                // 需要和上一次枚举的数不相同,去重
                if second > first + 1 && (nums2[second] == nums2[second - 1]) {
                    continue
                }
                // 需要保证 b 的指针在 c 的指针的左侧
                while (second < third && nums2[second] + nums2[third] > target) {
                    third -= 1
                }
                // 如果指针重合，随着 b 后续的增加
                // 就不会有满足 a+b+c=0 并且 b<c 的 c 了，可以退出循环
                if (second == third) {
                    break
                }
                if nums2[third] + nums2[second] == target {
                    result.append([nums2[first],nums2[second],nums2[third] ])
                }
            }
        }
        return result
    }
    
    /// 字符串相乘
    /// - Parameters:
    ///   - num1: 第一个
    ///   - num2: 第二个
    /// - Returns: 结果
    func multiply(_ num1: String, _ num2: String) -> String {
        
        if num1 == "0" || num2 == "0" {
            return "0"
        }
        
        let number = ["0":0,
                      "1":1,
                      "2":2,
                      "3":3,
                      "4":4,
                      "5":5,
                      "6":6,
                      "7":7,
                      "8":8,
                      "9":9]
        var arrary1 = [Int]()
        var arrary2 = [Int]()
        num1.forEach { char in
            arrary1.append(number["\(char)"]!)
        }
        
        num2.forEach { char in
            arrary2.append(number["\(char)"]!)
        }
       
        var number1 = 0
        for i in 0..<arrary1.count {
            number1 = (number1 * 10) + arrary1[i]
        }
        
        var number2 = 0
        for i in 0..<arrary2.count {
            number2 = (number2 * 10) + arrary2[i]
        }
        
        var sums = [Int].init(repeating: 0, count: arrary2.count + arrary1.count)
        for i in 0..<arrary1.count {
            let first = arrary1[i]
            for j in 0..<arrary2.count {
                let second = arrary2[j]
                sums[i + j + 1] += first * second;
            }
        }
        
       
        var index = sums.count - 1
        while index > 0 {
            sums[index - 1] = sums[index - 1] + sums[index]/10
            sums[index] = sums[index]%10
            index -= 1
        }
        
        var result = sums.map(String.init).joined(separator: "")
        if result.first == "0" {
            result.removeFirst()
        }
        return result
       
    }
    
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        var nums = [String]()
        let countStr = "\(x)"
        countStr.forEach { char in
            nums.append("\(char)")
        }
        for i in 0..<nums.count {
            if nums[i] != nums[nums.count - i - 1] {
                return false
            }
        }
        return true
    }
    
    
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows < 1 {
            return ""
        }
        
        if numRows < 2 {
            return s
        }
        var exchage_stringArray = [String].init(repeating: "", count: s.count)
//        qweewewew
        // 方向
        var y_direction = true
        var y_index = 0
        for char in s {
            print(y_index)
            exchage_stringArray[y_index] += String(char)
            
            y_index += (y_direction ? 1 : -1) * 1
            
            if y_index == 0 {
                y_direction = true
            } else if y_index == (numRows - 1) {
                y_direction = false
            }
        }
        
        var exchange_string = ""
        for subString in exchage_stringArray {
            exchange_string += subString
        }
        
        return exchange_string
    }

    
    /// 整数转罗马字符
    /// - Parameter num: 整数
    /// - Returns: 返回值
    func intToRoman(_ num: Int) -> String {
        let bitsdic = ["1":"I",
                       "2":"II",
                       "3":"III",
                       "4":"IV",
                       "5":"V",
                       "6":"VI",
                       "7":"VII",
                       "8":"VIII",
                       "9":"IX"
        ]
        
        
        let tens = ["1": "X",
                    "2": "XX",
                    "3": "XXX",
                    "4": "XL",
                    "5": "L",
                    "6": "LX",
                    "7": "LXX",
                    "8": "LXXX",
                    "9": "XC"
        ]
        
        
        let hundredBit =  ["1": "C",
                           "2": "CC",
                           "3": "CCC",
                           "4": "CD",
                           "5": "D",
                           "6": "DC",
                           "7": "DCC",
                           "8": "DCCC",
                           "9": "CM"
        ]
        
        let thousandBit = [
            "1": "M",
            "2": "MM",
            "3": "MMM"
        ]
        
        let arrarys = [bitsdic,
                       tens,
                       hundredBit,
                       thousandBit]
        var result = ""
        var count = num
        
        for i in 0..<"\(num)".count {
            let dic = arrarys[i]
            let remainder = count%10
            
            count = count/10
            if remainder != 0 {
                result = dic["\(remainder)"]! + result
            }
            
        }
        
    return result
    
    }
    
    /// 整数转罗马字符
    /// - Parameter num: 整数
    /// - Returns: 返回值
    func intToRoman2(_ num: Int) -> String {
        var count = num
        var reslut = ""
        let nums = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        let str = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        for i in 0..<nums.count {
            let value = nums[i]
            let symbol = str[i]
            while count >= value {
                count -= value
                reslut += symbol
            }
            
            if count == 0 {
                break
            }
        }
        return reslut
    }
    
    func letterCombinations(_ digits: String) -> [String] {
        let m = [
                "2": "abc",
                "3": "def",
                "4": "ghi",
                "5": "jkl",
                "6": "mno",
                "7": "pqrs",
                "8": "tuv",
                "9": "wxyz",
            ]
        let digits = digits.map({ (i: Character) -> String in return m[String(i)]! })

            var arr = [String]()
            func loop(_ s: String, _ h: Int) {
                if digits.count <= h {
                    if s != "" { arr.append(s) }
                    return
                }
                for i in digits[h] {
                    loop(s + String(i), h + 1)
                }
            }

            loop("", 0)
            return arr
        }
    
    /// 移除指定元素
    /// - Parameters:
    ///   - nums:
    ///   - val:
    /// - Returns:
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
 
        nums.removeAll { i in
            return i == val
        }
        
        return nums.count
        
    }
    
    
///  实现 strStr()
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        if !haystack.contains(needle) {
            return -1
        }
        var subs = [String]()
        
        haystack.forEach { char in
            subs.append("\(char)")
        }
        
        for i in 0..<subs.count - (needle.count - 1) {
            
            var str = ""
            
            for j in 0..<needle.count {
                
                str = str + "\(subs[i+j])"
            }
            if str == needle {
                return i
            }
        }
        
        return -1
    }
    
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        if divisor == 1 {
            return dividend
        }
        let isNegative = ((dividend > 0) == (divisor > 0))
        let undividend = abs(dividend)
        var unDivisor = abs(divisor)
        var shang = 0
        while (unDivisor + unDivisor) <= (undividend - unDivisor) {
            unDivisor = unDivisor + abs(divisor)
            shang = shang + (isNegative ? 1: -1)
            if shang > INT32_MAX || shang < (-INT32_MAX - 1) {
                shang = Int(INT32_MAX)
            }
        }
    return shang
    }
    
    
    func myAtoi(_ s: String) -> Int {
        //！ 开始录入有效字符的起点
        var start = false
        //! 寻找start
        var returnStr = ""
        //!
        for ch in s {
          
          if !start {
            if (ch.isNumber || ch == "-" || ch == "+") {
              start = true
              returnStr.append(ch)
            } else if ch == " " {
              continue;
            } else {
              return 0
            }
          
          } else {
            if ch.isNumber {
              returnStr.append(ch)
            } else {
              break
            }
          }
        }
        
        //! 如果没有录入，或者 只录入了符号， 则直接返回
        if start == false || returnStr=="+" || returnStr == "-"{
          return 0
        }
        //! 开始转换
        let finalInt = Int32(returnStr)
        guard finalInt != nil else {
          return returnStr.first == "-" ? Int(Int32.min) : Int(Int32.max)
        }
        return Int(finalInt!)
      }

    
    /// 最后一个单词的长度
    /// - Parameter s:
    /// - Returns:
    func lengthOfLastWord(_ s: String) -> Int {
        
//        let words = s.byWords
//        return words.last!.count
        var array = s.components(separatedBy: " ")
        array.removeAll { char in
            return char.isEmpty
        }
        return array.last!.count
    }
    
    
    func plusOne(_  digits: [Int]) -> [Int] {
        
        var digits2 = digits
        var more = 1
        var nextIndex = digits2.count - 1
        while more > 0 && nextIndex >= 0 {
            let lastNum = digits2[nextIndex] + 1
            more = lastNum/10
            digits2[nextIndex] = lastNum%10
            if more > 0 {
                nextIndex -= 1
            }
            
           
        }
        
        if nextIndex < 0 {
            digits2.insert(1, at: 0)
        }
        
        return digits2
    }
    
    
    
    func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        
        
        
        
        return []
    }
    
}

extension StringProtocol { // for Swift 4 you need to add the constrain `where Index == String.Index`
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: String.EnumerationOptions.byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}




/// Target定义客户端代码使用的特定于域的接口。
class Target {

    func request() -> String {
        return "Target: The default target's behavior."
    }
}

/// The Adaptee contains some useful behavior, but its interface is incompatible
/// with the existing client code. The Adaptee needs some adaptation before the
/// client code can use it.
class Adaptee {

    public func specificRequest() -> String {
        return ".eetpadA eht fo roivaheb laicepS"
    }
}

/// The Adapter makes the Adaptee's interface compatible with the Target's
/// interface.
class Adapter: Target {

    private var adaptee: Adaptee

    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }

    override func request() -> String {
        return "Adapter: (TRANSLATED) " + adaptee.specificRequest().reversed()
    }
}

/// The client code supports all classes that follow the Target interface.
class Client {
    // ...
    static func someClientCode(target: Target) {
        print(target.request())
    }
    // ...
}

/// Let's see how it all works together.
class AdapterConceptual {

    func testAdapterConceptual() {
        print("Client: I can work just fine with the Target objects:")
        Client.someClientCode(target: Target())
//    Target: The default target's behavior.
        let adaptee = Adaptee()
        print("Client: The Adaptee class has a weird interface. See, I don't understand it:")
        print("Adaptee: " + adaptee.specificRequest())
//            Adaptee: .eetpadA eht fo roivaheb laicepS
        print("Client: But I can work with it via the Adapter:")
        Client.someClientCode(target: Adapter(adaptee))
//    Target: The default target's behavior.
        
//    Client: I can work just fine with the Target objects:
//    Target: The default target's behavior.
//    Client: The Adaptee class has a weird interface. See, I don't understand it:
//    Adaptee: .eetpadA eht fo roivaheb laicepS
//    Client: But I can work with it via the Adapter:
//    Adapter: (TRANSLATED) Special behavior of the Adaptee.
    }
}
