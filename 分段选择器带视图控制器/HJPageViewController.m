//
//  HJPageViewController.m
//  分页控制器
//
//  Created by 韩佳 on 16/3/19.
//  Copyright © 2016年 DDG. All rights reserved.
//

#import "HJPageViewController.h"
#import "HJMenuView.h"
#import "UIView+HJFrame.h"

@interface HJPageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HJMenuView *menuView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HJPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏透明效果
    self.navigationController.navigationBar.translucent = NO;

    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    
    _menuView = [[HJMenuView alloc] init];
    [self.view addSubview:_menuView];
    _menuView.scrollView =_scrollView;
}
#pragma mark -
#pragma mark 布局子控件
- (void)viewDidLayoutSubviews{
    CGFloat x = 0;
    CGFloat w = self.view.bounds.size.width;
    _menuView.width = w;

    CGFloat y = CGRectGetMaxY(_menuView.frame);
    CGFloat h = self.view.bounds.size.height - y;
    _scrollView.frame = CGRectMake(x, y, w, h);
    _scrollView.contentSize = CGSizeMake(w * 3, h);
    
    self.leftController.view.frame = CGRectMake(0, 0, w, h);
    self.middleController.view.frame = CGRectMake(w, 0, w, h);
    self.rightController.view.frame = CGRectMake(w * 2, 0, w, h);
}
#pragma mark -
#pragma mark 添加子控制器
- (void)setLeftController:(UIViewController *)leftController{
    _leftController = leftController;
    [self addChildViewController:leftController];
    [self.scrollView addSubview:leftController.view];
}

- (void)setMiddleController:(UIViewController *)middleController{
    _middleController = middleController;
    [self addChildViewController:middleController];
    [self.scrollView addSubview:middleController.view];
}

- (void)setRightController:(UIViewController *)rightController{
    _rightController = rightController;
    [self addChildViewController:rightController];
    [self.scrollView addSubview:rightController.view];
}
#pragma mark -
#pragma mark 按钮文字赋值
- (void)setLeftMenuTitle:(NSString *)leftMenuTitle{
    _leftMenuTitle = leftMenuTitle;
    _menuView.leftTitle = leftMenuTitle;
}

- (void)setMiddleMuneTitle:(NSString *)middleMuneTitle{
    _middleMuneTitle = middleMuneTitle;
    _menuView.middleTitle = middleMuneTitle;
}

- (void)setRightMuneTitle:(NSString *)rightMuneTitle{
    _rightMuneTitle = rightMuneTitle;
    _menuView.rightTitle = rightMuneTitle;
}

#pragma mark -
#pragma mark 菜单那条线滚动

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat progress = offsetX / scrollView.contentSize.width;
    [_menuView animateViewProgress:progress];
}






@end
