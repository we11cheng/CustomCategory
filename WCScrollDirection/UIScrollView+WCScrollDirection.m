//
//  UIScrollView+WCScrollDirection.m
//  TestGwc
//
//  Created by admin on 26/02/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import "UIScrollView+WCScrollDirection.h"
#import <objc/runtime.h>

@interface UIScrollView ()
@property (assign, nonatomic) UIScrollViewDirection horizontalScrollingDirection;
@property (assign, nonatomic) UIScrollViewDirection verticalScrollingDirection;
@end

static const char horizontalScrollingDirectionKey;
static const char verticalScrollingDirectionKey;

@implementation UIScrollView (WCScrollDirection)

- (void)startObservingDirection {
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)stopObservingDirection {
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![keyPath isEqualToString:@"contentOffset"]) return;
    
    CGPoint newContentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
    CGPoint oldContentOffset = [[change valueForKey:NSKeyValueChangeOldKey] CGPointValue];
    
    if (oldContentOffset.x < newContentOffset.x) {
        self.horizontalScrollingDirection = UIScrollViewDirectionRight;
    } else if (oldContentOffset.x > newContentOffset.x) {
        self.horizontalScrollingDirection = UIScrollViewDirectionLeft;
    } else {
        self.horizontalScrollingDirection = UIScrollViewDirectionNone;
    }
    
    if (oldContentOffset.y < newContentOffset.y) {
        self.verticalScrollingDirection = UIScrollViewDirectionDown;
    } else if (oldContentOffset.y > newContentOffset.y) {
        self.verticalScrollingDirection = UIScrollViewDirectionUp;
    } else {
        self.verticalScrollingDirection = UIScrollViewDirectionNone;
    }
}

#pragma mark - Properties
- (UIScrollViewDirection)horizontalScrollingDirection {
    return [objc_getAssociatedObject(self, (void *)&horizontalScrollingDirectionKey) intValue];
}

- (void)setHorizontalScrollingDirection:(UIScrollViewDirection)horizontalScrollingDirection {
    objc_setAssociatedObject(self, (void *)&horizontalScrollingDirectionKey, [NSNumber numberWithInt:horizontalScrollingDirection], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIScrollViewDirection)verticalScrollingDirection {
    return [objc_getAssociatedObject(self, (void *)&verticalScrollingDirectionKey) intValue];
}

- (void)setVerticalScrollingDirection:(UIScrollViewDirection)verticalScrollingDirection {
    objc_setAssociatedObject(self, (void *)&verticalScrollingDirectionKey, [NSNumber numberWithInt:verticalScrollingDirection], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
