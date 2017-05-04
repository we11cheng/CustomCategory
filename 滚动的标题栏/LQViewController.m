//
//  ViewController.m
//  NewsDemo
//
//  Created by lizq on 16/8/8.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQViewController.h"
#import "UIColor+hex.h"

static float const titleWidth = 80.0;

@interface LQViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *titlesScrollView;
@property (nonatomic, strong) UIScrollView *contentsScrollView;
@property (nonatomic, strong) NSMutableArray *titlesButtonArray;
@property (nonatomic, strong) UIButton *currentTitleButton;
@property (nonatomic, assign) BOOL isLayoutVC;


@end

@implementation LQViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //1.标题占位View
    [self setTitlesView];
    //2.内容占位View
    [self setContentsView];
    //3.添加父子VC
    [self addContentControllers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //4.初始化标题栏
    if (!self.isLayoutVC) {
        [self initTitleButton];
        self.isLayoutVC = YES;
    }
}

#pragma mark 标题占位View
- (void)setTitlesView {
    float titleViewY = self.navigationController.navigationBarHidden? 20 : 64;
    self.titlesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleViewY, SCREEN_WIDTH, 44)];
    self.titlesScrollView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.titlesScrollView.showsHorizontalScrollIndicator = NO;
    self.titlesScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.titlesScrollView];
}

#pragma mark 内容占位View
- (void)setContentsView {
    float contentViewY = CGRectGetMaxY(self.titlesScrollView.frame);
    self.contentsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, contentViewY, SCREEN_WIDTH, SCREEN_HEIGHT - contentViewY)];
    self.contentsScrollView.backgroundColor = [UIColor grayColor];
    self.contentsScrollView.showsHorizontalScrollIndicator = NO;
    self.contentsScrollView.showsVerticalScrollIndicator = NO;
    self.contentsScrollView.pagingEnabled = YES;
    self.contentsScrollView.delegate = self;
    self.contentsScrollView.bounces = NO;
    [self.view addSubview:self.contentsScrollView];
}

#pragma mark 添加父子VC
- (void)addContentControllers {
    NSArray *array = [self layoutContentControllers];
    NSInteger count = array.count;
    for (NSInteger i = 0; i < count; i++) {
        UIViewController *childVC = array[i];
        [self addChildViewController:childVC];
    }
}


#pragma mark 初始化标题栏
- (void)initTitleButton {

    NSInteger count = self.childViewControllers.count;
    float buttonW = titleWidth;
    if (SCREEN_WIDTH/count > buttonW) {
        buttonW = SCREEN_WIDTH/count;
    }
    for (NSInteger i = 0; i < count; i++) {
        UIViewController *childVC = self.childViewControllers[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonW*i, 0, buttonW, CGRectGetHeight(self.titlesScrollView.frame));
        [button setTitle:childVC.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        button.backgroundColor = self.titlesScrollView.backgroundColor;
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesScrollView addSubview:button];
        [self.titlesButtonArray addObject:button];
        if (i == 0) {
            [self titleButtonClick:button];
            [self updateContentViewWithIndex:i];
        }
    }
    self.titlesScrollView.contentSize = CGSizeMake(buttonW*count, 0);
    self.contentsScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*count, 0);
}

#pragma mark title点击事件处理
- (void)titleButtonClick:(UIButton *)button {
    //1.改变颜色
    NSUInteger index = [self.titlesButtonArray indexOfObject:button];
    self.currentTitleButton.transform = CGAffineTransformIdentity;
    [self.currentTitleButton setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
    [button setTitleColor:self.titleSelectedColor forState:UIControlStateNormal];
    button.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [self updateTitleWithIndex:index];
    //2.添加VC
    [self updateContentViewWithIndex:index];
    self.currentTitleButton = button;
}

#pragma mark 更新title显示
- (void)updateTitleWithIndex:(NSUInteger)index  {

    UIButton *button = self.titlesButtonArray[index];
    float offsetX = (button.center.x - SCREEN_WIDTH/2) > 0?(button.center.x - SCREEN_WIDTH/2) : 0;
    float maxOffsetX = self.titlesScrollView.contentSize.width - SCREEN_WIDTH;
    if (offsetX > maxOffsetX) {
        [self.titlesScrollView setContentOffset:CGPointMake(maxOffsetX, 0) animated:YES];
    }else {
        [self.titlesScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    self.currentTitleButton = button;

}

#pragma mark 添加子VC
- (void)updateContentViewWithIndex:(NSUInteger)index {

    UIViewController *childVC = self.childViewControllers[index];
    [self.contentsScrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:NO];
    if (childVC.view.superview) {
        return;
    }
    childVC.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentsScrollView.frame));
    [self.contentsScrollView addSubview:childVC.view];
}

#pragma mark UIScrollView Delegate 方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSInteger leftIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    NSInteger rightIndex = leftIndex + 1;
    UIButton *leftButton = self.titlesButtonArray[leftIndex];
    if (rightIndex >= self.childViewControllers.count) {
        return;
    }
    UIButton *rightButton = self.titlesButtonArray[rightIndex];

    float scale = (scrollView.contentOffset.x - leftIndex*SCREEN_WIDTH)/SCREEN_WIDTH;
    float leftColorR = self.titleSelectedColor.r - scale*(self.titleSelectedColor.r - self.titleNormalColor.r);
    float leftColorG = self.titleSelectedColor.g - scale*(self.titleSelectedColor.g - self.titleNormalColor.g);
    float leftColorB = self.titleSelectedColor.b - scale*(self.titleSelectedColor.b - self.titleNormalColor.b);
    [leftButton setTitleColor:[UIColor colorWithRed:leftColorR green:leftColorG blue:leftColorB alpha:1] forState:UIControlStateNormal];
    float rightColorR = self.titleNormalColor.r + scale*(self.titleSelectedColor.r - self.titleNormalColor.r);
    float rightColorG = self.titleNormalColor.g + scale*(self.titleSelectedColor.g - self.titleNormalColor.g);
    float rightColorB = self.titleNormalColor.b + scale*(self.titleSelectedColor.b - self.titleNormalColor.b);
    [rightButton setTitleColor:[UIColor colorWithRed:rightColorR green:rightColorG blue:rightColorB alpha:1] forState:UIControlStateNormal];
    rightButton.transform = CGAffineTransformMakeScale(1 + scale*0.3, 1 + scale*0.3);
    leftButton.transform = CGAffineTransformMakeScale(1 + (1 - scale)*0.3, 1 + (1 - scale)*0.3);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    NSInteger page = scrollView.contentOffset.x/SCREEN_WIDTH;
    [self updateContentViewWithIndex:page];
    [self updateTitleWithIndex:page];

}

#pragma mark 子类重写 添加子VC
- (NSArray<UIViewController *> *)layoutContentControllers {
    return nil;
}

#pragma mark getter or setter 

- (UIColor *)titleNormalColor {
    if (_titleNormalColor == nil) {
        _titleNormalColor = [UIColor blackColor];
    }
    return _titleNormalColor;
}

- (UIColor *)titleSelectedColor {
    if (_titleSelectedColor == nil) {
        _titleSelectedColor = [UIColor redColor];
    }
    return _titleSelectedColor;
}

- (NSMutableArray *)titlesButtonArray {
    if (_titlesButtonArray == nil) {
        _titlesButtonArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _titlesButtonArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
