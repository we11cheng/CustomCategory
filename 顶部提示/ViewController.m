//
//  ViewController.m
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import "ViewController.h"

#import "ZAlertView.h"
#import "ZAlertViewManager.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)HUD:(id)sender {
}

- (IBAction)show:(id)sender
{
    [[ZAlertViewManager shareManager] showWithType:AlertViewTypeSuccess];
}

- (IBAction)dismiss:(id)sender
{
    [[ZAlertViewManager shareManager] dismissWithTime:0];
}
- (IBAction)show2:(id)sender
{
    [[ZAlertViewManager shareManager] showWithType:AlertViewTypeError];
}

- (IBAction)dismiss2:(id)sender
{
    [[ZAlertViewManager shareManager] dismissWithTime:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
