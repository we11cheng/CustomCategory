//
//  HJMenuView.h
//  分页控制器
//
//  Created by 韩佳 on 16/3/19.
//  Copyright © 2016年 DDG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJMenuView : UIView

@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, copy) NSString *rightTitle;
@property (nonatomic, copy) NSString *middleTitle;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat width;


- (void)animateViewProgress:(CGFloat)progress;

@end
