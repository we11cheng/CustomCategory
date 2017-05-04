//
//  FYLSegmentView.h
//  FYLPageViewController
//
//  Created by FuYunLei on 2017/4/17.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FYLColorFromHexadecimalRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width     //屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //屏幕高度

#define kMaskWidth 64 //指示视图的宽度

@class FYLSegmentView;

@protocol FYLSegmentViewDelegate <NSObject>

///点击标签回调
- (void)FYLSegmentView:(FYLSegmentView *)segmentView didClickTagAtIndex:(NSInteger)index;

@end

@interface FYLSegmentView : UIView

@property(nonatomic,weak)id<FYLSegmentViewDelegate> delegate;

///初始化方法
- (FYLSegmentView *)initWithTitles:(NSArray *)titles;

///设置指示下标位置方法
- (void)setOffsetOfIndexView:(CGFloat)offsetX withCurrentIndex:(NSInteger)index;

@end
