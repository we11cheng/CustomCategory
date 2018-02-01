//
//  WCFileManager.m
//  GwcTest
//
//  Created by admin on 01/02/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import "WCFileManager.h"

@implementation WCFileManager

#pragma mark 创建文件夹
+ (BOOL)creatDir:(NSString *)path {
    if (path.length==0) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isSuccess = YES;
    BOOL isExist = [fileManager fileExistsAtPath:path];
    if (isExist==NO) {
        NSError *error;
        if (![fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
            isSuccess = NO;
            NSLog(@"creat Directory Failed:%@",[error localizedDescription]);
        }
    }
    return isSuccess;
}

#pragma mark 创建文件
+ (BOOL)creatFile:(NSString*)filePath {
    if (filePath.length==0) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    NSError *error;
    NSString *dirPath = [filePath stringByDeletingLastPathComponent];
    BOOL isSuccess = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"creat File Failed:%@",[error localizedDescription]);
    }
    if (!isSuccess) {
        return isSuccess;
    }
    isSuccess = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    return isSuccess;
}

#pragma mark 写数据
+ (BOOL)writeToFile:(NSString*)filePath contents:(NSData *)data {
    if (filePath.length==0) {
        return NO;
    }
    BOOL result = [self creatFile:filePath];
    if (result) {
        if ([data writeToFile:filePath atomically:YES]) {
            NSLog(@"write Success");
        }else{
            NSLog(@"write Failed");
        }
    }
    else{
        NSLog(@"write Failed");
    }
    return result;
}

#pragma mark 追加数据
+ (BOOL)appendData:(NSData*)data withPath:(NSString *)filePath {
    if (filePath.length==0) {
        return NO;
    }
    BOOL result = [self creatFile:filePath];
    if (result) {
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [handle seekToEndOfFile];
        [handle writeData:data];
        [handle synchronizeFile];
        [handle closeFile];
    }
    else{
        NSLog(@"appendData Failed");
    }
    return result;
}

#pragma mark 读文件数据
+ (NSData*)readFileData:(NSString *)path {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *fileData = [handle readDataToEndOfFile];
    [handle closeFile];
    return fileData;
}

#pragma mark 获取文件夹下所有的文件列表
+ (NSArray*)getFileList:(NSString*)path {
    if (path.length==0) {
        return nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:path error:&error];
    if (error) {
        NSLog(@"getFileList Failed:%@",[error localizedDescription]);
    }
    return fileList;
}

#pragma mark 获取文件夹下所有文件(深度遍历)
+ (NSArray*)getAllFileList:(NSString*)path {
    if (path.length==0) {
        return nil;
    }
    NSArray *fileArray = [self getFileList:path];
    NSMutableArray *fileArrayNew = [NSMutableArray array];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString *aPath in fileArray) {
        NSString * fullPath = [path stringByAppendingPathComponent:aPath];
        BOOL isDir = NO;
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&isDir]) {
            if (isDir) {
                [fileArrayNew addObjectsFromArray:[self getAllFileList:fullPath]];
            }else{
                [fileArrayNew addObject:fullPath];
            }
        }
    }
    return fileArrayNew;
}

#pragma mark 移动文件
+ (BOOL)moveFile:(NSString *)fromPath toPath:(NSString *)toPath toPathIsDir:(BOOL)dir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:fromPath]) {
        NSLog(@"Error: fromPath Not Exist");
        return NO;
    }
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:toPath isDirectory:&isDir];
    if (isExist) {
        if (isDir) {
            if ([self creatDir:toPath]) {
                NSString *fileName = fromPath.lastPathComponent;
                toPath = [toPath stringByAppendingPathComponent:fileName];
                return [self moveItemAtPath:fromPath toPath:toPath];
            }
        }else{
            [self removeFile:toPath];
            return [self moveItemAtPath:fromPath toPath:toPath];
        }
    }
    else{
        if (dir) {
            if ([self creatDir:toPath]) {
                NSString *fileName = fromPath.lastPathComponent;
                toPath = [toPath stringByAppendingPathComponent:fileName];
                return [self moveItemAtPath:fromPath toPath:toPath];
            }
        }else{
            return [self moveItemAtPath:fromPath toPath:toPath];
        }
    }
    return NO;
}
+ (BOOL)moveItemAtPath:(NSString*)fromPath toPath:(NSString*)toPath {
    BOOL result = NO;
    NSError * error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    result = [fileManager moveItemAtPath:fromPath toPath:toPath error:&error];
    if (error){
        NSLog(@"moveFile Fileid：%@",[error localizedDescription]);
    }
    return result;
}

#pragma mark 删除文件
+ (BOOL)removeFile:(NSString*)filePath {
    BOOL isSuccess = NO;
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    isSuccess = [fileManager removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@"removeFile Field：%@",[error localizedDescription]);
    }else{
        NSLog(@"removeFile Success");
    }
    return isSuccess;
}

#pragma mark 删除文件夹
+ (BOOL)removeDir:(NSString*)path {
    return [self removeFile:path];
}

#pragma mark 删除某些后缀的文件
+ (void)removeFileSuffixList:(NSArray<NSString*>*)suffixList filePath:(NSString*)path deep:(BOOL)deep {
    NSArray *fileArray = nil;
    if (deep) {  // 是否深度遍历
        fileArray = [self getAllFileList:path];
    }else{
        fileArray = [self getFileList:path];
        NSMutableArray *fileArrayTmp = [NSMutableArray array];
        for (NSString *fileName in fileArray) {
            NSString* allPath = [path stringByAppendingPathComponent:fileName];
            [fileArrayTmp addObject:allPath];
        }
        fileArray = fileArrayTmp;
    }
    for (NSString *aPath in fileArray) {
        for (NSString* suffix in suffixList) {
            if ([aPath hasSuffix:suffix]) {
                [self removeFile:aPath];
            }
        }
    }
}

#pragma mark 获取文件大小
+ (long long)getFileSize:(NSString*)path {
    unsigned long long fileLength = 0;
    NSNumber *fileSize;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    if ((fileSize = [fileAttributes objectForKey:NSFileSize])) {
        fileLength = [fileSize unsignedLongLongValue]; //单位是 B
    }
    return fileLength;
}

#pragma mark 获取文件的信息(包含了上面文件大小)
+ (NSDictionary*)getFileInfo:(NSString*)path {
    NSError *error;
    NSDictionary *reslut =  [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
    if (error) {
        NSLog(@"getFileInfo Failed:%@",[error localizedDescription]);
    }
    return reslut;
}




@end
