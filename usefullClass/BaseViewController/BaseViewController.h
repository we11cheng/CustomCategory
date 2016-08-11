//
//  BaseViewController.h
//  BaseViewController
//
//  Created by Tommy on 15/10/8.
//  Copyright (c) 2015年 Tommy. All rights reserved.
//
//                          _oo8oo_
//                         o8888888o
//                         88" . "88
//                         (| -_- |)
//                         0\  =  /0
//                       ___/'==='\___
//                     .' \\|     |// '.
//                    / \\|||  :  |||// \
//                   / _||||| -:- |||||_ \
//                  |   | \\\  -  /// |   |
//                  | \_|  ''\---/''  |_/ |
//                  \  .-\__  '-'  __/-.  /
//                ___'. .'  /--.--\  '. .'___
//             ."" '<  '.___\_<|>_/___.'  >' "".
//            | | :  `- \`.:`\ _ /`:.`/ -`  : | |
//            \  \ `-.   \_ __\ /__ _/   .-` /  /
//        =====`-.____`.___ \_____/ ___.`____.-`=====
//                          `=---=`
//
//                  佛祖保佑            永无bug
//                          ___  _____         ___
// \         /  /\   |\  | |       |     /\   |   |
//  \  / \  /  /--\  | \ | |  _    |    /__\  |   |
//   \/   \/  /    \ |  \| |___|   |   /    \ |___|

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
@interface BaseViewController : UIViewController


//在这里面写入网络请求成功后的数据解析以及其它代码
@property(nonatomic,copy)void(^success)(id jsonObject);


//get请求方式
-(void)getRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params andAcceptableContentTypes:(NSSet *)acceptableContentTypes;

//post请求方式
-(void)postRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params andAcceptableContentTypes:(NSSet *)acceptableContentTypes;

//是否隐藏键盘
-(void)hiddenKeyboard:(BOOL)yesOrNo WithTextfield:(UITextField *)textield;

//创建按钮
-(UIButton *)createButtonWithButtonType:(UIButtonType)buttonType andFrame:(CGRect)frame andSelecet:(SEL)selector andTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andBackgroundColor:(UIColor *)backgroundColor andNormalImage:(UIImage *)normalIcon andSelectedImage:(UIImage *)selectedIcon;

//创建label
-(UILabel *)createLabelWithFrame:(CGRect)frame andTitle:(NSString *)title andFont:(UIFont *)font andMaskToBounds:(BOOL)maskToBounds;


//创建textField
-(UITextField *)createTextfieldWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeholder andDelegate:(id)delegate;

//创建textView
-(UITextView *)createTextViewWithFrame:(CGRect)frame andDelegate:(id)delegate;


//创建imageView
-(UIImageView *)createImageViewWithFrame:(CGRect)frame andImage:(UIImage *)icon;


//创建TableView
-(UITableView *)createTableViewWithFrame:(CGRect)frame andDataSource:(id)dataSource andDelegate:(id)delegate;

//创建scrollview
-(UIScrollView *)createScrollViewWithFrame:(CGRect)frame andDelegate:(id)delegate andContentSize:(CGSize)size andShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator andShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator andPagingEnabled:(BOOL)pagingEnabled;



@end
