//
//  NSObject+CleanCache.h
//  gwctest
//
//  Created by apple on 9/18/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CleanCache)
/**
 *  删除沙盒文件指定路径的缓存
 *
 *  @param path       路径
 *  @param completion 回调 文件夹大小
 */
- (void)getFileCacheSizeWithPath:(NSString *)path completion:(void (^)(NSInteger total))completion;

/**
 *  删除沙盒文件cache缓存
 *
 *  @param completion completion description
 */
+ (void)removeCacheWithCompletion:(void (^)())completion;

@end
