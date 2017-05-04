//
//  ViewController.m
//  BottomPopView_Demo
//
//  Created by admin on 16/8/3.
//  Copyright © 2016年 AlezJi. All rights reserved.
//http://www.jianshu.com/p/c3a5c0db0950
//底部弹出View

#import "ViewController.h"
#import "BottomPopView.h"
@interface ViewController ()
@property(strong,nonatomic)BottomPopView *popView;
@end

@implementation ViewController


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.popView =[[BottomPopView alloc] init];
    [self.popView show];
}

@end
