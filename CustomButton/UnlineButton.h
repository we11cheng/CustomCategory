//
//  UnlineButton.h
//  QMUITest
//
//  Created by 可可家里 on 2017/7/20.
//  Copyright © 2017年 可可家里. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapHandler)(UIButton * sender);
@interface UnlineButton : UIButton
@property (nonatomic,strong) tapHandler handler;

/**
  带有下划线的Button

 @param buttonType <#buttonType description#>
 @param frame 按钮的大小位置
 @param title 按钮title
 @param titleColor 字体颜色
 @param bgColor 背景颜色
 @param unlineColor 下划线颜色
 @param range 下划线的范围
 @param handler  点击处理事件
 @return <#return value description#>
 */
+(id)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title     titleColor:(UIColor *)titleColor  backgroundColor:(UIColor *)bgColor unlineColor:(UIColor*)unlineColor unlineRange:(NSRange) range handler:(tapHandler)handler;
@end
