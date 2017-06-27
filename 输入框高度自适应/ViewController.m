//
//  ViewController.m
//  textInput
//
//  Created by fangliguo on 2017/4/11.
//  Copyright © 2017年 fangliguo. All rights reserved.
//

#import "ViewController.h"
#import "inputView.h"

@interface ViewController ()<inputViewDelegate>
@property (nonatomic, strong) inputView *input;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"评论" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
}

- (void)action{
    self.input = [[inputView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen] .bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    [self.view addSubview:self.input];
    self.input.delegate = self;
    [self.input inputViewShow];

}
- (void)sendText:(NSString *)text{
    NSLog(@"----------%@",text);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
