//
//  WJSegmentMenu.m
//  WJSegmentMenu
//
//  Created by 吴计强 on 16/3/22.
//  Copyright © 2016年 com.firsttruck. All rights reserved.
//

#import "WJSegmentMenu.h"


@interface WJSegmentMenu (){
    
    CGFloat _btnW;
    UIView *_line;
    NSInteger _lastTag;
}

@end

@implementation WJSegmentMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)segmentWithTitles:(NSArray *)titles{
    
    // 创建按钮
    _btnW = self.frame.size.width/titles.count;
    for (int i = 0; i < titles.count; i ++) {
        
        UIButton *button = [[UIButton alloc]init];
        button.tag = 730+i;
        button.frame = CGRectMake(i * _btnW, 0, _btnW, self.frame.size.height-2);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    
    // 创建滑块
    UIView *line = [[UIView alloc]init];
    line.frame = CGRectMake(0, self.frame.size.height-2, _btnW, 2);
    line.backgroundColor = [UIColor greenColor];
    [self addSubview:line];
    _line = line;
}

// 点击事件
- (void)click:(UIButton *)btn{
    
    if (_lastTag >= 700) {
        UIButton *lastBtn = (id)[self viewWithTag:_lastTag];
        lastBtn.selected = NO;
    }
    btn.selected = YES;
    CGFloat lineX = (btn.tag - 730) * _btnW;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _line.frame;
        frame.origin.x = lineX;
        _line.frame = frame;
    }];
    
    _lastTag = btn.tag;
    
    if ([_delegate respondsToSelector:@selector(segmentWithIndex:title:)]) {
        [_delegate segmentWithIndex:(btn.tag-730) title:btn.titleLabel.text];
    }
    
    
}



- (void)layoutSubviews{
    
    
}


@end
