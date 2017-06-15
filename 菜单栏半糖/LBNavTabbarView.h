//
//  LBNavTabbarView.h
//  LBzzz
//
//  Created by fighting on 17/2/7.
//  Copyright © 2017年 labi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBNavTabbarView : UIView
// 标题颜色  默认：灰色 gray
@property (nonatomic , strong)UIColor * titleColor;
// 标题选中颜色 默认：红色  red
@property (nonatomic , strong)UIColor * selectedTColor;
// 小线条颜色 默认：红色  red  小线条的视图为UIImageView，所以可以给其添加图片
@property (nonatomic , strong)UIColor * downLineColor;

/**
 *  LBNavTabbarView初始化操作
 *
 *  @param frame      frame
 *  @param vcArr      数组，里面的元素都是视图控制器
 *  @param titleArr   数组，里面的元素都是字符串
 *  @param lineHeight 小线条的高度
 *
 *  @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame andVCArr:(NSArray<UIViewController *> *)vcArr andTitleArr:(NSArray <NSString *>*)titleArr lineHeight:(CGFloat)lineHeight;

/**
 *  LBNavTabbarView初始化操作
 *
 *  @param frame      frame
 *  @param vcArr      数组，里面的元素都是view视图
 *  @param titleArr   数组，里面的元素都是字符串
 *  @param lineHeight 小线条的高度
 *
 *  @return 示例对象
 */
- (instancetype)initWithFrame:(CGRect)frame andViewArr:(NSArray<UIView *> *)vcArr andTitleArr:(NSArray <NSString *>*)titleArr lineHeight:(CGFloat)lineHeight;

@end
