//
//  GlobalUI.h
//  DouBeDemo
//
//  Created by gaolili on 16/5/4.
//  Copyright © 2016年 mRocker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GlobalUI : NSObject
+ (UIImageView *)createImageViewbgColor:(UIColor *)bgColor;
+ (UILabel *)createLabelFont:(CGFloat )fontsize titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor;
+ (UIButton *)createButtonWithImg:(UIImage *)img title:(NSString *)title titleColor:(UIColor *)titleColor;
@end
