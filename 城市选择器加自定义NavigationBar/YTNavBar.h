//
//  YTNavBar.h
//  LoveFreshBeenOC
//
//  Created by youyou on 16/3/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTNavBar : UIView

- (instancetype)initWithFrame:(CGRect)frame backColor:(UIColor *)color centerTitle:(NSString *)cenTitle backAction:(SEL)goBack target:(id)target title:(NSString *)buttonTitle backImage:(NSString *)imageName;


@end
