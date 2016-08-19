//
//  UIView+HJFrame.m
//  guideView
//
//  Created by 韩佳 on 16/3/12.
//  Copyright © 2016年 DDG. All rights reserved.
//

#import "UIView+HJFrame.h"

@implementation UIView (HJFrame)

- (CGFloat)x {
    // 返回当前控件的x值
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


// y
- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


// w
- (CGFloat)w {
    return self.frame.size.width;
}
- (void)setW:(CGFloat)w {
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}


// h
- (CGFloat)h {
    return self.frame.size.height;
}
- (void)setH:(CGFloat)h {
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}


@end
