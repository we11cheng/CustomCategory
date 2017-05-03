//
//  GetSystemInfoHelper.h
//  GetSystemInfo_Demo
//
//  Created by admin on 2016/12/1.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GetSystemInfoHelper : NSObject
//1.获取电池电量(一般用百分数表示,大家自行处理就好)
+(CGFloat)getBatteryQuantity;
//2.获取电池状态(UIDeviceBatteryState为枚举类型)
+(UIDeviceBatteryState)getBatteryStauts;
//3.获取总内存大小
+(long long)getTotalMemorySize;
//8.容量转换
+(NSString *)fileSizeToString:(unsigned long long)fileSize;
//9.IP地址
+ (NSString *)deviceIPAdress;
//10.当前手机连接的WIFI名称(SSID)
+ (NSString *)getWifiName;




#pragma mark  - WiFi相关
//获取当前连接Wi-Fi名称与MAC地址
+(id)fetchSSIDInfo;
//获取当前连接Wi-Fi的IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4;


@end
