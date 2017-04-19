//
//  ADScrollView.m
//  ScorllViewEndless
//
//  Created by 思宇 陆 on 15/7/31.
//  Copyright (c) 2015年 思宇 陆. All rights reserved.
//

#import "ADFocusImageView.h"

#define imageWidth      self.frame.size.width
#define imageHeight     self.frame.size.height

@implementation ADFocusImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, imageWidth, imageHeight)];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = BYYellowColor;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    scrollPage = 0;
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, imageHeight - 5, imageWidth, 0)];
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = BYLightGrayColor;
    _pageControl.currentPageIndicatorTintColor = BYWhiteColor;
    [self addSubview:_pageControl];
    
}

- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(timeFire) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes]; //防止阻塞倒计时线程用
}

- (void)timeFire
{
    [_scrollView setContentOffset:CGPointMake(imageWidth * 2, 0) animated:YES];
}

- (void)setImageArry:(NSArray *)imageArry
{
    int page = 0;
    int pageNumber = 0;
    if ([imageArry count] == 1) {
        pageNumber = 1;
    }else if ([imageArry count] > 1){ //图片大于一张时才可滑动
        pageNumber = (int)[imageArry count];
        [self addTimer];
        _scrollView.contentOffset = CGPointMake(imageWidth, 0);
        _scrollView.contentSize = CGSizeMake(imageWidth * pageNumber, 0);
    }
    
    for (int i = 0; i < pageNumber; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(imageWidth * page, 0, imageWidth, imageHeight)];
        image.tag = 11 + i;
        if (i == 0) {
            image.image = imageArry[[imageArry count] - 1];
        }else{
            image.image = imageArry[i - 1];
        }
        image.userInteractionEnabled = YES;
        [_scrollView addSubview:image];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImage)];
        [image addGestureRecognizer:tap];
        
        page ++;
    }
    _pageControl.numberOfPages = [imageArry count];
//    _pageControl.hidesForSinglePage = YES;
    _imageArry = imageArry;
    
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    float RightPage = _scrollView.contentOffset.x;
    if (RightPage == imageWidth * 2) {
        [self moveRight];
    }
    float LeftPage = _scrollView.contentOffset.x - imageWidth;
    if (LeftPage == -imageWidth) {
        [self moveLeft];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}


- (void)moveRight
{
    if (scrollPage < [_imageArry count] - 1) {
        scrollPage ++;
    }else{
        scrollPage = 0;
    }
    UIImageView *imageleft = (UIImageView *)[self viewWithTag:11];
    UIImageView *imageCurrent = (UIImageView *)[self viewWithTag:12];
    UIImageView *imageRight = (UIImageView *)[self viewWithTag:13];
    UIImageView *tmpView = imageleft;
    imageleft = imageCurrent;
    imageCurrent = imageRight;
    imageRight = tmpView;
    
    [self updateImageFrame];

}

- (void)moveLeft
{
    if (scrollPage > 0) {
        scrollPage --;
    }else if(scrollPage == 0){
        scrollPage = (int)[_imageArry count] - 1;
    }
    UIImageView *imageleft = (UIImageView *)[self viewWithTag:11];
    UIImageView *imageCurrent = (UIImageView *)[self viewWithTag:12];
    UIImageView *imageRight = (UIImageView *)[self viewWithTag:13];
    UIImageView *tmpView = imageCurrent;
    imageCurrent = imageleft;
    imageleft = imageRight;
    imageRight = tmpView;
    
    [self updateImageFrame];
}

- (void)updateImageFrame
{
    UIImageView *imageleft = (UIImageView *)[self viewWithTag:11];
    UIImageView *imageCurrent = (UIImageView *)[self viewWithTag:12];
    UIImageView *imageRight = (UIImageView *)[self viewWithTag:13];
    
    [imageCurrent setFrame:CGRectMake(imageWidth, 0, imageWidth, imageHeight)];
    imageCurrent.image = _imageArry[scrollPage];
    [imageRight setFrame:CGRectMake(imageWidth * 2, 0, imageWidth, imageHeight)];
    if (scrollPage < [_imageArry count] - 1) {
        imageRight.image = _imageArry[scrollPage + 1];
    }else{
        imageRight.image = _imageArry[0];
    }
    [imageleft setFrame:CGRectMake(0, 0, imageWidth, imageHeight)];
    if (scrollPage != 0) {
        imageleft.image = _imageArry[scrollPage - 1];
    }else{
        imageleft.image = _imageArry[[_imageArry count] -1];
    }
    _scrollView.contentOffset = CGPointMake(imageWidth, 0);
    _pageControl.currentPage = scrollPage;
}

- (void)touchImage
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickatIndex:)]) {
        [self.delegate clickatIndex:_pageControl.currentPage];
    }
}

-(void)updateImageFocus:(NSArray *)images{
    [_timer invalidate];
    _timer = nil;
    [self removeAllSubView];
    [self initView];
    self.imageArry = images;
}

@end
