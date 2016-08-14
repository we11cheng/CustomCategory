//
//  BaseViewController.m
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

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "BaseViewController.h"
#import "AFHTTPRequestOperationManager.h"
@interface BaseViewController ()


@end

@implementation BaseViewController


//get请求
-(void)getRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params andAcceptableContentTypes:(NSSet *)acceptableContentTypes
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=acceptableContentTypes;
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
}

//post请求
-(void)postRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params andAcceptableContentTypes:(NSSet *)acceptableContentTypes
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=acceptableContentTypes;
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
}

//是否隐藏键盘
-(void)hiddenKeyboard:(BOOL)yesOrNo WithTextfield:(UITextField *)textield
{
    if (yesOrNo==NO) {
        return;
    }
    [textield resignFirstResponder];
    NSInteger offset=CGRectGetMaxY(textield.frame)-(HEIGHT-216.0);
    if (offset>0) {
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame=CGRectMake(0, -offset, WIDTH, HEIGHT);
    }
    [UIView commitAnimations];
}

//创建按钮
-(UIButton *)createButtonWithButtonType:(UIButtonType)buttonType andFrame:(CGRect)frame andSelecet:(SEL)selector andTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andBackgroundColor:(UIColor *)backgroundColor andNormalImage:(UIImage *)normalIcon andSelectedImage:(UIImage *)selectedIcon
{
    UIButton *btn=[UIButton buttonWithType:buttonType];
    btn.frame=frame;
    [btn setBackgroundColor:backgroundColor];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:normalIcon forState:UIControlStateNormal];
    [btn setBackgroundImage:selectedIcon forState:UIControlStateSelected];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}


//创建label
-(UILabel *)createLabelWithFrame:(CGRect)frame andTitle:(NSString *)title andFont:(UIFont *)font andMaskToBounds:(BOOL)maskToBounds
{
    UILabel *label=[[UILabel alloc] initWithFrame:frame];
    label.text=title;
    label.font=font;
    if (maskToBounds==YES) {
        label.layer.cornerRadius=5.0;
        label.layer.masksToBounds=YES;
    }
    return label;
}

//创建textField
-(UITextField *)createTextfieldWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeholder andDelegate:(id)delegate
{
    UITextField *textField=[[UITextField alloc] initWithFrame:frame];
    textField.placeholder=placeholder;
    textField.delegate=delegate;
    return textField;
}


//创建textView
-(UITextView *)createTextViewWithFrame:(CGRect)frame andDelegate:(id)delegate
{
    UITextView *textView=[[UITextView alloc] initWithFrame:frame];
    textView.delegate=delegate;
    return textView;
}


//创建ImageView
-(UIImageView *)createImageViewWithFrame:(CGRect)frame andImage:(UIImage *)icon
{
    UIImageView *iconView=[[UIImageView alloc] initWithFrame:frame];
    iconView.image=icon;
    return iconView;
}


//创建tableView
-(UITableView *)createTableViewWithFrame:(CGRect)frame andDataSource:(id)dataSource andDelegate:(id)delegate
{
    UITableView *tableView=[[UITableView alloc] initWithFrame:frame];
    tableView.dataSource=dataSource;
    tableView.delegate=delegate;
    return tableView;
}


//创建scrollView
-(UIScrollView *)createScrollViewWithFrame:(CGRect)frame andDelegate:(id)delegate andContentSize:(CGSize)size andShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator andShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator andPagingEnabled:(BOOL)pagingEnabled
{
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:frame];
    scrollView.delegate=delegate;
    scrollView.contentSize=size;
    scrollView.showsHorizontalScrollIndicator=showsHorizontalScrollIndicator;
    scrollView.showsVerticalScrollIndicator=showsVerticalScrollIndicator;
    scrollView.pagingEnabled=pagingEnabled;
    return scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
