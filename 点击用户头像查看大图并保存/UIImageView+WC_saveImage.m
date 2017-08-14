//
//  UIImageView+WC_saveImage.m
//  test
//
//  Created by admin on 14/08/2017.
//  Copyright © 2017 guanweicheng. All rights reserved.
//

#import "UIImageView+WC_saveImage.h"
#import <Photos/Photos.h>

#define LFLANIMATEDURATION 0.3

static CGRect originFrame;

@implementation UIImageView (WC_saveImage)

- (void)GWCHeadimageBrowser {
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadimageHandle)]];
}

- (void)tapHeadimageHandle{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    originFrame = [self convertRect:self.bounds toView:window];
    NSLog(@"oldframe%@",NSStringFromCGRect(originFrame));
    backgroundView.backgroundColor =[UIColor blackColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:originFrame];
    imageView.tag = 1111;
    [imageView setImage:self.image];
    
    UIButton *saveButton = [[UIButton alloc] init];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    saveButton.layer.cornerRadius = 5;
    saveButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    saveButton.clipsToBounds = YES;
    saveButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 25, [UIScreen mainScreen].bounds.size.height - 60, 50, 25);
    [saveButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveCurrentImageClick)]];
    
    [backgroundView addSubview:saveButton];
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    [backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction:)]];
    //  view big  eadimageBrowser
    [UIView animateWithDuration:LFLANIMATEDURATION animations:^{
        CGFloat y,width,height;
        y = ([UIScreen mainScreen].bounds.size.height - self.image.size.height * [UIScreen mainScreen].bounds.size.width / self.image.size.width) * 0.5;
        width = [UIScreen mainScreen].bounds.size.width;
        
        height = self.image.size.height * [UIScreen mainScreen].bounds.size.width / self.image.size.width;
        [imageView setFrame:CGRectMake(0, y, width, height)];
    } completion:nil];
}

- (void)dismissAction:(UITapGestureRecognizer *)tapRecognizer{
    UIView *backgroundView= tapRecognizer.view;
    [UIView animateWithDuration:LFLANIMATEDURATION animations:^{
        [[backgroundView viewWithTag:1111] setFrame:originFrame];
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

- (void)saveCurrentImageClick{
    __weak typeof(self) weakSelf = self;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:weakSelf.image];
        req = nil;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // tips message
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UILabel *tipsLabel = [[UILabel alloc] init];
            tipsLabel.textColor = [UIColor whiteColor];
            tipsLabel.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
            tipsLabel.layer.cornerRadius = 5;
            tipsLabel.clipsToBounds = YES;
            tipsLabel.bounds = CGRectMake(0, 0, 200, 30);
            tipsLabel.center = window.center;
            tipsLabel.textAlignment = NSTextAlignmentCenter;
            tipsLabel.font = [UIFont boldSystemFontOfSize:17];
            [window addSubview:tipsLabel];
            [window bringSubviewToFront:tipsLabel];
            if (success) {
                tipsLabel.text = @"保存成功!";
            }else{
                if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
                    tipsLabel.text = @"保存成功!";
                }else{
                    // 处理第三种情况,监听用户第一次授权情况
                    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
                        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                            if (status == PHAuthorizationStatusAuthorized) {
                                // 递归处理一次 , 因为系统框只弹出这一次
                                [weakSelf saveCurrentImageClick];
                                return ;
                            }
                        }];
                    }else{
                        tipsLabel.text = @"暂无权限访问您的相册!";
                    }
                }
            }
            [tipsLabel performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
        });
    }];
}

@end
