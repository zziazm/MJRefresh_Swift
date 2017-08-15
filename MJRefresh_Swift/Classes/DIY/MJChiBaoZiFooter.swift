//
//  MJChiBaoZiFooter.swift
//  MJRefresh_Swift
//
//  Created by zm on 2017/8/1.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJChiBaoZiFooter: MJRefreshAutoGifFooter {
    override func prepare() {
        super.prepare()
        var refreshingImages = [UIImage]()
        for i in 1...3 {
            if let image = UIImage(named: String(format: "dropdown_loading_0%zd",i)) {
                refreshingImages.append(image)
            }
        }
        self.set(images: refreshingImages, for: .refreshing)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
