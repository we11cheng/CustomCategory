//
//  UIView+Context.m
//  KeyBoard
//
//  Created by 向彪 on 15/11/27.
//  Copyright © 2015年 Ritchie. All rights reserved.
//

#import "UIView+Context.h"

@implementation UIView (Context)

- (void)setBoardWidth:(CGFloat)with
{
    self.layer.borderWidth = with;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width;
{
    return self.frame.size.width;
}

- (CGFloat)height;
{
    return self.frame.size.height;
}

- (CGPoint)origin;
{
    return self.frame.origin;
}

- (CGSize)size;
{
    return self.frame.size;
}

- (void)setX:(CGFloat)x;
{
    self.frame = (CGRect){
        .origin = {.x =x, .y = self.y},
        .size   = {.width = self.width, .height = self.height}
    };
}

- (void)setY:(CGFloat)y
{
    self.frame = (CGRect){
        .origin = {.x = self.x, .y = y},
        .size   = {.width = self.width, .height = self.height}
    };
}

- (void)setWidth:(CGFloat)width;
{
    self.frame = (CGRect){
        .origin = {.x = self.x, .y = self.y},
        .size   = {.width = width, .height = self.height}
    };
}

- (void)setHeight:(CGFloat)height;
{
    self.frame = (CGRect){
        .origin = {.x = self.x, .y = self.y},
        .size   = {.width = self.width, .height = height}
    };
}

- (void)setOrigin:(CGPoint)origin;
{
    self.frame = (CGRect){
        .origin = {.x = origin.x, .y = origin.y},
        .size   = {.width = self.width, .height = self.height}
    };
}

- (void)setSize:(CGSize)size;
{
    self.frame = (CGRect){
        .origin = {.x = self.x, .y = self.y},
        .size   = {.width = size.width, .height = size.height}
    };
}

- (CGFloat)left;
{
    return self.frame.origin.x;
}

- (CGFloat)right;
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)top;
{
    return self.frame.origin.y;
}

- (CGFloat)bottom;
{
    return self.frame.origin.y + self.frame.size.height;
}

@end

@implementation UIView (FindFirstResponder)

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        
        UIView *responder = [subView findFirstResponder];
        if (responder) {
            return responder;
        }
        
    }
    return nil;
}

@end







