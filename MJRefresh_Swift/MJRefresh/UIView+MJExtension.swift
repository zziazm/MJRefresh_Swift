//
//  UIView+MJExtension.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/21.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

extension UIView{
    var mj_x: CGFloat{
        get{
            return self.frame.origin.x
        }set{
            self.frame.origin.x = newValue
        }
    }
    
    var mj_y: CGFloat{
        get{
            return self.frame.origin.y
        }set{
            self.frame.origin.y = newValue
        }
    }
    
    var mj_width: CGFloat{
        get{
            return self.frame.size.width
        }set{
            self.frame.size.width = newValue
        }
    }
    
    var mj_height: CGFloat{
        get{
            return self.frame.size.height
        }set{
            self.frame.size.height = newValue
        }
    }
    
    var mj_size: CGSize{
        get{
            return self.frame.size
        }set{
            self.frame.size = newValue
        }
    }
    
    var mj_origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.frame.origin = newValue
        }
    }
}

extension UIScrollView{
    var mj_insetTop: CGFloat {
        get{
            return self.contentInset.top
        }set{
            self.contentInset.top = newValue
            
        }
    }
    
    var mj_insetBottom: CGFloat{
        get{
            return self.contentInset.bottom
        }set{
            self.contentInset.bottom = newValue
            
        }
    }
    
    var mj_insetLeft: CGFloat{
        get{
            return self.contentInset.left
        }set{
            self.contentInset.left = newValue
        }
    }
    
    var mj_insetRight: CGFloat{
        get{
            return self.contentInset.right
        }set{
            self.contentInset.right = newValue
        }
    }
    
    var mj_offsetX: CGFloat{
        get{
            return self.contentOffset.x
        }set{
            self.contentOffset.x = newValue
        }
    }
    
    var mj_offsetY: CGFloat{
        get{
            return self.contentOffset.y
        }set{
            self.contentOffset.y = newValue
        }
    }
    
    var mj_contentWidth: CGFloat{
        get{
            return self.contentSize.width
        }set{
            self.contentSize.width = newValue
        }
    }
    
    var mj_contentHeight: CGFloat{
        get{
            return self.contentSize.height
        }set{
            self.contentSize.height = newValue
        }
    }
}
