//
//  YTNavBar.m
//  LoveFreshBeenOC
//
//  Created by youyou on 16/3/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "YTNavBar.h"

@implementation YTNavBar

- (instancetype)initWithFrame:(CGRect)frame backColor:(UIColor *)color centerTitle:(NSString *)cenTitle backAction:(SEL)goBack target:(id)target title:(NSString *)buttonTitle backImage:(NSString *)imageName {
    
    self = [super initWithFrame:frame];
    if(self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:frame];
        backView.backgroundColor = color;
        [self addSubview:backView];
        
        UILabel *centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-40,20,100,40)];
        centerLabel.font = [UIFont systemFontOfSize:16];
        centerLabel.text = cenTitle;
        centerLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:centerLabel];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(2,28,63,23);
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitle:buttonTitle forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:imageName];
        [backButton setImage:image forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [backButton addTarget:target action:goBack forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:backButton];
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
