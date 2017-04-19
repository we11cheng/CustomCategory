//
//  ADScrollView.h
//  ScorllViewEndless
//
//  Created by 思宇 陆 on 15/7/31.
//  Copyright (c) 2015年 思宇 陆. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADFoucsDelegate <NSObject>

@optional

- (void)clickatIndex:(NSInteger)itemIndex;

@end

@interface ADFocusImageView : UIView<UIScrollViewDelegate>{
    int scrollPage;
    UIScrollView *_scrollView;
    NSTimer *_timer;
}

@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSArray *imageArry;
@property (nonatomic,assign) id <ADFoucsDelegate> delegate;
-(void)updateImageFocus:(NSArray *)images;
@end
