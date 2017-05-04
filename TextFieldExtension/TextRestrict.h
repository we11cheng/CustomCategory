//
//  TextRestrict.h
//  TextFieldAdjust_Demo
//
//  Created by admin on 16/9/26.
//  Copyright © 2016年 AlezJi. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


typedef BOOL(^StringFilter)(NSString * aString);

typedef NS_ENUM(NSInteger, RestrictType)
{
    RestrictTypeOnlyNumber = 1,      ///< 只允许输入数字
    RestrictTypeOnlyDecimal = 2,     ///<  只允许输入实数，包括.
    RestrictTypeOnlyCharacter = 3,  ///<  只允许非中文输入
};

/*!
 *  文本限制
 */



@interface TextRestrict : NSObject

// 工厂
@property (nonatomic, assign) NSUInteger maxLength;
// 子类实现来限制文本内容
@property (nonatomic, readonly) RestrictType restrictType;

+ (instancetype)textRestrictWithRestrictType: (RestrictType)restrictType;
- (void)textDidChanged: (UITextField *)textField;




@end
