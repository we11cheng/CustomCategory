//
//  CountDownButton.m
//  CountDownButton
//
//  Created by liquan on 2017/4/17.
//  Copyright © 2017年 liquan. All rights reserved.
//

#import "CountDownButton.h"

//默认的倒计时60s
static const NSInteger DefaultCount = 60;

//默认字体颜色
#define  DefaultFontColor [UIColor orangeColor]
//设置默认背景颜色
#define  DefaultBgColor   [UIColor whiteColor]

@interface CountDownButton()
//剩余的时间
@property(nonatomic,assign)NSInteger remainCount;
//计时器
@property(nonatomic,strong)NSTimer *timer;
@end


@implementation CountDownButton

-(instancetype)initWithIsAuto:(BOOL)isAuto{
    if (self = [super init]) {
        _count = DefaultCount;
        _remainCount = DefaultCount;
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
     
        [self setTitleColor:DefaultFontColor forState:UIControlStateNormal];
        [self setBackgroundColor:DefaultBgColor];
        
        
        if (isAuto) {
            [self setTitle:[NSString stringWithFormat:@"%02ld 秒",_count] forState:0];
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
        }else{
            [self setTitle:@"获取验证码" forState:0];
        }

       
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withIsAuto:(BOOL)isAuto{
    if (self = [super initWithFrame:frame]) {
        _count = DefaultCount;
        _remainCount = DefaultCount;
        
        [self setTitleColor:DefaultFontColor forState:UIControlStateNormal];
        [self setBackgroundColor:DefaultBgColor];
        
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        if (isAuto) {
            [self setTitle:[NSString stringWithFormat:@"%02ld 秒",_count] forState:0];
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
        }else{
            [self setTitle:@"获取验证码" forState:0];
        }
        
        
    }
    return self;
}


-(void)setCount:(NSInteger)count{
    _count = count;
    _remainCount = count;
}


-(void)timerStart:(NSTimer *)timer{
    if (_remainCount == 0) {
        _remainCount = _count;
        [self stop];
    }else{
        
        _remainCount --;
        [self setTitle:[NSString stringWithFormat:@"%02ld 秒",_remainCount] forState:0];
    }
}

-(void)click{
    self.userInteractionEnabled = NO;
    [self setTitle:[NSString stringWithFormat:@"%02ld 秒",_count] forState:0];
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    }
    
    
    if (_ClickButtonBlock) {
        self.ClickButtonBlock();
    }
}

-(void)stop{
    self.userInteractionEnabled = YES;
    if (_timer) {
        [_timer invalidate]; //停止计时器
        _timer = nil;
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
    }
    
    if (_CompleteBlock) {
        self.CompleteBlock();
    }
}



-(void)dealloc{  //销毁计时器
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
@end
