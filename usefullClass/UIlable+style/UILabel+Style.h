//
//  UILabel+Style.h
//  SuperWallet_Personal
//
//  Created by 赵诣 on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Style)

//根据文字来定义label的高度
+ (CGFloat)heightWithText:(NSString *)text fontSize:(NSInteger)fontSize labelWidth:(CGFloat)labelWidth;

//修改label内字体大小
- (void)setText:(NSString *)text
       textFont:(UIFont *)textFont
      fontRange:(NSRange)fontRange;

//修改label内字体文字颜色
- (void)setText:(NSString *)text
      textcolor:(UIColor *)color
     colorRange:(NSRange)colorRange;

//修改label内字体大小及文字颜色
- (void)setText:(NSString *)text
       textFont:(UIFont *)textFont
      fontRange:(NSRange)fontRange
      textcolor:(UIColor *)color
     colorRange:(NSRange)colorRange;

@end
