//
//  UIColor+hex.m
//  NoCardPay
//
//  Created by lizq on 16/5/13.
//  Copyright © 2016年 tangyj. All rights reserved.
//

#import "UIColor+hex.h"

@implementation UIColor (hex)

- (float)r {
    NSString *RGBValue = [NSString stringWithFormat:@"%@",self];
    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    if (RGBArr.count == 3) {
        return 0.0;
    }
    float colorR = ((NSString *)RGBArr[1]).floatValue;
    return colorR;
}

- (float)g {
    NSString *RGBValue = [NSString stringWithFormat:@"%@",self];
    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    if (RGBArr.count == 3) {
        return 0.0;
    }
    float colorG = ((NSString *)RGBArr[2]).floatValue;
    return colorG;
}

- (float)b {
    NSString *RGBValue = [NSString stringWithFormat:@"%@",self];
    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    if (RGBArr.count == 3) {
        return 0.0;
    }
    float colorB = ((NSString *)RGBArr[3]).floatValue;
    return colorB;
}

- (float)apha {
    NSString *RGBValue = [NSString stringWithFormat:@"%@",self];
    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    if (RGBArr.count == 3) {
        float colorA = ((NSString *)RGBArr[1]).floatValue;
        return colorA;
    }
    float colorA = ((NSString *)RGBArr[4]).floatValue;
    return colorA;
}


+ (UIColor *)colorWithHexString:(NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
