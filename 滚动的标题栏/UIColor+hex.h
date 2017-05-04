//
//  UIColor+hex.h
//  NoCardPay
//
//  Created by lizq on 16/5/13.
//  Copyright © 2016年 tangyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (hex)
@property (nonatomic, assign) float r;
@property (nonatomic, assign) float g;
@property (nonatomic, assign) float b;
@property (nonatomic, assign) float apha;

//十六进制生成颜色
+ (UIColor *)colorWithHexString:(NSString *)color;
@end