//
//  UIScrollView+MJRefresh.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/21.
//  Copyright © 2017年 zm. All rights reserved.
//

import Foundation
import UIKit


private var key: Void?
extension UIScrollView{
    var mj_header: MJRefeshHeader?{
        get{
            return objc_getAssociatedObject(self, &key) as? MJRefeshHeader
        }set{
            if let header = mj_header {
                header.removeFromSuperview()
            }

            if let new = newValue {
                self.insertSubview(new, at: 0)
            }
            self.willChangeValue(forKey: "mj_header")
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.didChangeValue(forKey: "mj_header")
        }
        
    }
    
}
