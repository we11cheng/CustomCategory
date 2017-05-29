//
//  CommonTool.h
//  AopHook
//
//  Created by mopellet on 17/4/19.
//  Copyright © 2017年 eegsmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonTool : NSObject

/**
 *  获取某个view所在的控制器
 *
 *  @return super UIViewController
 */
- (UIViewController *)getSuperViewControllerBy:(UIView *)view;

/**
 *  UITableView的Group样式下顶部空白处理
 *
 *  @param tableView UITableView
 */
+ (void)clearTableTopBlank:(UITableView *)tableView;

/**
 *  删除NSUserDefaults所有记录
 */
+ (void)resetUserDefaults;

/**
 *  获取系统所有已注册的字体名称
 *
 *  @return key:familyName value:fontNames(NSArray)
 */
+ (NSDictionary *)enumerateFonts;

/**
 *  字符串反转
 *
 *  @param str 需要反转的字符串
 *
 *  @return 反转后的字符串
 */
+ (NSString *)reverseWordsInString:(NSString *)str;

/**
 *  禁止锁屏
 */
+ (void)unlockScreen;

/**
 *  取消锁屏
 */
+ (void)lockScreen;

/**
 *  模态推出透明界面
 *
 *  @param sourceViewController 源控制器
 *  @param targeViewController  目标控制器
 */
+ (void)presentViewController:(UIViewController *)sourceViewController
                       target:(UIViewController *)targeViewController;

/**
 *  跳转到应用评价页
 *
 *  @param appId 应用唯一标识符
 */
+ (void)skipAppStoreGrade:(NSString *)appId;

/**
 *  跳转到应用详情页
 *
 *  @param appId 应用唯一标识符
 */
+ (void)skipAppStoreDetails:(NSString *)appId;


/**
 *  获取汉字的拼音(带音标)
 *
 *  @param string 汉字字符串
 *
 *  @return pinyin
 */
+ (NSString *)getPinyinStripMandarinLatinByString:(NSString *)string;

/**
 *  获取汉字的拼音(不带音标)
 *
 *  @param string 汉字字符串
 *
 *  @return pinyin
 */
+ (NSString *)getPinyinStripCombiningMarksByString:(NSString *)string;

/**
 *  更改状态栏的颜色
 *
 *  @param color UIColor
 */
+ (void)setStatusBarBackgroundColor:(UIColor *)color;

/**
 *  关闭/返回 到上一个控制器
 *
 *  @param sourceViewcontroller 源控制器
 */
+ (void)dismissViewController:(UIViewController *)sourceViewcontroller;

/**
 *  获取实际使用的LaunchImage图片
 *
 *  @return 启动页图片名称
 */
+ (NSString *)getLaunchImageName;

/**
 *  获取当前屏幕的第一响应者
 *
 *  @return 第一响应
 */
+ (UIView *)getFirstResponder;

/**
 *  判断源视图是不是指定视图的子视图
 *
 *  @param sourceView 源视图
 *  @param targetView 指定视图
 *
 *  @return <#return value description#>
 */
+ (BOOL)isDescendantOfView:(UIView *)sourceView target:(UIView *)targetView;

/**
 *  修改UITextField中Placeholder的文字颜色
 *
 *  @param textField UITextField
 *  @param color     Placeholder color
 */
+ (void)setTextField:(UITextField *)textField placeholderLabelColor:(UIColor *)color;

+ (NSArray *)getAllSubclassesBy:(id)superClass;

/**
 *  检测设备是否设置了代理
 *
 *  @return YES 已设置 / NO 未设置
 */
+ (BOOL)isSetProxy;

/**
 *  取消UICollectionView的隐式动画
 *
 *  @param collectionView UICollectionView
 *  @param item           item
 *  @param section        section
 */
+ (void)cancelCollectionViewAnimation:(UICollectionView *)collectionView
                     indexPathForItem:(NSInteger)item inSection:(NSInteger)section;

/**
 *  获取UIImage占用内存
 *
 *  @param image UIImage
 *
 *  @return 内存大小
 */
+ (NSUInteger)getMemsizeBy:(UIImage *)image;
/**
 *  查找一个视图的所有子视图
 *
 *  @param view UIView
 *
 *  @return subViews
 */
+ (NSMutableArray *)allSubViewsForView:(UIView *)view;

/**
 *  获取图片某一点的颜色
 *
 *  @param point CGPoint
 *  @param image UIImage
 *
 *  @return UIColor
 */
- (UIColor *)getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image;
@end
