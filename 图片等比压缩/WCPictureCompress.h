//
//  WCPictureCompress.h
//  TestGwc
//
//  Created by admin on 21/05/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WCPictureCompress : NSObject

+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;

@end
