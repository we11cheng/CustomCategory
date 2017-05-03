//
//  UITextField+TextRestrict.m
//  TextFieldAdjust_Demo
//
//  Created by admin on 16/9/26.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "UITextField+TextRestrict.h"
#import <objc/runtime.h>

static void * RestrictTypeKey = &RestrictTypeKey;
static void * TextRestrictKey = &TextRestrictKey;
static void * MaxTextLengthKey = &MaxTextLengthKey;



@implementation UITextField (TextRestrict)
//由于这些属性是category中添加的，我们需要手动生成getter和setter方法，这里使用objc_associate的动态绑定机制来实现。其中核心的方法实现如下：
- (RestrictType)restrictType
{
    return [objc_getAssociatedObject(self, RestrictTypeKey) integerValue];
}

- (void)setRestrictType: (RestrictType)restrictType
{
    objc_setAssociatedObject(self, RestrictTypeKey, @(restrictType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.textRestrict = [TextRestrict textRestrictWithRestrictType: restrictType];
}

- (TextRestrict *)textRestrict
{
    return objc_getAssociatedObject(self, TextRestrictKey);
}

- (void)setTextRestrict: (TextRestrict *)textRestrict
{
    if (self.textRestrict) {
        [self removeTarget: self.text action: @selector(textDidChanged:) forControlEvents: UIControlEventEditingChanged];
    }
    textRestrict.maxLength = self.maxTextLength;
    [self addTarget: textRestrict action: @selector(textDidChanged:) forControlEvents: UIControlEventEditingChanged];
    objc_setAssociatedObject(self, TextRestrictKey, textRestrict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)maxTextLength
{
    NSUInteger maxTextLength = [objc_getAssociatedObject(self, MaxTextLengthKey) unsignedIntegerValue];
    if (maxTextLength == 0) {
        self.maxTextLength = NSUIntegerMax;
    }
    return [objc_getAssociatedObject(self, MaxTextLengthKey) unsignedIntegerValue];
}

- (void)setMaxTextLength: (NSUInteger)maxTextLength
{
    if (maxTextLength == 0) {
        maxTextLength = NSUIntegerMax;
    }
    objc_setAssociatedObject(self, MaxTextLengthKey, @(maxTextLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
