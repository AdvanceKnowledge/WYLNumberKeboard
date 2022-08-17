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
        // 再设置模式
        hud.mode = .customView
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        hud.show(animated: true)
        
        
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
        var node1 = l1
        var node2 = l2
        var carry = 0
        var result: ListNode? = nil
        var tail: ListNode? = nil
        
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
    func myAtoi(_ s: String) -> Int {
        let result = Int(s) ?? 0
        
        return result
    }
    
    
    /// 承最多水的容器\\\ 最大面积
    /// - Parameter height: 数组
    /// - Returns:
    func maxArea(_ height: [Int]) -> Int {
        var maxItem = 0
        var left = 0
        var right = height.count - 1
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
    
//    func isValid(_ s: String) -> Bool {
//       
//        if s.count%2 != 0 {
//            return false
//        }
//        
//        
//        let pairs = [")":"(","]":"[","}":"{"]
//        var stack = [Character]()
//        for i in 0..<s.count {
//            if stack.isEmpty || stack.peek() != pairs[s[i]] {
//                return false
//            }
//        }
//        
//        
//        
//        
//        return false
//    }
//

    
    
}


protocol MyProtocol {
    var name: String { get }
    
    
}
