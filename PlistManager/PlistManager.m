//
//  PlistManager.m
//  LiveScore
//
//  Created by Lidear on 16/8/24.
//  Copyright © 2016年 By. All rights reserved.
//

#import "PlistManager.h"

@implementation PlistManager

- (NSString *)docPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths.firstObject;
}

- (BOOL)isDirNeedCreate:(NSString *)dirPath {
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        return  [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return NO;
}

- (BOOL)isFileNeedCreate:(NSString *)filePath {
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [[NSFileManager defaultManager]createFileAtPath:filePath contents:nil attributes:nil];
    }
    return NO;
}


//保存为缓存
- (void)addDict:(NSDictionary *)dic type:(NSString *)type{
    NSString *docPath = [self docPath];
//    NSLog(@"当前document路径---%@",docPath);
    NSString *dataFile = [docPath stringByAppendingPathComponent:@"docData.plist"];
    if (YES == [self isFileNeedCreate:dataFile]) {
//        NSLog(@"文件不存在 新建成功");
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:dic forKey:type];
        [dict writeToFile:dataFile atomically:YES];
    }else {
//        NSLog(@"文件已存在 无需新建");
        NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:dataFile] mutableCopy];
        [dict setObject:dic forKey:type];
        [dict writeToFile:dataFile atomically:YES];
    }
    
}

//读取缓存信息
- (id)readDic:(NSString *)key {
    NSString *dataFile=[[self docPath] stringByAppendingPathComponent:@"docData.plist"];
//    NSLog(@"%@",dataFile);
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:dataFile];
    if ([dic.allKeys containsObject:key]) {
        return [dic objectForKey:key];
    }
    return nil;
}

//删除缓存信息
- (void)deleteDic:(NSString *)key shopNo:(NSString *)shopNo{
    NSString *dataFile=[[self docPath] stringByAppendingPathComponent:@"docData.plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:dataFile];
    NSMutableDictionary *shopDic = [dic objectForKey:shopNo];
    if ([shopDic.allKeys containsObject:key]) {
        NSLog(@"删除成功");
        [shopDic removeObjectForKey:key];
        [dic writeToFile:dataFile atomically:YES];
    }
}

//删除所有
- (void)deleteAll {
    NSString *dataFile=[[self docPath] stringByAppendingPathComponent:@"docData.plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:dataFile];
    [dic removeAllObjects];
}


@end
