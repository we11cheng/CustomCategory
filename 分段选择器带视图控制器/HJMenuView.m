//
//  HJMenuView.m
//  分页控制器
//
//  Created by 韩佳 on 16/3/19.
//  Copyright © 2016年 DDG. All rights reserved.
//

#import "HJMenuView.h"
#import "UIView+HJFrame.h"

@interface HJMenuView()

@property (weak, nonatomic) IBOutlet UIButton *leftBuuton;

@property (weak, nonatomic) IBOutlet UIButton *middleButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIView *animateView;

@end

@implementation HJMenuView


- (instancetype)init{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HJMenuView" owner:nil options:nil] lastObject];
}
#pragma mark -
#pragma mark 默认选中第一个按钮
- (void)awakeFromNib{
    self.leftBuuton.selected = YES;
}
#pragma mark -
#pragma mark 点击事件
- (IBAction)didClickLeftButton:(id)sender {
    if (_scrollView) {
        [_scrollView setContentOffset:CGPointZero animated:YES];
    }
}
- (IBAction)didClickMiddleButton:(id)sender {
    if (_scrollView) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width / 3.f, 0) animated:YES];
    }
}
- (IBAction)didClickRightButton:(id)sender {
    
    if (_scrollView) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width / 3.f * 2, 0) animated:YES];
    }
}

- (void)setWidth:(CGFloat)width{
    _width = width;
    self.w = width;
}
#pragma mark -
#pragma mark 设置分页线滚动以及按钮的状态
- (void)animateViewProgress:(CGFloat)progress{
    
    if (progress > 0 && progress < 1) {
        self.animateView.x = self.w * progress;
    }
    
    if (progress > 1/6.f && progress < 0.5) {
        
        [self selectMiddleButton];
        
    }else if (progress > 0.5){
        
        [self selectRightButton];
        
    }else{
        
        [self selectLeftButton];
        
    }
}
#pragma mark -
#pragma mark 选中状态
- (void)selectLeftButton{
    if (!self.leftBuuton.selected) {
        self.leftBuuton.selected = YES;
        self.middleButton.selected = NO;
        self.rightButton.selected = NO;
    }
}

- (void)selectMiddleButton{
    if (!self.middleButton.selected) {
        self.middleButton.selected = YES;
        self.leftBuuton.selected = NO;
        self.rightButton.selected = NO;
    }
}

- (void)selectRightButton{
    if (!self.rightButton.selected) {
        self.rightButton.selected = YES;
        self.middleButton.selected = NO;
        self.leftBuuton.selected = NO;
    }
}

#pragma mark -
#pragma mark 按钮文字
- (void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    if (_leftTitle) {
        [self.leftBuuton setTitle:leftTitle forState:UIControlStateNormal];
        [self.leftBuuton setTitle:leftTitle forState:UIControlStateSelected];
    }
}

- (void)setMiddleTitle:(NSString *)middleTitle{
    _middleTitle = middleTitle;
    if (_middleButton) {
        [self.middleButton setTitle:middleTitle forState:UIControlStateNormal];
        [self.middleButton setTitle:middleTitle forState:UIControlStateSelected];
    }
}

- (void)setRightTitle:(NSString *)rightTitle{
    _rightTitle = rightTitle;
    if (_rightButton) {
        [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
        [self.rightButton setTitle:rightTitle forState:UIControlStateSelected];
    }
}




@end
