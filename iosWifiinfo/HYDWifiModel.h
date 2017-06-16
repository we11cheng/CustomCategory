//
//  HYDWifiModel.h
//  IOS_WIFI
//
//  Created by mac on 17/2/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <arpa/inet.h>
#import <netinet/in.h>
#import <ifaddrs.h>
#include <net/if.h>
#include <sys/socket.h>

@interface HYDWifiModel : NSObject

//获取WiFi 信息，返回的字典中包含了WiFi的名称、路由器的Mac地址、还有一个Data(转换成字符串打印出来是wifi名称)
+(NSDictionary *)fetchSSIDInfo;

//网速测试
+(NSMutableDictionary *)getDataCounters;

@end
