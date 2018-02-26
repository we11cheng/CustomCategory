//
//  UIScrollView+WCScrollDirection.h
//  TestGwc
//
//  Created by admin on 26/02/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum UIScrollViewDirection {
    UIScrollViewDirectionNone,
    UIScrollViewDirectionRight,
    UIScrollViewDirectionLeft,
    UIScrollViewDirectionUp,
    UIScrollViewDirectionDown,
} UIScrollViewDirection;


@interface UIScrollView (WCScrollDirection)

- (void)startObservingDirection;
- (void)stopObservingDirection;

@property (readonly, nonatomic) UIScrollViewDirection horizontalScrollingDirection;
@property (readonly, nonatomic) UIScrollViewDirection verticalScrollingDirection;

@end
