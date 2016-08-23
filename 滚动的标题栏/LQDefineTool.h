//
//  LQDefineTool.h
//  我的工具
//
//  Created by lizq on 16/6/17.
//  Copyright © 2016年 zqLee. All rights reserved.


//屏幕尺寸
#define SCREEN_WIDTH               MIN(CGRectGetWidth([[UIScreen mainScreen] bounds]),CGRectGetHeight([[UIScreen mainScreen] bounds]))
#define SCREEN_HEIGHT              MAX(CGRectGetWidth([[UIScreen mainScreen] bounds]),CGRectGetHeight([[UIScreen mainScreen] bounds]))

//是否是Retina屏幕
#define isRetina                   ([UIScreen mainScreen].scale > 1)

//手机屏幕判断
#define isIphone4sScreen           (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 480)))
#define isIphone5Screen            (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568)))
#define isIphone6Screen            (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667)))
#define isIphone6PScreen           (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736)))

//设备种类判断
#define isSimulator                (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)
#define isIphone                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define isIpad                     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//系统版本判断
#define isIOS7                     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define isIOS8                     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//当前软件版本号
#define BundleShortVersionString   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//设置rgb 颜色
#define COLOR_WITH_ARGB(R,G,B,A)   [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]
#define COLOR_WITH_RGB(R,G,B)      [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1]

//自定义NSLog
#ifdef  DEBUG
#define LQLog(...)                  NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LQLog(...)
#endif

//弱引用/强引用
#define LQWeakSelf(type)            __block __weak typeof(type) weak##type = type;
#define LQStrongSelf(type)          __strong typeof(type) type = weak##type;

//由角度转换弧度 由弧度转换角度
#define LQDegreesToRadian(x)        (M_PI * (x) / 180.0)
#define LQRadianToDegrees(radian)   (radian*180.0)/(M_PI)

//自定义颜色
#define LQRGBColor(r, g, b)         [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LQRGBAColor(r, g, b, a)     [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

//clear背景颜色
#define LQClearColor                [UIColor clearColor]

//随机颜色
#define LQRandomColor               [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//通知中心
#define LQNotificationCenter        [NSNotificationCenter defaultCenter]

/** 快速查询一段代码的执行时间 */
/** 用法
 TICK
 do your work here
 TOCK
 */
#define TICK NSDate *startTime = [NSDate date];
#define TOCK NSLog(@"Time:%f", -[startTime timeIntervalSinceNow]);
