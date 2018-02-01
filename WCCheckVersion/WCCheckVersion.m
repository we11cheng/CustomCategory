//
//  WCCheckVersion.m
//  GwcTest
//
//  Created by admin on 01/02/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import "WCCheckVersion.h"

static NSString *const WCXcodeVersionNumber = @"CFBundleShortVersionString";
static NSString *const WCNSUserDefaultKey = @"localVersion";

@implementation WCCheckVersion

//适用的格式是：1.2.2>1.2.1、1.2 > 1.1.9 、1.2 = 1.2.0

//检查首次安装/升级
+ (void)checkVersionFirstInstall:(void(^)())firstInstall
                   updateInstall:(void(^)())updateInstall
                           other:(void(^)())other {
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:WCXcodeVersionNumber];
    NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
    NSString *localVersion = [persistentDefaults objectForKey:WCNSUserDefaultKey];
    
    if(!localVersion){
        //首次安装打开
        NSLog(@"首次安装打开");
        if(firstInstall){
            firstInstall();
        }
        [self setLocalAppVersion]; //按需求看是否在这里就更新本地版本号
    } else if([self compareVersion:appVersion toVersion:localVersion] == 1){
        //升级打开
        NSLog(@"升级打开");
        if(updateInstall){
            updateInstall();
        }
        //[self setLocalAppVersion];
    } else {
        //普通打开
        NSLog(@"普通打开");
        if(other){
            other();
        }
    }
}

#pragma mark 私有方法
+ (NSInteger)compareVersion:(NSString *)version1 toVersion:(NSString *)version2 {
    NSArray *list1 = [version1 componentsSeparatedByString:@"."];
    NSArray *list2 = [version2 componentsSeparatedByString:@"."];
    for (int i = 0; i < list1.count || i < list2.count; i++) {
        NSInteger a = 0, b = 0;
        if (i < list1.count) {
            a = [list1[i] integerValue];
        }
        if (i < list2.count) {
            b = [list2[i] integerValue];
        }
        if (a > b) {
            return 1;//version1大于version2
        } else if (a < b) {
            return -1;//version1小于version2
        }
    }
    return 0;//version1等于version2
}

//将版本号存到本地
+ (void)setLocalAppVersion {
    NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:WCXcodeVersionNumber];
    NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
    [persistentDefaults setObject: localVersion forKey:WCNSUserDefaultKey];
    [persistentDefaults synchronize];
}

@end
