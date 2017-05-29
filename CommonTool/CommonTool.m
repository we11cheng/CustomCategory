//
//  CommonTool.m
//  AopHook
//
//  Created by mopellet on 17/4/19.
//  Copyright © 2017年 eegsmart. All rights reserved.
//

#import "CommonTool.h"
#import <objc/runtime.h>

@implementation CommonTool

/**
 *  获取某个view所在的控制器
 *
 *  @return super UIViewController
 */
- (UIViewController *)getSuperViewControllerBy:(UIView *)view
{
    UIViewController *viewController = nil;
    UIResponder *next = view.nextResponder;
    while (next)
    {
        if ([next isKindOfClass:[UIViewController class]])
        {
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    return viewController;
}


/**
 *  UITableView的Group样式下顶部空白处理
 *
 *  @param tableView UITableView
 */
+ (void)clearTableTopBlank:(UITableView *)tableView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    tableView.tableHeaderView = view;
}

/**
 *  删除NSUserDefaults所有记录
 */
+ (void)resetUserDefaults{
    [[NSUserDefaults standardUserDefaults]
     removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}


/**
 *  获取系统所有已注册的字体名称
 *
 *  @return key:familyName value:fontNames(NSArray)
 */
+ (NSDictionary *)enumerateFonts{
    NSMutableDictionary *familyNames = [NSMutableDictionary dictionary];
    for(NSString *familyName in [UIFont familyNames])
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        [familyNames setObject:fontNames forKey:familyName];
    }
    return [NSDictionary dictionaryWithDictionary:familyNames];
}

/**
 *  字符串反转
 *
 *  @param str 需要反转的字符串
 *
 *  @return 反转后的字符串
 */
+ (NSString *)reverseWordsInString:(NSString *)str
{
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:str.length];
    for (NSInteger i = str.length - 1; i >= 0 ; i --)
    {
        unichar ch = [str characterAtIndex:i];
        [newString appendFormat:@"%c", ch];
    }
    return newString;
}

/**
 *  禁止锁屏
 */
+ (void)unlockScreen{
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

/**
 *  取消锁屏
 */
+ (void)lockScreen{
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}


/**
 *  模态推出透明界面
 *
 *  @param sourceViewController 源控制器
 *  @param targeViewController  目标控制器
 */
+ (void)presentViewController:(UIViewController *)sourceViewController
                       target:(UIViewController *)targeViewController{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:targeViewController];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        navigationController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    else
    {
        sourceViewController.modalPresentationStyle=UIModalPresentationCurrentContext;
    }
    [sourceViewController presentViewController:navigationController animated:YES completion:nil];
}

/**
 *  跳转到应用评价页
 *
 *  @param appId 应用唯一标识符
 */
+ (void)skipAppStoreGrade:(NSString *)appId{
    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8", appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

/**
 *  跳转到应用详情页
 *
 *  @param appId 应用唯一标识符
 */
+ (void)skipAppStoreDetails:(NSString *)appId{
    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}


/**
 *  获取汉字的拼音(带音标)
 *
 *  @param string 汉字字符串
 *
 *  @return pinyin
 */
+ (NSString *)getPinyinStripMandarinLatinByString:(NSString *)string{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [string mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //返回最近结果
    return pinyin;
}


/**
 *  获取汉字的拼音(不带音标)
 *
 *  @param string 汉字字符串
 *
 *  @return pinyin
 */
+ (NSString *)getPinyinStripCombiningMarksByString:(NSString *)string{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [string mutableCopy];
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //返回最近结果
    return pinyin;
}

/**
 *  更改状态栏的颜色
 *
 *  @param color UIColor
 */
+ (void)setStatusBarBackgroundColor:(UIColor *)color
{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor = color;
    }
}

/**
 *  关闭/返回 到上一个控制器
 *
 *  @param sourceViewcontroller 源控制器
 */
+ (void)dismissViewController:(UIViewController *)sourceViewcontroller{
    NSArray *viewcontrollers = sourceViewcontroller.navigationController.viewControllers;
    if (viewcontrollers.count > 1)
    {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == sourceViewcontroller)
        {
            //push方式
            [sourceViewcontroller.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        //present方式
        [sourceViewcontroller dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 *  获取实际使用的LaunchImage图片
 *
 *  @return 启动页图片名称
 */
+ (NSString *)getLaunchImageName
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    // 竖屏
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}


/**
 *  获取当前屏幕的第一响应者
 *
 *  @return 第一响应
 */
+ (UIView *)getFirstResponder{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    SEL selector = NSSelectorFromString(@"firstResponder");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
      UIView *firstResponder = [keyWindow performSelector:selector];
#pragma clang diagnostic pop
    return firstResponder;
}

/**
 *  判断源视图是不是指定视图的子视图
 *
 *  @param sourceView 源视图
 *  @param targetView 指定视图
 *
 *  @return <#return value description#>
 */
+ (BOOL)isDescendantOfView:(UIView *)sourceView target:(UIView *)targetView{
    return [sourceView isDescendantOfView:targetView];
}


/**
 *  修改UITextField中Placeholder的文字颜色
 *
 *  @param textField UITextField
 *  @param color     Placeholder color
 */
+ (void)setTextField:(UITextField *)textField placeholderLabelColor:(UIColor *)color{
    [textField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}


+ (NSArray *)getAllSubclassesBy:(id)superClass
{
    Class myClass = [superClass class];
    NSMutableArray *mySubclasses = [NSMutableArray array];
    unsigned int numOfClasses;
    Class *classes = objc_copyClassList(&numOfClasses);
    for (unsigned int ci = 0; ci < numOfClasses; ci++)
    {
        Class superClass = classes[ci];
        do{
            superClass = class_getSuperclass(superClass);
        } while (superClass && superClass != myClass);
        if (superClass)
        {
            [mySubclasses addObject: classes[ci]];
        }
    }
    free(classes);
    return mySubclasses;
}

/**
 *  检测设备是否设置了代理
 *
 *  @return YES 已设置 / NO 未设置
 */
+ (BOOL)isSetProxy{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = proxies[0];
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
        return NO;
    return YES;
}


/**
 *  取消UICollectionView的隐式动画
 *
 *  @param collectionView UICollectionView
 *  @param item           item
 *  @param section        section
 */
+ (void)cancelCollectionViewAnimation:(UICollectionView *)collectionView
                     indexPathForItem:(NSInteger)item inSection:(NSInteger)section{
    [UIView performWithoutAnimation:^{
        [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:item inSection:section]]];
    }];
}

/**
 *  获取UIImage占用内存
 *
 *  @param image UIImage
 *
 *  @return 占用内存
 */
+ (NSUInteger)getMemsizeBy:(UIImage *)image{
    return CGImageGetHeight(image.CGImage) * CGImageGetBytesPerRow(image.CGImage);
}

/**
 *  查找一个视图的所有子视图
 *
 *  @param view UIView
 *
 *  @return subViews
 */
+ (NSMutableArray *)allSubViewsForView:(UIView *)view
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (UIView *subView in view.subviews)
    {
        [array addObject:subView];
        if (subView.subviews.count > 0)
        {
            [array addObjectsFromArray:[[self class] allSubViewsForView:subView]];
        }
    }
    return array;
}

/**
 *  获取图片某一点的颜色
 *
 *  @param point CGPoint
 *  @param image UIImage
 *
 *  @return UIColor
 */
- (UIColor *)getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image
{
    UIColor* color = nil;
    CGImageRef inImage = image.CGImage;
    CGContextRef cgctx = [[self class] createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) {
        return nil; /* error */
    }
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    CGContextDrawImage(cgctx, rect, inImage);
    unsigned char* data = CGBitmapContextGetData (cgctx);
    if (data != NULL) {
        int offset = 4*((w*round(point.y))+round(point.x));
        int alpha =  data[offset];
        int red = data[offset+1];
        int green = data[offset+2];
        int blue = data[offset+3];
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:
                 (blue/255.0f) alpha:(alpha/255.0f)];
    }
    CGContextRelease(cgctx);
    if (data) {
        free(data);
    }
    return color;
}

/**
 *  创建取点图片工作域
 *
 *  @param inImage CGImageRef
 *
 *  @return CGContextRef
 */
+ (CGContextRef)createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    unsigned long   bitmapByteCount;
    unsigned long   bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    
    return context;
}

@end





//关于NSDateFormatter的格式
//
//G: 公元时代，例如AD公元
//yy: 年的后2位
//yyyy: 完整年
//MM: 月，显示为1-12
//MMM: 月，显示为英文月份简写,如 Jan
//MMMM: 月，显示为英文月份全称，如 Janualy
//dd: 日，2位数表示，如02
//d: 日，1-2位显示，如 2
//EEE: 简写星期几，如Sun
//EEEE: 全写星期几，如Sunday
//aa: 上下午，AM/PM
//H: 时，24小时制，0-23
//K：时，12小时制，0-11
//m: 分，1-2位
//mm: 分，2位
//s: 秒，1-2位
//ss: 秒，2位
//S: 毫秒

