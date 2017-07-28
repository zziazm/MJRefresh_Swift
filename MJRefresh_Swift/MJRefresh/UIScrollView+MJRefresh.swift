//
//  UIScrollView+MJRefresh.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/21.
//  Copyright © 2017年 zm. All rights reserved.
//

import Foundation
import UIKit


private var mj_headerKey: Void?
private var mj_footerKey: Void?
private var mj_reloadDataBlockKey: Void?

extension UIScrollView{
    var mj_header: MJRefeshHeader?{
        get{
            return objc_getAssociatedObject(self, &mj_headerKey) as? MJRefeshHeader
        }set{
            if let header = mj_header {
                header.removeFromSuperview()
            }

            if let new = newValue {
                self.insertSubview(new, at: 0)
            }
            self.willChangeValue(forKey: "mj_header")
            objc_setAssociatedObject(self, &mj_headerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.didChangeValue(forKey: "mj_header")
        }
        
    }
    
    var mj_footer: MJRefreshFooter?{
        get{
            return objc_getAssociatedObject(self, &mj_footerKey) as? MJRefreshFooter
        }set{
            self.mj_footer?.removeFromSuperview()
            
            if let new = newValue {
                self.insertSubview(new, at: 0)
            }
            self.willChangeValue(forKey: "mj_footer")
            objc_setAssociatedObject(self, &mj_footerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.didChangeValue(forKey: "mj_footer")
        }
    }
    
    var mj_reloadDataBlock: ((_ totalDataCount: Int) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &mj_reloadDataBlockKey) as? (Int) -> Void
        }set{
            self.willChangeValue(forKey: "mj_reloadDataBlock")
            objc_setAssociatedObject(self, &mj_reloadDataBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.didChangeValue(forKey: "mj_reloadDataBlock")
        }
    }
    
    var mj_totalDataCount: NSInteger {
        get{
            var totalCount = 0
            if self is UITableView {
                let tableView = self as! UITableView
                for i in 0..<tableView.numberOfSections {
                   totalCount += tableView.numberOfRows(inSection: i)
                }
            } else if self is UICollectionView {
                let colletionView = self as! UICollectionView
                for i in 0..<colletionView.numberOfSections {
                    totalCount += colletionView.numberOfItems(inSection: i)
                }
            }
            return totalCount
        }
    }
    
    
    
    
    
    
    
    
    
    
}
