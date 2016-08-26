//
//  WQKeyChain.h
//  keyChainDemo
//
//  Created by mac on 16/8/12.
//  Copyright © 2016年 TXZhongJiaowang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQKeyChain : NSObject
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
