//
//  NSString+Extension.m
//  DouBeDemo
//
//  Created by gaolili on 16/5/4.
//  Copyright © 2016年 mRocker. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(CGFloat)heightWithWidth:(CGFloat)width font:(CGFloat)font{
    UIFont * fonts = [UIFont systemFontOfSize:font];
    CGSize size  = CGSizeMake(width, 100000.0);
    NSDictionary * dict  = [NSDictionary dictionaryWithObjectsAndKeys:fonts,NSFontAttributeName ,nil];
    size = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size.height;
}
@end
