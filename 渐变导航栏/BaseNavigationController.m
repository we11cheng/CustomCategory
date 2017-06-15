//
//  BaseNavigationController.m
//  QQGradientNav
//
//  Created by fc_curry on 2017/5/17.
//  Copyright © 2017年 fc_curry. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barStyle = UIBarStyleBlack;
    // 去掉导航栏底部的线
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    //渐变
    [self.navigationBar.layer insertSublayer:[self gradientLayer] atIndex:0];
}
- (CAGradientLayer *)gradientLayer {
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc]init];
    // CGColor是无法放入数组中的，必须要转型。
    gradientLayer.colors = @[
                             (__bridge id)[UIColor colorWithRed:78 / 255.0 green:143 / 255.0 blue:1.0 alpha:1.0].CGColor,
                             (__bridge id)[UIColor colorWithRed:39 / 255.0 green:196 / 255.0 blue:254 / 255.0 alpha:1.0].CGColor,
                             (__bridge id)[UIColor colorWithRed:60 / 255.0 green:143 / 255.0 blue:1.0 alpha:1.0].CGColor,
                             ];
    // 颜色分割线
    gradientLayer.locations = @[@0, @0.8,@1.5];
    // 颜色渐变的起点和终点，范围为 (0~1.0, 0~1.0)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, -20, self.navigationBar.bounds.size.width, 20 + self.navigationBar.bounds.size.height);
    return gradientLayer;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
