//
//  MJChiBaoZiFooter2.swift
//  MJRefresh_Swift
//
//  Created by zm on 2017/8/2.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJChiBaoZiFooter2: MJRefreshBackGifFooter {
    override func prepare() {
        super.prepare()
        var idleImages = [UIImage]()
        for i in 1...60 {
            if let image = UIImage(named: String(format: "dropdown_anim__000%zd", i)){
                idleImages.append(image)
            }
        }
        
        self.set(images: idleImages, for: .idle)
        
        var refreshingImages = [UIImage]()
        for i in 1...3 {
            if let image = UIImage(named: String(format: "dropdown_loading_0%zd", i)){
                refreshingImages.append(image)
            }
        }
        self.set(images: refreshingImages, for: .pulling)
        
        
        self.set(images: refreshingImages, for: .refreshing)
        
        
    }
}
