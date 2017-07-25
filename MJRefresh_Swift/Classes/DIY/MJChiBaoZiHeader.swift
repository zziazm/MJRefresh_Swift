//
//  MJChiBaoZiHeader.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/25.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJChiBaoZiHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        // 设置普通状态的动画图片
        var idleImages: [UIImage] = [UIImage]()
        for i in 1...60 {
            if let image = UIImage(named:String(format: "dropdown_anim__000%zd", i)){
                idleImages.append(image)

            }
        }
        
        self.set(images: idleImages, _for: .idle)
        
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        var refreshingImages: [UIImage] = [UIImage]()
        for i in 1...3 {
            if let image = UIImage(named:String(format: "dropdown_loading_0%zd", i)){
                refreshingImages.append(image)
            }
        }
        self .set(images: refreshingImages, _for: .pulling)
        
        // 设置正在刷新状态的动画图片
        self.set(images: refreshingImages, _for: .refreshing)

        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
