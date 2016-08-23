//
//  ViewController.m
//  DWSwipeGesture
//
//  Created by cdk on 16/8/11.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "ViewController.h"

#import "DWSwipeGestures.h"

@interface ViewController ()

@property (strong, nonatomic) DWSwipeGestures *swip;

//蓝色View
@property (weak, nonatomic) IBOutlet UIView *one;

//红色View
@property (weak, nonatomic) IBOutlet UIView *two;

@end

@implementation ViewController

- (DWSwipeGestures *)swip {
    
    if (!_swip) {
        
        _swip = [[DWSwipeGestures alloc] init];
        
    }
    
    return _swip;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    //需要进行几次点击/只有敲击手势时才使用此属性/默认为1
    self.swip.numberOfTapsRequired = 2;
    
    //需要进行操作的手指数量/默认为1
    self.swip.numberOfTouchesRequired = 2;
    
    //添加手势
    [self.swip dw_SwipeGestureType:DWTapGesture Target:self Action:@selector(click) AddView:self.one BackSwipeGestureTypeString:^(NSString * _Nonnull backSwipeGestureTypeString) {
        
        NSLog(@"%@",backSwipeGestureTypeString);
    
        }];

    
    //添加手势
    [self.swip dw_SwipeGestureType:DWRightSwipeGestures Target:self Action:@selector(right) AddView:self.two BackSwipeGestureTypeString:^(NSString * _Nonnull backSwipeGestureTypeString) {
        
        NSLog(@"%@",backSwipeGestureTypeString);
        
    }];

    
}

- (void)click {
    
    self.one.backgroundColor = [UIColor orangeColor];
    
}

- (void)right {
    
    NSLog(@"删除手势");
    
    self.two.backgroundColor = [UIColor whiteColor];
    
    //删除手势
    [self.swip dw_RemoveSwipeGesture:DWRightSwipeGestures];
    
}

@end
