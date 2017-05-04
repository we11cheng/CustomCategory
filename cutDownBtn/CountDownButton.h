//
//  CountDownButton.h
//  CountDownButton
//
//  Created by liquan on 2017/4/17.
//  Copyright © 2017年 liquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownButton : UIButton

//设置开始倒计时的时间 默认是60s
@property(nonatomic,assign)NSInteger count;
//点击按钮
@property(nonatomic,copy)void(^ClickButtonBlock)();
//倒计时完成后的回调
@property(nonatomic,copy)void(^CompleteBlock)();


/**
 初始化

 @param isAuto 是否自动倒计时
 */
-(instancetype)initWithIsAuto:(BOOL)isAuto;
-(instancetype)initWithFrame:(CGRect)frame withIsAuto:(BOOL)isAuto;
@end
