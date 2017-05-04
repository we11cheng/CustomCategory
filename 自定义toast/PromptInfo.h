//
//  PromptInfo.h
//  PromptInfo_Demo
//
//  Created by admin on 2016/11/15.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PromptInfo : NSObject{
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
    UILabel *textLabel;
    BOOL firstIn;//第一次初始化
}

+(void)showWithText:(NSString *) text;

+(void)showWithText:(NSString *) text
           duration:(CGFloat)duration;

+(void)showWithText:(NSString *) text
          topOffset:(CGFloat) topOffset;


+(void)showWithText:(NSString *) text
          topOffset:(CGFloat) topOffset
           duration:(CGFloat) duration;

+ (void)showText:(NSString*)text_;


@end
