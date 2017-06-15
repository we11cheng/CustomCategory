//
//  ZAlertViewManager.h
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZAlertView.h"
@interface ZAlertViewManager : NSObject
@property (nonatomic,strong)ZAlertView *alertView;
+ (ZAlertViewManager *)shareManager;

- (void)showWithType:(AlertViewType)type;
- (void)dismissWithTime:(NSInteger)time;
@end
