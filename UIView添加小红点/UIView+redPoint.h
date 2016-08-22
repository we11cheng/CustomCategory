//
//  UIView+redPoint.h
//  gwctest
//
//  Created by apple on 8/8/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (redPoint)
// UIView添加小红点
- (void)showRedAtOffSetX:(float)offsetX AndOffSetY:(float)offsetY OrValue:(NSString *)value;
- (void)hideRedPoint;

@end
