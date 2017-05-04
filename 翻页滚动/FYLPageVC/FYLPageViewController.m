//
//  ViewController.m
//  FYLPageViewController
//
//  Created by FuYunLei on 2017/4/17.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "FYLPageViewController.h"


@interface FYLPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate,FYLSegmentViewDelegate>
{
    BOOL _done; //是否翻页完成
    NSInteger _currentPage;//当前控制器对应下标
}
@property(nonatomic,strong) UIPageViewController *pageVC;

@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) NSArray *viewControllers;

@property (nonatomic,strong)FYLSegmentView *viewSegment;

@end

@implementation FYLPageViewController

- (instancetype)initWithTitles:(NSArray *)titles viewControllers:(NSArray *)viewControllers
{
    self = [super init];
    if (self) {
        self.titles = titles;
        self.viewControllers = viewControllers;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"PageViewController使用";
    //!!!!不能省略
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.viewSegment];
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    
}

#pragma mark - FYLSegmentViewDelegate
- (void)FYLSegmentView:(FYLSegmentView *)segmentView didClickTagAtIndex:(NSInteger)index{
    
    if (index == _currentPage) {
        return;
    }
    
    __weak typeof(FYLPageViewController *)weakSelf = self;
    // 'forward'.0 is right-to-left,
    [self.pageVC setViewControllers:@[self.viewControllers[index]] direction:index<_currentPage animated:YES completion:^(BOOL finished) {
        _currentPage = index;
        
         [weakSelf.viewSegment setOffsetOfIndexView:0 withCurrentIndex:index];

    }];
    
}


#pragma mark - UIPageViewControllerDataSource
// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [self.viewControllers count]) {
        return nil;
    }
    
    return self.viewControllers[index];
}
// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:viewController];
    
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    
    return self.viewControllers[index];
}

#pragma mark - UIPageViewControllerDelegate

// 开始翻页调用
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0) {
    NSLog(@"开始翻页");
}
// 翻页完成调用
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    _done = YES;
    
    NSInteger index = [self.viewControllers indexOfObject:pageViewController.viewControllers[0]];
    _currentPage = index;
    [_viewSegment setOffsetOfIndexView:0 withCurrentIndex:index];
    
    NSLog(@"翻页完成");
}
- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
    return UIInterfaceOrientationPortrait;
}


#pragma mark - Tool
// 根据数组元素，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewControlller {
    return [self.viewControllers indexOfObject:viewControlller];
}
#pragma mark - SCrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    LOG(@"滚动 = %f", scrollView.contentOffset.x-SCREEN_WIDTH);
    CGFloat offsetX = scrollView.contentOffset.x-SCREEN_WIDTH;
    
    if (!_done) {

        [_viewSegment setOffsetOfIndexView:offsetX withCurrentIndex:_currentPage];
        
    }else
    {
        _done = NO;
    }
}
#pragma mark - lazy load
//头部标签视图
- (FYLSegmentView *)viewSegment{
    
    if (!_viewSegment) {
        _viewSegment = [[FYLSegmentView alloc] initWithTitles:self.titles];
        _viewSegment.delegate = self;
    }
    return _viewSegment;
 
}
- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        
        _pageVC.dataSource = self;
        _pageVC.delegate = self;
        
        _pageVC.view.frame = CGRectMake(0, 64+44, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44);
        
        for (UIView *subview in _pageVC.view.subviews) {
            
            [(UIScrollView *)subview setDelegate:self];
            //设置是否支持手势滑动
            //            [(UIScrollView *)subview setScrollEnabled:NO];
            
        }
        [_pageVC setViewControllers:@[self.viewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    return _pageVC;
}

@end
