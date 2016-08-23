//
//  Gesture.h
//  DWGesture
//
//  Created by dwang_sui on 16/7/14.
//  Copyright © 2016年 dwang_sui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, DWSwipeGestureType) {
   /** 敲击手势 */
    DWTapGesture = 1 << 0,
    
    /** 左滑手势 */
    DWLeftSwipeGestures  = 1 << 1,
    
    /** 右滑手势 */
    DWRightSwipeGestures    = 1 << 2,
    
    /** 上拉手势 */
    DWUpSwipeGestures  = 1 << 3,
    
    /** 下拉手势 */
    DWDownSwipeGestures = 1 << 4
};

@interface DWSwipeGestures : NSObject

/**
 *  需要操作的次数/只有在敲击手势时才有效,其它时候则无效/默认为1
 */
@property (assign, nonatomic) NSInteger numberOfTapsRequired;

/**
 *  需要操作的手指数量/默认为1
 */
@property (assign, nonatomic) NSInteger numberOfTouchesRequired;

/*!
 *  @author dwang_sui, 16-07-20 21:07:31
 *
 *  @brief 当前手势类型
 *
 *  @since <#version number#>
 */
@property (assign, nonatomic) DWSwipeGestureType swipeGestureType;

/*!
 *  @author dwang_sui, 16-07-14 22:07:59
 *
 *  @brief 添加手势
 *
 *  @param swipeGesture                手势类型
 *  @param target                      方法执行者
 *  @param action                      方法名
 *  @param view                        手势添加视图
 *  @param backSwipeGestureTypeString  返回出设置的手势类型
 *
 *  @since <#version number#>
 */
- (void)dw_SwipeGestureType:(DWSwipeGestureType)swipeGestureType Target:(nullable id)target Action:(nullable SEL)action AddView:(UIView * _Nonnull)view BackSwipeGestureTypeString:(void(^ _Nonnull )(NSString *_Nonnull backSwipeGestureTypeString))backSwipeGestureTypeString;


/**
 *  删除手势
 *
 *  @param swipeGestureType 需要删除的手势类型
 */
- (void)dw_RemoveSwipeGesture:(DWSwipeGestureType)swipeGestureType;


@end
