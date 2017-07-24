//
//  CustomButton.h
//  QMUITest
//
//  Created by 可可家里 on 2017/7/20.
//  Copyright © 2017年 可可家里. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^tapHandler)(UIButton * sender);
@interface CustomButton : UIButton
@property (nonatomic,strong) tapHandler handler;


/**
 自定button的title和image的位置

 @param buttonType button类型
 @param frame <#frame description#>
 @param title <#title description#>
 @param image <#image description#>
 @param bgColor <#bgColor description#>
 @param handler <#handler description#>
 @return <#return value description#>
 */
+(id)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title image:(UIImage *)image backgroundColor:(UIColor *)bgColor handler:(tapHandler)handler;



@end
