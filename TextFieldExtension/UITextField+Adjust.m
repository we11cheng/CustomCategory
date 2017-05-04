//
//  UITextField+Adjust.m
//  TextFieldAdjust_Demo
//
//  Created by admin on 16/9/26.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "UITextField+Adjust.h"

@implementation UITextField (Adjust)


- (void)setAutoAdjust: (BOOL)autoAdjust
{
    if (autoAdjust) {
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver: self];
    }
}

- (void)keyboardWillShow: (NSNotification *)notification
{
    if (self.isFirstResponder) {
        //另一个让人头疼的问题就是输入框被键盘遮挡。这里通过在category中添加键盘相关通知来完成移动整个window。其中通过下面这个方法获取输入框在keyWindow中的相对坐标
        //- (CGPoint)convertPoint:(CGPoint)point toView:(nullable UIView *)view
        CGPoint relativePoint = [self convertPoint: CGPointZero toView: [UIApplication sharedApplication].keyWindow];
        CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
        CGFloat actualHeight = CGRectGetHeight(self.frame) + relativePoint.y + keyboardHeight;
        CGFloat overstep = actualHeight - CGRectGetHeight([UIScreen mainScreen].bounds) + 5;
        if (overstep > 0) {
            CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
            CGRect frame = [UIScreen mainScreen].bounds;
            frame.origin.y -= overstep;
            [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
                [UIApplication sharedApplication].keyWindow.frame = frame;
            } completion: nil];
        }
    }
}

- (void)keyboardWillHide: (NSNotification *)notification
{
    if (self.isFirstResponder) {
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGRect frame = [UIScreen mainScreen].bounds;
        [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
            [UIApplication sharedApplication].keyWindow.frame = frame;
        } completion: nil];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

@end
