//
//  UILabel+SizeToFit.m
//  gwctest
//
//  Created by apple on 7/28/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import "UILabel+SizeToFit.h"

@implementation UILabel (SizeToFit)
- (void)fixWidth:(CGFloat)width
        position:(CGPoint)position
   numberOfLines:(NSInteger)lines
   lineBreakMode:(NSLineBreakMode)mode
{
    CGRect newRect     = self.frame;
    newRect.size.width = width;
    newRect.origin     = position;
    self.frame         = newRect;
    
    self.numberOfLines = lines;
    self.lineBreakMode = mode;
    [self sizeToFit];
    /*
     固定宽度250 lable 的起始位置 0代表无限。
     [label fixWidth:250
           position:CGPointMake(50, 100)
      numberOfLines:0
      lineBreakMode:NSLineBreakByTruncatingMiddle];
    */
}
@end
