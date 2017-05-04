//
//  Biology.m
//  RuntimeDemo
//
//  Created by wengzilin on 15/10/14.
//  Copyright (c) 2015年 wengzilin. All rights reserved.
//

#import "Biology.h"
#import <objc/runtime.h>
#import "WZLSerializeKit.h"
@implementation Biology

WZLSERIALIZE_CODER_DECODER();

WZLSERIALIZE_COPY_WITH_ZONE();

WZLSERIALIZE_DESCRIPTION();//不是必须的。

@end
