//
//  LBNavTabbarView.m
//  LBzzz
//
//  Created by fighting on 17/2/7.
//  Copyright © 2017年 labi. All rights reserved.
//

#import "LBNavTabbarView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define FONTMAX 15.0
#define FONTMIN 14.0
#define PADDING 15.0
@interface LBNavTabbarView ()<UIScrollViewDelegate>

@property (nonatomic , strong)NSArray * vcArr;

@property (nonatomic , strong)NSArray * viewArr;

@property (nonatomic , strong)NSArray * titleArr;

@property (nonatomic , strong)UIImageView * lineImgView;

@property (nonatomic , strong)UIButton * currentBtn;

@property (nonatomic , strong)UIScrollView * showScroll;

@property (nonatomic , strong)UIScrollView * itemScroll;

@property (nonatomic , assign) CGFloat lineHeight;

@property (nonatomic , assign)NSInteger currentPage;

@end

@implementation LBNavTabbarView

- (instancetype)initWithFrame:(CGRect)frame andVCArr:(NSArray<UIViewController *> *)vcArr andTitleArr:(NSArray <NSString *>*)titleArr lineHeight:(CGFloat)lineHeight
{
    if (self = [super init]) {
        self.frame = frame;
        self.vcArr = [NSArray arrayWithArray:vcArr];
        self.titleArr = [NSArray arrayWithArray:titleArr];
        self.lineHeight = lineHeight;
        [self addSubview:self.itemScroll];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andViewArr:(NSArray<UIView *> *)viewArr andTitleArr:(NSArray <NSString *>*)titleArr lineHeight:(CGFloat)lineHeight
{
    if (self = [super init]) {
        self.frame = frame;
        self.viewArr = [NSArray arrayWithArray:viewArr];
        self.titleArr = [NSArray arrayWithArray:titleArr];
        self.lineHeight = lineHeight;
        [self addSubview:self.itemScroll];
    }
    return self;
}
//初始化操作
- (UIScrollView *)itemScroll
{
    if (_itemScroll == nil) {
        _itemScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
        _itemScroll.showsHorizontalScrollIndicator = NO;
        _itemScroll.showsVerticalScrollIndicator = NO;
        _itemScroll.alwaysBounceHorizontal = NO;
        _itemScroll.alwaysBounceVertical = YES;
        _itemScroll.bounces = NO;
        _itemScroll.backgroundColor = [UIColor whiteColor];
        [_itemScroll addSubview:self.lineImgView];
        NSInteger btnOffset = 0;
        for (int i = 0; i < self.titleArr.count; i++) {
            //添加上面的小标题按钮
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
            if (self.titleColor) {
                [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }
            if (self.selectedTColor) {
                [btn setTitleColor:self.selectedTColor forState:UIControlStateSelected];
            }else{
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            }
            
            btn.titleLabel.font = [UIFont systemFontOfSize:FONTMIN];
            CGSize size = [self sizeOfLabelWithCustomMaxWidth:SCREEN_WIDTH systemFontSize:FONTMIN andFilledTextString:_titleArr[i]];
            float originX =  i? PADDING*2+btnOffset:PADDING;
            btn.frame = CGRectMake(originX, 0, size.width, self.frame.size.height - self.lineHeight);
            btnOffset = CGRectGetMaxX(btn.frame);
            btn.titleLabel.textAlignment = NSTextAlignmentLeft;
            [btn addTarget:self action:@selector(changeSelectedItem:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 111 + i;
            [_itemScroll addSubview:btn];
            //contentSize 等于按钮长度叠加
            
            //默认选中第一个按钮
            if (i == 0) {
                self.currentBtn = btn;
                btn.selected = YES;
                self.lineImgView.frame = CGRectMake(PADDING, self.frame.size.height - self.lineHeight, btn.frame.size.width, self.lineHeight);
            }
            
            //添加下面的显示View
            UIView * view = nil;
            if (self.vcArr) {
                UIViewController * vc = self.vcArr[i];
                view = vc.view;
            }
            if (self.viewArr) {
                view= self.viewArr[i];
            }
            view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.frame.origin.y - _itemScroll.frame.size.height);
            [self.showScroll addSubview:view];
        }
        _itemScroll.contentSize = CGSizeMake(btnOffset+PADDING, self.frame.size.height);
    }
    return _itemScroll;
}
//初始化操作
- (UIScrollView *)showScroll
{
    if (_showScroll == nil) {
        _showScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.frame.origin.y + self.itemScroll.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.frame.origin.y + self.itemScroll.frame.size.height)];
        _showScroll.contentSize = CGSizeMake(SCREEN_WIDTH * self.titleArr.count , SCREEN_HEIGHT - self.frame.origin.y + self.itemScroll.frame.size.height);
        _showScroll.showsHorizontalScrollIndicator = NO;
        _showScroll.showsVerticalScrollIndicator = NO;
        _showScroll.alwaysBounceHorizontal = NO;
        _showScroll.alwaysBounceVertical = YES;
        _showScroll.bounces = NO;
        _showScroll.pagingEnabled = YES;
        _showScroll.delegate = self;
        _showScroll.backgroundColor = [UIColor whiteColor];
        [[self currentViewController].view addSubview:_showScroll];
    }
    return _showScroll;
}

//获取当前视图控制器
- (UIViewController *)currentViewController
{
    UIViewController *viewController = [[UIApplication sharedApplication].windows firstObject].rootViewController;
    while (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }
    return viewController;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / SCREEN_WIDTH;
    UIButton * currentButton = [self viewWithTag:111 + index];
    self.currentBtn.selected = NO;
    currentButton.selected = YES;
    self.currentBtn = currentButton;
    [UIView animateWithDuration:0.3 animations:^{
        if (index == 0) {
            self.lineImgView.frame = CGRectMake(PADDING, self.frame.size.height - self.lineHeight,currentButton.frame.size.width, self.lineHeight);
        }else{
            float offsetX = CGRectGetMinX(currentButton.frame);
            if (offsetX < SCREEN_WIDTH/2) {
                self.itemScroll.contentOffset = CGPointMake(0, 0);
            }else if (offsetX >= SCREEN_WIDTH/2 && offsetX <= self.itemScroll.contentSize.width - SCREEN_WIDTH/2) {
                self.itemScroll.contentOffset = CGPointMake(offsetX - SCREEN_WIDTH/2+ PADDING, 0);
            }else{
                self.itemScroll.contentOffset = CGPointMake(self.itemScroll.contentSize.width - SCREEN_WIDTH, 0);
            }
            
            self.lineImgView.frame = CGRectMake(CGRectGetMinX(currentButton.frame), self.frame.size.height - self.lineHeight, currentButton.frame.size.width, self.lineHeight);
        }
        
    }];
}
#pragma  mark - 选项卡点击事件

/**
 *  选项卡的点击
 *
 *  @param currentButton 当前点击按钮
 */
-(void)changeSelectedItem:(UIButton *)currentButton{
    
    self.currentBtn.selected = NO;
    currentButton.selected = YES;
    self.currentBtn = currentButton;
    NSInteger flag = currentButton.tag - 111;
    self.showScroll.contentOffset = CGPointMake(flag * SCREEN_WIDTH, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (flag == 0) {
            self.lineImgView.frame = CGRectMake(PADDING, self.frame.size.height - self.lineHeight,currentButton.frame.size.width, self.lineHeight);
        }else{
            float offsetX = CGRectGetMinX(currentButton.frame);
            if (offsetX < SCREEN_WIDTH/2) {
                self.itemScroll.contentOffset = CGPointMake(0, 0);
            }else if (offsetX >= SCREEN_WIDTH/2 && offsetX <= self.itemScroll.contentSize.width - SCREEN_WIDTH/2) {
                self.itemScroll.contentOffset = CGPointMake(offsetX - SCREEN_WIDTH/2+ PADDING, 0);
            }else{
                self.itemScroll.contentOffset = CGPointMake(self.itemScroll.contentSize.width - SCREEN_WIDTH, 0);
            }
            
            self.lineImgView.frame = CGRectMake(CGRectGetMinX(currentButton.frame), self.frame.size.height - self.lineHeight, currentButton.frame.size.width, self.lineHeight);
        }
        
    }];
}
//根据文字长度返回size
- (CGSize)sizeOfLabelWithCustomMaxWidth:(CGFloat)width systemFontSize:(CGFloat)fontSize andFilledTextString:(NSString *)str{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = str;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    //让label通过文字设置size
    [label sizeToFit];
    //获取label 的size
    CGSize size = label.frame.size;
    //返回出去
    return size;
}
//初始化操作
- (UIImageView *)lineImgView {
    if (!_lineImgView) {
        _lineImgView = [[UIImageView alloc] init];
        //_lineImgView.image = [UIImage imageNamed:@"nar_bgbg"];
        if (self.downLineColor) {
            _lineImgView.backgroundColor = self.downLineColor;
        }else{
            _lineImgView.backgroundColor = [UIColor redColor];
        }
    }
    return _lineImgView;
}

@end
