//
//  PlistManager.h
//  LiveScore
//
//  Created by Lidear on 16/8/24.
//  Copyright © 2016年 By. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistManager : NSObject

- (NSString *)docPath;

-(BOOL)isDirNeedCreate:(NSString *)dirPath;

-(BOOL)isFileNeedCreate:(NSString *)filePath;

- (void)addDict:(NSDictionary *)dic type:(NSString *)type;

- (id)readDic:(NSString *)key;

- (void)deleteDic:(NSString *)key shopNo:(NSString *)shopNo;

- (void)deleteAll;

@end
