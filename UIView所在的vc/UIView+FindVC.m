//
//  UIView+FindVC.m
//  gwctest
//
//  Created by apple on 9/14/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import "UIView+FindVC.h"

@implementation UIView (FindVC)

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
