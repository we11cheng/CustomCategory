//
//  RondomNumHelper.h
//  RandomNum_Demo
//
//  Created by admin on 2016/11/1.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RondomNumHelper : NSObject
// 生成m~n之间的随机整数  rand()
-(int)randFrom:(int)m to:(int)n;
// 生成m~n之间的随机整数  random()
-(int)randomFrom:(int)m to:(int)n;
// 生成0~1之间的随机浮点数 drand48()
-(double)drand0To1;
// 生成m~n之间的随机整数 arc4random()
-(int)arc4randomFrom:(int)m to:(int)n;

//rac4random_uniform(int upper_bound)
// 生成0~N之间的随机整数
-(NSInteger)randomN:(int)n;
// 生成1~N之间的随机整数
-(NSInteger)random1ToN:(int)n;

#pragma mark -   实例应用
// 获取数组中随机的一个元素
-(id)randomArrayObject:(NSArray *)array;
// 获取1~100之间的不重复的长度是10的随机整数数组
-(NSArray *)getRandomArray;
// 随机排序数组
-(NSArray *)randomSortArray:(NSArray *)array;

@end
