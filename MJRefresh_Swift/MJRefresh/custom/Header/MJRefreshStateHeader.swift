//
//  MJRefreshStateHeader.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/20.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

extension Bundle{
    static func mj_refreshBundle() -> Bundle{
        let path: String = Bundle(for: MJRefreshComponent.self).path(forResource: "MJRefresh", ofType: "bundle")!
        return Bundle(path: path)!
    }
    static func mj_arrowImage() -> UIImage {
        let path = Bundle.mj_refreshBundle().path(forResource: "arrow@2x", ofType: "png")
        
        return (UIImage(contentsOfFile: path!)?.withRenderingMode(.alwaysOriginal))!
    }
    
    static func mj_localizedStringForKey(key: String, value: String?) -> String{
       var language = Locale.preferredLanguages.first
       if let la = language {
        if la.hasPrefix("en") {
            language = "en"
        } else if la.hasPrefix("zh") {
            if la.range(of: "Hans") != nil{
                language = "zh-Hans"
            }else{
                language = "zh-Hant"
            }
        }else{
            language = "en"
        }
        
       }
       let path = Bundle.mj_refreshBundle().path(forResource: language, ofType: "lproj")
       let bundle = Bundle(path: path!)
        
       let value = bundle?.localizedString(forKey: key, value: value, table: nil)
       return Bundle.main.localizedString(forKey: key, value: value, table: nil)
    }
    
    static func mj_localizedStringForKey(key: String) -> String{
        return Bundle.mj_localizedStringForKey(key: key, value: nil)
    }
}




class MJRefreshStateHeader: MJRefeshHeader {
    lazy var lastUpdatedTimeLabel: UILabel = {
        let label = UILabel.mj_label()
        return label
    }()
    
    
    lazy var stateLabel: UILabel = {
        let label = UILabel.mj_label()
        return label
    }()
    
    lazy var stateTitles: [MJRefreshState:String] = {
        let dic = [MJRefreshState:String]()
        return dic
    }()
    
    func setTitle(title: String, forState: MJRefreshState) -> Void {
        self.stateTitles[forState] = title
        self.stateLabel.text = self.stateTitles[self.state]
    }
    
    func currentCalendar() -> Calendar {
        return Calendar(identifier: .gregorian)
    }
    
    var lastUpdatedTimeText: ((Date?) -> String)?
    
    
    override var lastUpdatedTimeKey: String{
        
        didSet{
            if self.lastUpdatedTimeLabel.isHidden {
                return
            }
            
            let lastUpdatedTime = UserDefaults.standard.object(forKey: lastUpdatedTimeKey) as? Date
            
            if let  lastUpdatedTimeText = self.lastUpdatedTimeText {
                self.lastUpdatedTimeLabel.text = lastUpdatedTimeText(lastUpdatedTime)
                return
            }
            
            if let lupdateTime = lastUpdatedTime {
                let calendar = self.currentCalendar()
                let cmp1 = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: lupdateTime)
                let cmp2 = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
                
                let formatter = DateFormatter()
                var  isToday = false
                if cmp1.day == cmp2.day {
                    formatter.dateFormat = " HH:mm"
                    isToday = true
                }else if cmp1.year == cmp2.year {
                    formatter.dateFormat = "MM-dd HH:mm"
                }else{
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                }
                
                
                let time = formatter.string(from: lupdateTime)
                self.lastUpdatedTimeLabel.text = Bundle.mj_localizedStringForKey(key: MJRefreshHeaderLastTimeText) + (isToday ? Bundle.mj_localizedStringForKey(key: MJRefreshHeaderLastTimeText) : "") + time
                
            }else{
                self.lastUpdatedTimeLabel.text = Bundle.mj_localizedStringForKey(key: MJRefreshHeaderLastTimeText) + Bundle.mj_localizedStringForKey(key: MJRefreshHeaderNoneLastDateText)
            }

        }
    }
    
    var labelLeftInset: CGFloat = 0.0
    
    override func prepare() {
        super.prepare()
        self.addSubview(self.lastUpdatedTimeLabel)
        self.addSubview(self.stateLabel)
        
        self.labelLeftInset = MJRefreshLabelLeftInset
        
        self.setTitle(title: Bundle.mj_localizedStringForKey(key: MJRefreshHeaderIdleText), forState: .idle)
        
        self.setTitle(title: Bundle.mj_localizedStringForKey(key: MJRefreshHeaderPullingText), forState: .pulling)
        
        self.setTitle(title: Bundle.mj_localizedStringForKey(key: MJRefreshHeaderRefreshingText), forState: .refreshing)
        
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        if self.stateLabel.isHidden{
            return
        }
        
        let noConstrainsOnStatusLabel = self.stateLabel.constraints.count == 0
        if  self.lastUpdatedTimeLabel.isHidden{
            if noConstrainsOnStatusLabel {
                self.stateLabel.frame = self.bounds
            }
        }else{
            let stateLabelH = self.mj_height * 0.5
            
            
            if noConstrainsOnStatusLabel {
                self.stateLabel.mj_x = 0
                self.stateLabel.mj_y = 0
                self.stateLabel.mj_width = self.mj_width
                self.stateLabel.mj_height = stateLabelH
            }
            
            if self.lastUpdatedTimeLabel.constraints.count == 0 {
                self.lastUpdatedTimeLabel.mj_x = 0
                self.lastUpdatedTimeLabel.mj_y = stateLabelH
                self.lastUpdatedTimeLabel.mj_width = self.mj_width
                self.lastUpdatedTimeLabel.mj_height = self.mj_height - self.lastUpdatedTimeLabel.mj_y
            }
        }
    }
    
        
    
}
