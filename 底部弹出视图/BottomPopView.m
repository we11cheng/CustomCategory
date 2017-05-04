//
//  BottomPopView.m
//  BottomPopView_Demo
//
//  Created by admin on 16/8/3.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "BottomPopView.h"


@interface BottomPopView ()
@property (nonatomic ,strong) UIView *bottomPopView; //底部View
@property (nonatomic ,strong) UIView *bgView; //遮罩
@end

@implementation BottomPopView

-(void)show{
    // ------全屏遮罩
    self.bgView                 = [[UIView alloc] init];
    self.bgView.frame           = [[UIScreen mainScreen] bounds];
    self.bgView.tag             = 100;
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.bgView.opaque = NO;
    
    //--UIWindow的优先级最高，Window包含了所有视图，在这之上添加视图，可以保证添加在最上面
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self.bgView];
    
    // ------给全屏遮罩添加的点击事件
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    gesture.numberOfTapsRequired = 1;
    gesture.cancelsTouchesInView = NO;
    [self.bgView addGestureRecognizer:gesture];
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }];
    
    // ------底部弹出的View
    self.bottomPopView                 = [[UIView alloc] init];
    self.bottomPopView.frame           = CGRectMake(0, kScreenWidth, kScreenWidth, kScreenWidth);
    self.bottomPopView.backgroundColor = [UIColor redColor];
    [keyWindow addSubview:self.bottomPopView];
    
    // ------View出现动画
    self.bottomPopView.transform = CGAffineTransformMakeTranslation(0.01, kScreenHeight);
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomPopView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
        
    }];

}
-(void)hidden{
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomPopView.transform = CGAffineTransformMakeTranslation(0.01, kScreenWidth);
        self.bottomPopView.alpha = 0.2;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self.bottomPopView removeFromSuperview];
    }];
}

@end
