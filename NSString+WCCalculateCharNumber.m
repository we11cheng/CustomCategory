//
//  NSString+WCCalculateCharNumber.m
//  WCWeakTime
//
//  Created by admin on 23/04/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import "NSString+WCCalculateCharNumber.h"

@implementation NSString (WCCalculateCharNumber)

- (NSInteger )charNumber {
    NSUInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return strlength;
}

@end
