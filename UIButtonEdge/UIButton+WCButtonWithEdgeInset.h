//
//  UIButton+WHButtonWithEdgeInset.h
//  TestGwc
//
//  Created by admin on 11/01/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WCButtonEdgeInsetsStyle) {
    WCButtonEdgeInsetsStyleTop = 0,//图片在上，title在下
    WCButtonEdgeInsetsStyleLeft = 1,//图片在左，title在右
    WCButtonEdgeInsetsStyleBottom = 2,//图片在下，title在上
    WCButtonEdgeInsetsStyleRight = 3,//图片在右，title在左边
};

@interface UIButton (WCButtonWithEdgeInset)

- (void)wcButtonWithEdgeInsetsStyle:(WCButtonEdgeInsetsStyle)style
                    imageTitleSpace:(CGFloat)space;//space:图片和标题间距

@end
