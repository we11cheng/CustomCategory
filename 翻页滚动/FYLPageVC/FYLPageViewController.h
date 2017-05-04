//
//  ViewController.h
//  FYLPageViewController
//
//  Created by FuYunLei on 2017/4/17.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYLSegmentView.h"


/*
 
 如要改变头部样式,可修改FYLSegmentView实现
 
 */

@interface FYLPageViewController : UIViewController

/**
 初始化方法

 @param titles 头部标签数组
 @param viewControllers 控制器数组
 @return PageVC
 */
- (instancetype)initWithTitles:(NSArray *)titles viewControllers:(NSArray *)viewControllers;

@end

