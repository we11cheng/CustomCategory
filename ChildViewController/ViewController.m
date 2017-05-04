//
//  ViewController.m
//  ChildViewController
//
//  Created by mac on 16/9/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "ScrollView.h"
#import "OneViewController.h"
#import "ThreeViewController.h"
#import "TwoViewController.h"
#import "FourViewController.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<seletedControllerDelegate,UIScrollViewDelegate>{
    ScrollView *titleScroll;
    UIScrollView *mainScroll;
    OneViewController *oneVC;
    TwoViewController *twoVC;
    ThreeViewController *threeVC;
    FourViewController *fourVC;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建头部视图(滑动视图)
    titleScroll= [[ScrollView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 40)];
    NSArray *mu = @[@"推荐",@"热卖",@"首页",@"发现"];
    
    titleScroll.headArray = mu.mutableCopy;
    
    //设置代理
    titleScroll.SeletedDelegate = self;
    //添加
    [self.view addSubview:titleScroll];
    
    //创建一个滑动视图用来滑动Viewcontroller
    mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight-60)];
    //设置代理
    mainScroll.delegate = self;
    //设置滑动区域
    mainScroll.contentSize = CGSizeMake(ScreenWidth*mu.count, 0) ;
    //打开分页功能
    mainScroll.pagingEnabled = YES;
    //设置背景颜色
    mainScroll.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:mainScroll];
    //设置当前子控制器
    oneVC = [[OneViewController alloc] init];
    [self addChildViewController:oneVC];
    oneVC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    //将当前的子视图控制器的view添加到主滑动视图上
    [mainScroll addSubview:oneVC.view];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (mainScroll.contentOffset.x < ScreenWidth) {
        twoVC = [[TwoViewController alloc] init];
        [self addChildViewController:twoVC];
        twoVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
        [mainScroll addSubview:twoVC.view];
    }else if (mainScroll.contentOffset.x < ScreenWidth*2){
        threeVC = [[ThreeViewController alloc] init];
        [self addChildViewController:threeVC];
        threeVC.view.frame = CGRectMake(ScreenWidth*2, 0, ScreenWidth, ScreenHeight);
        [mainScroll addSubview:threeVC.view];
    }else if (mainScroll.contentOffset.x < ScreenWidth *3){
        fourVC = [[FourViewController alloc]init];
        [self addChildViewController:fourVC];
        fourVC.view.frame = CGRectMake(ScreenWidth*3, 0, ScreenWidth, ScreenHeight);
        [mainScroll addSubview:fourVC.view];
    }

    
    [titleScroll changeBtntitleColorWith:scrollView.contentOffset.x/ScreenWidth+1000];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [titleScroll changeBtntitleColorWith:scrollView.contentOffset.x/ScreenWidth+1000];
    
}

#pragma mark -头部scrollView的代理方法的实现
-(void)seletedControllerWith:(UIButton *)btn{
    
    mainScroll.contentOffset = CGPointMake(ScreenWidth*(btn.tag - 1000), 0);
    
        if (mainScroll.contentOffset.x == ScreenWidth) {
            twoVC = [[TwoViewController alloc] init];
            [self addChildViewController:twoVC];
            twoVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
            [mainScroll addSubview:twoVC.view];
        }else if (mainScroll.contentOffset.x == ScreenWidth*2){
            threeVC = [[ThreeViewController alloc] init];
            [self addChildViewController:threeVC];
            threeVC.view.frame = CGRectMake(ScreenWidth*2, 0, ScreenWidth, ScreenHeight);
            [mainScroll addSubview:threeVC.view];
        }else if (mainScroll.contentOffset.x == ScreenWidth *3){
            fourVC = [[FourViewController alloc]init];
            [self addChildViewController:fourVC];
            fourVC.view.frame = CGRectMake(ScreenWidth*3, 0, ScreenWidth, ScreenHeight);
            [mainScroll addSubview:fourVC.view];
        }
    [titleScroll changeBtntitleColorWith:mainScroll.contentOffset.x/ScreenWidth+1000];
    
    
}





















@end
