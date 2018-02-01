//
//  WCFileManager.h
//  GwcTest
//
//  Created by admin on 01/02/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCFileManager : NSObject

#pragma mark 创建文件夹
+ (BOOL)creatDir:(NSString *)path;
#pragma mark 创建文件
+ (BOOL)creatFile:(NSString*)filePath;
#pragma mark 写数据
+ (BOOL)writeToFile:(NSString*)filePath contents:(NSData *)data;
#pragma mark 追加数据
+ (BOOL)appendData:(NSData*)data withPath:(NSString *)filePath;
#pragma mark 读文件数据
+ (NSData*)readFileData:(NSString *)path;
#pragma mark 获取文件夹下所有的文件列表
+ (NSArray*)getFileList:(NSString*)path;
#pragma mark 获取文件夹下所有文件(深度遍历)
+ (NSArray*)getAllFileList:(NSString*)path;
#pragma mark 移动文件
+ (BOOL)moveFile:(NSString *)fromPath toPath:(NSString *)toPath toPathIsDir:(BOOL)dir;
#pragma mark 删除文件
+ (BOOL)removeFile:(NSString*)filePath;
#pragma mark 删除文件夹
+ (BOOL)removeDir:(NSString*)path;
#pragma mark 删除某些后缀的文件
+ (void)removeFileSuffixList:(NSArray<NSString*>*)suffixList filePath:(NSString*)path deep:(BOOL)deep;
#pragma mark 获取文件大小
+ (long long)getFileSize:(NSString*)path;
#pragma mark 获取文件的信息(包含了上面文件大小)
+ (NSDictionary*)getFileInfo:(NSString*)path;

@end
