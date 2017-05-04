//
//  UILabel+Style.m
//  SuperWallet_Personal
//
//  Created by 赵诣 on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UILabel+Style.h"

@implementation UILabel (Style)

+ (CGFloat)heightWithText:(NSString *)text fontSize:(NSInteger)fontSize labelWidth:(CGFloat)labelWidth {
    
    if ([text isEqualToString:@""]) {
        return 0;
    }
    // 设置一个字典 保存文本属性
    // 保存文本字体大小 和label设置大小保持一致
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    // 预设一个尺寸大小 文本最大不超过 这个尺寸
    CGSize size = CGSizeMake(labelWidth, 5000);
    // 根据文本内容获得一个CGRect
    
    // 参数1: 尺寸范围
    // 参数2: 按照什么方式获取rect
    // 参数3: 文本属性
    // 参数4: nil
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    // 返回得到高度
    return rect.size.height;
}

- (void)setText:(NSString *)text
       textFont:(UIFont *)textFont
      fontRange:(NSRange)fontRange
{
    NSString *strdec = text;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:strdec];
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [muStr addAttribute:NSFontAttributeName value:textFont range:fontRange];
    
    [self setAttributedText:muStr];
}

- (void)setText:(NSString *)text
      textcolor:(UIColor *)color
     colorRange:(NSRange)colorRange
{
    NSString *strdec = text;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:strdec];
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [muStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    
    [self setAttributedText:muStr];
}

- (void)setText:(NSString *)text
       textFont:(UIFont *)textFont
      fontRange:(NSRange)fontRange
      textcolor:(UIColor *)color
     colorRange:(NSRange)colorRange
{
    NSString *strdec = text;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:strdec];
    NSMutableAttributedString * muStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [muStr addAttribute:NSFontAttributeName value:textFont range:fontRange];
    [muStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    
    [self setAttributedText:muStr];
}
@end
