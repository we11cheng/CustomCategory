//
//  ViewController.m
//  CustomButton
//
//  Created by 可可家里 on 2017/7/20.
//  Copyright © 2017年 可可家里. All rights reserved.
//

#import "ViewController.h"
#import "CustomButton.h"
#import "UnlineButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定button 图片在上 文字在下
    CustomButton * btn=  [CustomButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(100, 100, 50, 50) title:@"test" image:[UIImage imageNamed:@"01-32x32"] backgroundColor:[UIColor whiteColor] handler:^(UIButton *sender) {
        NSLog(@"测试");
    }];
    
    //含有下划线的
    UnlineButton *btn1 =[UnlineButton  buttonWithType:UIButtonTypeCustom frame:CGRectMake(100, 230, 100, 100) title:@"5254747" titleColor:[UIColor redColor] backgroundColor:[UIColor whiteColor] unlineColor:[UIColor  grayColor] unlineRange:NSMakeRange(0, 7) handler:^(UIButton *sender) {
        NSLog(@"测试1");
    }];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
