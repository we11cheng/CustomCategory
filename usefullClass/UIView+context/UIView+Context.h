//
//  UIView+Context.h
//  KeyBoard
//
//  Created by 向彪 on 15/11/27.
//  Copyright © 2015年 Ritchie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Context)

- (void)setBoardWidth:(CGFloat)with;

- (CGFloat)borderWidth;

- (UIColor *)borderColor;

- (CGFloat)x;

- (CGFloat)y;

- (CGFloat)width;

- (CGFloat)height;

- (CGPoint)origin;

- (CGSize)size;

- (void)setX:(CGFloat)x;

- (void)setY:(CGFloat)y;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

- (void)setOrigin:(CGPoint)origin;

- (void)setSize:(CGSize)size;

- (CGFloat)left;

- (CGFloat)right;

- (CGFloat)top;

- (CGFloat)bottom;

@end

@interface UIView (FindFirstResponder)

- (UIView *)findFirstResponder;

@end












