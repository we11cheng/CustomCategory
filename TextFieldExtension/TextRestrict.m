//
//  TextRestrict.m
//  TextFieldAdjust_Demo
//
//  Created by admin on 16/9/26.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "TextRestrict.h"


@interface TextRestrict ()
@property (nonatomic, readwrite) RestrictType restrictType;
@end

#pragma mark - 继承关系
@interface NumberTextRestrict : TextRestrict//数字
@end

@interface DecimalTextRestrict : TextRestrict//实数
@end

@interface CharacterTextRestrict : TextRestrict//非中文
@end

#pragma mark - 父类实现
@implementation TextRestrict
+ (instancetype)textRestrictWithRestrictType: (RestrictType)restrictType
{
    TextRestrict * textRestrict;
    switch (restrictType) {
        case RestrictTypeOnlyNumber:
            textRestrict = [[NumberTextRestrict alloc] init];
            break;
            
        case RestrictTypeOnlyDecimal:
            textRestrict = [[DecimalTextRestrict alloc] init];
            break;
            
        case RestrictTypeOnlyCharacter:
            textRestrict = [[CharacterTextRestrict alloc] init];
            break;
            
        default:
            break;
    }
    textRestrict.maxLength = NSUIntegerMax;
    textRestrict.restrictType = restrictType;
    return textRestrict;
}

- (void)textDidChanged: (UITextField *)textField
{
    
}

- (NSString *)restrictMaxLength: (NSString *)text
{
    if (text.length > _maxLength) {
        text = [text substringToIndex: self.maxLength];
    }
    return text;
}

@end

//由于子类在筛选的过程中都存在遍历字符串以及正则表达式验证的流程，把这一部分代码逻辑给封装起来。根据EOC的原则优先使用static inline的内联函数而非宏定义：
static inline NSString * kFilterString(NSString * handleString, StringFilter subStringFilter)
{
    NSMutableString * modifyString = handleString.mutableCopy;
    for (NSInteger idx = 0; idx < modifyString.length;) {
        NSString * subString = [modifyString substringWithRange: NSMakeRange(idx, 1)];
        if (subStringFilter(subString)) {
            idx++;
        } else {
            [modifyString deleteCharactersInRange: NSMakeRange(idx, 1)];
        }
    }
    return modifyString;
}

static inline BOOL kMatchStringFormat(NSString * aString, NSString * matchFormat)
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", matchFormat];
    return [predicate evaluateWithObject: aString];
}


#pragma mark - 重写三种继承自TextRestrict的textDidChanged的方法
@implementation NumberTextRestrict

- (void)textDidChanged: (UITextField *)textField
{
    NSString * filterText = kFilterString(textField.text, ^BOOL(NSString *aString) {
        return kMatchStringFormat(aString, @"^\\d$");
    });
    textField.text = [super restrictMaxLength: filterText];
}
@end


@implementation DecimalTextRestrict
- (void)textDidChanged: (UITextField *)textField
{
    NSString * filterText = kFilterString(textField.text, ^BOOL(NSString *aString) {
        return kMatchStringFormat(aString, @"^[0-9.]$");
    });
    textField.text = [super restrictMaxLength: filterText];
}
@end


#pragma mark - 子类实现
@implementation CharacterTextRestrict
- (void)textDidChanged: (UITextField *)textField
{
    NSString * filterText = kFilterString(textField.text, ^BOOL(NSString *aString) {
        return kMatchStringFormat(aString, @"^[^[\\u4e00-\\u9fa5]]$");
    });
    textField.text = [super restrictMaxLength: filterText];
}



@end
