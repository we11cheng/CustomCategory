//
//  CustomButton.m
//  QMUITest
//
//  Created by 可可家里 on 2017/7/20.
//  Copyright © 2017年 可可家里. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;
}

+(id)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title image:(UIImage *)image backgroundColor:(UIColor *)bgColor handler:(tapHandler)handler{
    
    CustomButton * button =[super buttonWithType:buttonType];
    button.frame =frame;
    button.titleLabel.textAlignment= NSTextAlignmentCenter;
    button.titleLabel.font =[UIFont systemFontOfSize:12];
    [button setTitle:title forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeCenter;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.backgroundColor=bgColor;
    button.handler = handler;
    [button addTarget:button action:@selector(btnTapHandler:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}






-(void)btnTapHandler:(UIButton *)sender
{
    if (self.handler) {
        self.handler(sender);
    }
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight= contentRect.size.height*0.8;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX= 0;
    CGFloat titleHeight = contentRect.size.height *0.2;
    CGFloat titleY =contentRect.size.height-titleHeight -3;
    CGFloat titleWidth =contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);

}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
