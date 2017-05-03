//
//  UITextField+Adjust.h
//  TextFieldAdjust_Demo
//
//  Created by admin on 16/9/26.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <UIKit/UIKit.h>
//我们给输入框提供一个设置自动适应的接口
@interface UITextField (Adjust)

// 自动适应
- (void)setAutoAdjust: (BOOL)autoAdjust;

@end
