//
//  UIView+WCKeyboardObServer.h
//  TestGwc
//
//  Created by admin on 23/04/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WCKeyboardObServer)

/**
 *  为界面中所有的输入框添加键盘观察器，回车键监听，触控其他区域监听
 *  请在 'viewDidAppear' 方法中应用
 */
-(void)addGlobalKeyboardObserver;
/**
 *  为界面中所有的输入框移除键盘观察器，回车键监听，触控其他区域监听
 *  请在 'viewDidDisappear'' 方法中应用
 */
-(void)removeGlobalKeyboardObserver;
/**
 *  为指定输入框添加键盘观察器,回车键监听，触控其他区域监听
 *  请在 'viewDidAppear' 方法中应用
 */
- (void)addKeyboardObserver;

/**
 *  为指定输入框移除键盘观察器，回车键监听，触控其他区域监听
 *  请在 'viewDidDisappear'' 方法中应用
 */
- (void)removeKeyboardObserver;
/**
 * 为指定输入框添加键盘观察器，触控其他区域监听
 * 请在 'viewDidDisappear'' 方法中应用
 */
- (void)addSimpleKeyboardObserver;

@end
