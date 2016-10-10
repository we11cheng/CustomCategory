//
//  ScrollView.m
//  仿头条滑动切换视图
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ScrollView.h"
#import "UIView+XMGExtension.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define BtnWidth ScreenWidth/_headArray.count

@implementation ScrollView

-(instancetype)init{
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
//        self.headArray = @[@"头条",@"娱乐",@"体育",@"上海",@"美女",@"社会",@"百度"];
        
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

-(void)setHeadArray:(NSMutableArray *)headArray{
    _headArray = headArray;
    [self createScrollSubView:self.bounds];

}


-(void)createScrollSubView:(CGRect)frame{
    //滑动视图的颜色
    self.backgroundColor = [UIColor whiteColor];
    //滑动区域
    self.contentSize = CGSizeMake(BtnWidth * _headArray.count, 0);
    //防止滑动时弹跳
    self.bounces = NO;
    
    // 底部的红色指示器
    _indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = [UIColor redColor];
    _indicatorView.height = 2;
    _indicatorView.tag = -1;
    _indicatorView.y = 38;
    [self addSubview:_indicatorView];
    
    [self createBtn];
   
}




#pragma amrk -循环创建button
-(void)createBtn{
    
    
    for (int i=0; i<_headArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(BtnWidth * i, 0, BtnWidth, 40);
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitle:_headArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if (i==0) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            [button.titleLabel sizeToFit];
            _indicatorView.width = button.titleLabel.frame.size.width;
            _indicatorView.centerX = button.center.x;
            [self buttonAction:button];
        }
        button.tag = i + 1000;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

-(void)buttonAction:(UIButton *)button{
    //获取button的tag
    _currentBtn = (int)button.tag-1000;
    //调用点击改变字体颜色的方法
    [self changeBtntitleColorWith:(int)(button.tag - 1000)];
    //代理方法
    if ([self.SeletedDelegate respondsToSelector:@selector(seletedControllerWith:)]) {
        [self.SeletedDelegate seletedControllerWith:button];
    }
}

-(void)changeBtntitleColorWith:(int)tag{
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {//判断该subViews是否是button
            //是
            if (obj.tag == tag) {//subViews的tag与按钮的tag一样
                //改变颜色
                [obj setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                // 动画
                [UIView animateWithDuration:0.25 animations:^{
                    self.indicatorView.width = obj.titleLabel.frame.size.width;
                    _indicatorView.centerX = obj.center.x;
                }];

                //----------------------------
                if (obj.frame.origin.x < ScreenWidth/2) {
                    [UIView animateWithDuration:0.5 animations:^{
                        [UIView animateWithDuration:0.25 animations:^{
                            self.indicatorView.width = obj.titleLabel.frame.size.width;
                            _indicatorView.centerX = obj.center.x;
                        }];
                    }];
                }
                //----------------------------

            }else{//如果obj.tag != tag
                [obj setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                obj.titleLabel.font = [UIFont systemFontOfSize:16];
            }
        }
    }];
}


@end
