//
//  GetSystemInfoHelper.m
//  GetSystemInfo_Demo
//
//  Created by admin on 2016/12/1.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "GetSystemInfoHelper.h"


#pragma mark  -  WiFi相关
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN        @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"


#import <SystemConfiguration/CaptiveNetwork.h>
#include <ifaddrs.h>
#include<arpa/inet.h>
#include<net/if.h>


@implementation GetSystemInfoHelper

//1.获取电池电量(一般用百分数表示,大家自行处理就好)
+(CGFloat)getBatteryQuantity
{
    return [[UIDevice currentDevice] batteryLevel];
}
//2.获取电池状态(UIDeviceBatteryState为枚举类型)
+(UIDeviceBatteryState)getBatteryStauts
{
    return [UIDevice currentDevice].batteryState;
}

//3.获取总内存大小
+(long long)getTotalMemorySize
{
    return [NSProcessInfo processInfo].physicalMemory;
}

//4.获取当前可用内存
//-(long long)getAvailableMemorySize
//{
//    vm_statistics_data_t vmStats;
//    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
//    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
//    if (kernReturn != KERN_SUCCESS)
//    {
//        return NSNotFound;
//    }
//    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
//}

//5.获取已使用内存
//- (double)getUsedMemory
//{
//    task_basic_info_data_t taskInfo;
//    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
//    kern_return_t kernReturn = task_info(mach_task_self(),
//                                         TASK_BASIC_INFO,
//                                         (task_info_t)&taskInfo,
//                                         &infoCount);
//    
//    if (kernReturn != KERN_SUCCESS
//        ) {
//        return NSNotFound;
//    }
//    
//    return taskInfo.resident_size;
//}

//6.获取总磁盘容量
//include <sys mount.h="">
//-(long long)getTotalDiskSize
//{
//    struct statfs buf;
//    unsigned long long freeSpace = -1;
//    if (statfs("/var", &buf) >= 0)
//    {
//        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
//    }
//    return freeSpace;
//}</sys>



//7.获取可用磁盘容量
//-(long long)getAvailableDiskSize
//{
//    struct statfs buf;
//    unsigned long long freeSpace = -1;
//    if (statfs("/var", &buf) >= 0)
//    {
//        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
//    }
//    return freeSpace;
//}


//8.容量转换
+(NSString *)fileSizeToString:(unsigned long long)fileSize
{
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    
    if (fileSize < 10)  {
        return @"0 B";
    }else if (fileSize < KB)    {
        return @"< 1 KB";
    }else if (fileSize < MB)    {
        return [NSString stringWithFormat:@"%.1f KB",((CGFloat)fileSize)/KB];
    }else if (fileSize < GB)    {
        return [NSString stringWithFormat:@"%.1f MB",((CGFloat)fileSize)/MB];
    }else   {
        return [NSString stringWithFormat:@"%.1f GB",((CGFloat)fileSize)/GB];
    }
}


//9.IP地址
+ (NSString *)deviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}


//10.当前手机连接的WIFI名称(SSID)
+ (NSString *)getWifiName
{
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}


#pragma mark - WiFi
//获取当前连接Wi-Fi名称与MAC地址
+(id)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break;
        }
    }
    return info;
}

//获取当前连接Wi-Fi的IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,       IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        address = addresses[key];
        if(address) *stop = YES;
    } ];
    return address ? address : @"0.0.0.0";
    
}
+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
@end
