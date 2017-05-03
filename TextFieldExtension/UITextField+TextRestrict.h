//
//  UITextField+TextRestrict.h
//  TextFieldAdjust_Demo
//
//  Created by admin on 16/9/26.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "TextRestrict.h"
//有了文本限制的类，那么接下来我们需要新建一个UITextField的分类来添加输入限制的功能，主要新增三个属性：
@interface UITextField (TextRestrict)
// 设置后生效
@property (nonatomic, assign) RestrictType restrictType;
// 文本最长长度
@property (nonatomic, assign) NSUInteger maxTextLength;
// 设置自定义的文本限制
@property (nonatomic, strong) TextRestrict * textRestrict;
@end
