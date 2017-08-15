//
//  MJRefreshBackNormalFooter.swift
//  MJRefresh_Swift
//
//  Created by zm on 2017/7/28.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJRefreshBackNormalFooter: MJRefreshBackStateFooter {
    
    lazy var arrowView: UIImageView = {
        let arrowView = UIImageView(image:  Bundle.mj_arrowImage())
        return arrowView
    }()
    
    var activityIndicatorViewStyle: UIActivityIndicatorViewStyle = .gray {
        didSet{
            self.loadingView = nil
            self.setNeedsLayout()
        }
    }
    
    lazy var loadingView: UIActivityIndicatorView? = {
        let loadingView = UIActivityIndicatorView(activityIndicatorStyle: self.activityIndicatorViewStyle)
        return loadingView
    }()
    
    
    override func prepare() {
        super.prepare()
        self.addSubview(self.arrowView)
        if self.loadingView != nil {
            self.addSubview(self.loadingView!)
        }
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        var arrowCenterX = self.mj_width * 0.5
        if !self.stateLabel.isHidden {
            arrowCenterX -= self.labelLeftInset + self.stateLabel.mj_textWith() * 0.5
        }
        
        let arrowCenterY = self.mj_height * 0.5
        
        let arrowCenter = CGPoint(x: arrowCenterX, y: arrowCenterY)
        
        if self.arrowView.constraints.count == 0{
            if let image = self.arrowView.image{
                self.arrowView.mj_size = image.size
            }
            self.arrowView.center = arrowCenter
        }
        
        if let loadingView = self.loadingView {
            if loadingView.constraints.count == 0 {
                loadingView.center = arrowCenter
            }
        }
        self.arrowView.tintColor = self.stateLabel.textColor
    }
    
    override var state: MJRefreshState{
        didSet{
            if state == .idle {
                if oldValue == .refreshing {
                    self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(0.000001 - Float.pi))
                    UIView.animate(withDuration: MJRefreshSlowAnimationDuration, animations: {
                        self.loadingView?.alpha = 0.0
                    }, completion: { (finished) in
                        self.loadingView?.alpha = 1.0
                        self.loadingView?.stopAnimating()
                        self.arrowView.isHidden = false
                    })
                }else {
                    self.arrowView.isHidden = false
                    self.loadingView?.stopAnimating()
                    UIView.animate(withDuration: MJRefreshFastAnimationDuration, animations: { 
                        self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(0.000001 - Float.pi))

                    })
                }
            }else if state == .pulling {
                self.arrowView.isHidden = false
                self.loadingView?.stopAnimating()
                UIView.animate(withDuration: MJRefreshFastAnimationDuration, animations: { 
                    self.arrowView.transform = CGAffineTransform.identity
                })
            }else if state == .refreshing {
                self.arrowView.isHidden = true
                self.loadingView?.startAnimating()
                
            }else if state == .noMoreData {
                self.arrowView.isHidden = true
                self.loadingView?.stopAnimating()
            }
        }
    }
    
    

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
