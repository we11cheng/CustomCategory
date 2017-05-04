//
//  ViewController.h
//  NewsDemo
//
//  Created by lizq on 16/8/8.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQViewController : UIViewController

@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;

//必须实现
- (NSArray <UIViewController*> *)layoutContentControllers;

@end

