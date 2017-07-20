//
//  MJRefreshConst.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/19.
//  Copyright © 2017年 zm. All rights reserved.
//

import Foundation
import UIKit
let MJRefreshFastAnimationDuration: TimeInterval = 0.25
let MJRefreshLabelFont = UIFont.boldSystemFont(ofSize: 14)
let MJRefreshKeyPathContentOffset = "contentOffset"
let MJRefreshKeyPathContentSize = "contentSize"
let MJRefreshKeyPathPanState = "state"
let MJRefreshHeaderHeight: CGFloat = 54.0;

func MJRefreshColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

let MJRefreshLabelTextColor = MJRefreshColor(r: 90, g: 90, b:90)
let MJRefreshHeaderLastUpdatedTimeKey = "MJRefreshHeaderLastUpdatedTimeKey"
let MJRefreshSlowAnimationDuration:TimeInterval = 0.4;
let MJRefreshHeaderLastTimeText = "MJRefreshHeaderLastTimeText"
let MJRefreshHeaderDateTodayText = "MJRefreshHeaderDateTodayText"
let MJRefreshHeaderNoneLastDateText = "MJRefreshHeaderNoneLastDateText"
let MJRefreshLabelLeftInset: CGFloat = 25.0;

let MJRefreshHeaderIdleText = "MJRefreshHeaderIdleText";
let MJRefreshHeaderPullingText = "MJRefreshHeaderPullingText";
let MJRefreshHeaderRefreshingText = "MJRefreshHeaderRefreshingText";
