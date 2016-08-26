//
//  ViewController.m
//  keyChainDemo
//
//  Created by mac on 16/8/12.
//  Copyright © 2016年 TXZhongJiaowang. All rights reserved.
//

#import "ViewController.h"
#import "WQUserDataManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [WQUserDataManager savePassWord:@"123"];
    
}

- (IBAction)show:(UIButton *)sender {
    self.showLabel.text = [WQUserDataManager readPassWord];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
