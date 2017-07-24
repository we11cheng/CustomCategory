

//
//  UnlineButton.m
//  QMUITest
//
//  Created by 可可家里 on 2017/7/20.
//  Copyright © 2017年 可可家里. All rights reserved.
//

#import "UnlineButton.h"

@implementation UnlineButton
+(id)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title   titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)bgColor unlineColor:(UIColor*)unlineColor  unlineRange:(NSRange) range handler:(tapHandler)handler
{
    UnlineButton * button =[super buttonWithType:buttonType];
    button.frame =frame;
    button.titleLabel.textAlignment= NSTextAlignmentCenter;
    button.titleLabel.font =[UIFont systemFontOfSize:12];
    [button setTitle:title forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeCenter;
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    NSMutableAttributedString  * attributeStr =[[NSMutableAttributedString alloc] initWithString:title];
    [attributeStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    [attributeStr addAttribute:NSUnderlineColorAttributeName value:unlineColor range:range];
    button.backgroundColor=bgColor;
    button.handler = handler;
    button.titleLabel.attributedText =attributeStr;
    [button addTarget:button action:@selector(btnTapHandler:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


-(void)btnTapHandler:(UIButton *)sender
{
    if (self.handler) {
        self.handler(sender);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
