//
//  YTAddressViewController.h
//  LoveFreshBeenOC
//
//  Created by youyou on 16/3/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YTAdressDelegate <NSObject>

-(void)select:(NSString *)addString;

@end

@interface YTAddressViewController : UIViewController

@property(nonatomic,weak)id<YTAdressDelegate>delegate;

@end
