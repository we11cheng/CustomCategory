//
//  RondomNumHelper.m
//  RandomNum_Demo
//
//  Created by admin on 2016/11/1.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RondomNumHelper.h"

@implementation RondomNumHelper
// 生成m~n之间的随机整数   rand()
-(int)randFrom:(int)m to:(int)n{
    static BOOL isSranded = NO;
    if (!isSranded) {
        isSranded = YES;
        srand((int)time(0));
    }
    return m + rand()%(n - m + 1);
}

// 生成m~n之间的随机整数  random()
-(int)randomFrom:(int)m to:(int)n{
    static BOOL isSranded = NO;
    if (!isSranded) {
        isSranded = YES;
        srandom((int)time(0));
    }
    return m + random()%(n - m + 1);
}

// 生成0~1之间的随机浮点数 drand48()
-(double)drand0To1{
    static BOOL isSranded = NO;
    if (!isSranded) {
        isSranded = YES;
        srand48(time(0));
    }
    return drand48();
}
// 生成m~n之间的随机整数 arc4random()
-(int)arc4randomFrom:(int)m to:(int)n{
    return m + arc4random()%(n - m + 1);
}


//rac4random_uniform(int upper_bound)
// 生成0~N之间的随机整数
-(NSInteger)randomN:(int)n{
    return arc4random_uniform(n+1);
}
// 生成1~N之间的随机整数
-(NSInteger)random1ToN:(int)n{
    return arc4random_uniform(n) + 1;
}
#pragma mark -   实例应用
// 获取数组中随机的一个元素
-(id)randomArrayObject:(NSArray *)array{
    if ([array isKindOfClass:[NSArray class]] && [array count] > 0) {
        return array[arc4random_uniform((int)array.count)];
    }
    return nil;
}

// 获取1~100之间的不重复的长度是10的随机整数数组
-(NSArray *)getRandomArray
{
    NSMutableArray *seedsArray=[NSMutableArray array];
    for (int i = 0 ; i < 100; i++) {
        [seedsArray addObject:@(i+1)];
    }
    NSMutableArray *resultArray=[NSMutableArray array];
    
    NSInteger n = 10;
    for (int i = 0; i < n; i++) {
        int m = arc4random_uniform((int)seedsArray.count);
        [resultArray addObject:seedsArray[m]];
        [seedsArray removeObjectAtIndex:m];
    }
    return resultArray;
}

// 随机排序数组
-(NSArray *)randomSortArray:(NSArray *)array{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
    NSUInteger count = [mutableArray count];
    if (count > 1) {
        for (NSUInteger i = count - 1; i > 0; --i) {
            [mutableArray exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((int32_t)(i + 1))];
        }
    }
    return [NSArray arrayWithArray:mutableArray];
}

@end
