//
//  ProblemTitleModel.m
//  KCB
//
//  Created by haozp on 16/1/6.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "ProblemTitleModel.h"
#import "AnswerModel.h"

@implementation ProblemTitleModel

+ (instancetype)friendGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in _infor) {
            AnswerModel *answer = [AnswerModel answerWithDict:dict];
            [tempArray addObject:answer];
        }
        _infor = tempArray;
    }
    return self;
}
@end
