//
//  WCPictureCompress.m
//  TestGwc
//
//  Created by admin on 21/05/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import "WCPictureCompress.h"

@implementation WCPictureCompress

//对图片等比压缩
+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    //先判断高宽
    if (width>height) {
        if (width>=targetWidth) {
            CGFloat targetHeight = (targetWidth / width) * height;
            
            UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
            [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
            
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            return newImage;
        }else{
            return sourceImage;
        }
        
    }else{
        if (height>=targetWidth) {
            CGFloat targetWidth2 = (targetWidth / height) * width;
            
            UIGraphicsBeginImageContext(CGSizeMake(targetWidth2, targetWidth));
            [sourceImage drawInRect:CGRectMake(0, 0, targetWidth2, targetWidth)];
            
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            return newImage;
        }else{
            return sourceImage;
        }
        
    }
}

@end
