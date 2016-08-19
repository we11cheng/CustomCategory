//
//  HJTestViewController.m
//  分页控制器
//
//  Created by 韩佳 on 16/3/19.
//  Copyright © 2016年 DDG. All rights reserved.
//

#import "HJTestViewController.h"
#import "HJLeftViewController.h"
#import "HJMiddleViewController.h"
#import "HJRightViewController.h"


@interface HJTestViewController ()

@end

@implementation HJTestViewController

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分页控制器";

    self.leftController = [[HJLeftViewController alloc] init];
    self.leftMenuTitle = @"左控制器";
    
    self.middleController = [[HJMiddleViewController alloc] init];
    self.middleMuneTitle = @"中控制器";
    
    self.rightController = [[HJRightViewController alloc] init];
    self.rightMuneTitle = @"右控制器";
}



@end
