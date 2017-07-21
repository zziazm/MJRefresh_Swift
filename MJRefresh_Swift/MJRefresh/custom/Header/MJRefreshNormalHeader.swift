//
//  MJRefreshNormalHeader.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/20.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJRefreshNormalHeader: MJRefreshStateHeader {
     lazy var arrowView: UIImageView = {
        
        let arrowView = UIImageView(image: Bundle.mj_arrowImage())
        return arrowView
        
    }()
    
    var activityIndicatorViewStyle: UIActivityIndicatorViewStyle = .gray{
        didSet{
            loadingView.activityIndicatorViewStyle = activityIndicatorViewStyle
            self.setNeedsLayout()
        }
    }

     lazy var loadingView: UIActivityIndicatorView = {
        
        let loadingView = UIActivityIndicatorView(activityIndicatorStyle:.gray)
        loadingView.hidesWhenStopped = true
        return loadingView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepare() {
        super.prepare()
        self.addSubview(arrowView)
        self.addSubview(loadingView)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        var arrowCenterX = self.mj_width * 0.5
        if !self.stateLabel.isHidden {
            let stateWidth = self.stateLabel.mj_textWith()
            var  timeWidth: CGFloat = 0.0
            if !self.lastUpdatedTimeLabel.isHidden {
                timeWidth = self.lastUpdatedTimeLabel.mj_textWith()
            }
            
            let textWidth = max(stateWidth, timeWidth)
            arrowCenterX -= textWidth/2.0 + self.labelLeftInset
        }
        
        let arrowCenterY = self.mj_height * 0.5
        let arrowCenter = CGPoint(x: arrowCenterX, y: arrowCenterY)
        
        if self.arrowView.constraints.count == 0 {
            self.arrowView.mj_size = (self.arrowView.image?.size)!
            self.arrowView.center = arrowCenter
        }
        
        if self.loadingView.constraints.count == 0 {
            self.loadingView.center = arrowCenter
        }
        
        self.arrowView.tintColor = self.stateLabel.textColor
    }
    
    
    override var state: MJRefreshState{
        didSet{
            
            if state == .idle {
                if oldValue == .refreshing {
                    self.arrowView.transform = CGAffineTransform.identity
                    UIView.animate(withDuration: MJRefreshSlowAnimationDuration, animations: {
                        self.loadingView.alpha = 0.0
                    }, completion: { (finished) in
                        if self.state != .idle {
                            self.loadingView.alpha = 1.0
                            self.loadingView.stopAnimating()
                            self.arrowView.isHidden = false
                        }
                    })
                }else{
                    self.loadingView.stopAnimating()
                    self.arrowView.isHidden = false
                    UIView.animate(withDuration: MJRefreshFastAnimationDuration, animations: { 
                        self.arrowView.transform = CGAffineTransform.identity
                    })
                }
                
            }else if state == .pulling{
                self.loadingView.stopAnimating()
                self.arrowView.isHidden = false
                UIView.animate(withDuration: MJRefreshFastAnimationDuration, animations: { 
                    self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(0.000001 - .pi))
                })
            }else if state == .refreshing{
                self.loadingView.alpha = 1.0
                self.loadingView.startAnimating()
                self.arrowView.isHidden = true
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
