//
//  UILabel+SizeToFit.h
//  gwctest
//
//  Created by apple on 7/28/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SizeToFit)
- (void)fixWidth:(CGFloat)width
        position:(CGPoint)position
   numberOfLines:(NSInteger)lines
   lineBreakMode:(NSLineBreakMode)mode;
@end
