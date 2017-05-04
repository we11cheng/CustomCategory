//
//  ObjectFunction.h
//  新版本新功能测试
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 cheniue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ObjectFunction : NSObject
+(UIImage*)createBlurBackground:(UIImage*)image blurRadius:(CGFloat)blurRadius
;
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
;
@end

//毛玻璃效果（高斯模糊）

//    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//
//    visualEffectView.frame = self.photoImageView.bounds;
//
//    [self.photoImageView addSubview:visualEffectView];

//毛玻璃效果（高斯模糊）
//[self.photoImageView setImage:[[UIImage imageNamed:@"test.jpeg"] applyDarkEffect]];

//    毛玻璃效果（高斯模糊）
//[self.photoImageView setImage:[ObjectFunction createBlurBackground:[UIImage imageNamed:@"test.jpeg"] blurRadius:10.0f]];

//    毛玻璃效果（高斯模糊）
//[self.photoImageView setImage:[ObjectFunction blurryImage:[UIImage imageNamed:@"test.jpeg"] withBlurLevel:10.0f]];
