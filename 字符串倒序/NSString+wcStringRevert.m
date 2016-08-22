//
//  NSString+wcStringRevert.m
//  gwctest
//
//  Created by apple on 8/19/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import "NSString+wcStringRevert.h"

@implementation NSString (wcStringRevert)

- (NSString *)wcStringRevert {
    NSMutableString *result = [NSMutableString stringWithCapacity:self.length];
    for (int i = self.length-1; i>=0; i--) {
        [result appendString:[NSString stringWithFormat:@"%c",[self characterAtIndex:i]]];
    }
    return result;
}

@end
