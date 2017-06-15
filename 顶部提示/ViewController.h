//
//  ViewController.h
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS (NSInteger ,TopAlertViewType){
    TopAlertViewTypeSuccess = 0,
    TopAlertViewTypeError   = 1
};
@interface ViewController : UIViewController

@property (nonatomic,assign) TopAlertViewType alertViewType;
@end
