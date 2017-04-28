//
//  FYLSegmentView.m
//  FYLPageViewController
//
//  Created by FuYunLei on 2017/4/17.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "FYLSegmentView.h"

@interface FYLSegmentView()

@property(nonatomic,strong)NSArray *titles;
@property (nonatomic,strong)CALayer *maskLayer;

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,assign)CGFloat itemWidth;
@end

@implementation FYLSegmentView

- (FYLSegmentView *)initWithTitles:(NSArray *)titles{
    
    if (self = [super initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44)]) {
        self.titles = titles;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = FYLColorFromHexadecimalRGB(0xf7f7f7);
    
    //scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    //top
    UIView *viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    viewTop.backgroundColor = FYLColorFromHexadecimalRGB(0xf7f7f7);
  
    _itemWidth = SCREEN_WIDTH/_titles.count;
    
    if (self.titles.count > 5) {
        _itemWidth = 64;
    }
    
    for (int i = 0; i < _titles.count; i++) {
        UILabel *labelBottom = [[UILabel alloc] initWithFrame:CGRectMake(_itemWidth * i, 0, _itemWidth, 44)];
        labelBottom.text = _titles[i];
        labelBottom.textAlignment = NSTextAlignmentCenter;
        labelBottom.font = [UIFont systemFontOfSize:16];
        
        //未选中字体颜色
        labelBottom.textColor = FYLColorFromHexadecimalRGB(0x000000);
        [self.scrollView addSubview:labelBottom];
        
        UILabel *labelTop = [[UILabel alloc] initWithFrame:CGRectMake(_itemWidth * i, 0, _itemWidth, 44)];
        labelTop.text = _titles[i];
        labelTop.textAlignment = NSTextAlignmentCenter;
        labelTop.font = [UIFont systemFontOfSize:16];
        
        //选中字体颜色
        labelTop.textColor = FYLColorFromHexadecimalRGB(0x93C4F6);
        labelTop.tag = i;
        labelTop.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeView:)];
        [labelTop addGestureRecognizer:tapLeft];
        [viewTop addSubview:labelTop];
    }
     [self.scrollView addSubview:viewTop];
  
    self.scrollView.contentSize = CGSizeMake(self.titles.count * _itemWidth, 44);
    viewTop.frame = CGRectMake(0, 0, self.titles.count * _itemWidth, 44);

    UIView *_viewIndex = [[UIView alloc] initWithFrame:CGRectMake(0, 42, self.titles.count * _itemWidth, 2)];
    
    //指示下标颜色
    _viewIndex.backgroundColor = FYLColorFromHexadecimalRGB(0x93C4F6);
    [viewTop addSubview:_viewIndex];

    //mask
    _maskLayer = [[CALayer alloc] init];
    _maskLayer.frame = CGRectMake(_itemWidth/2 - kMaskWidth/2, 0, kMaskWidth, 44);
    _maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    viewTop.layer.mask = _maskLayer;

}
///标签点击事件
- (void)changeView:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(FYLSegmentView:didClickTagAtIndex:)]) {
        [self.delegate FYLSegmentView:self didClickTagAtIndex:tap.view.tag];
    }
}
- (void)setOffsetOfIndexView:(CGFloat)offsetX withCurrentIndex:(NSInteger)index{
    
    [self setFrameOfIndexView:CGRectMake(index * _itemWidth + (_itemWidth)/2 - kMaskWidth/2 + offsetX/(self.titles.count - 1), 0, kMaskWidth, 44)];
    
}
#pragma mark - 内部方法
- (void)setFrameOfIndexView:(CGRect)frame{
    _maskLayer.frame = frame;
    [self setScrollViewOffset:frame];
}

///处理边界问题
- (void)setScrollViewOffset:(CGRect)frame{
    
    CGPoint pointOffset = self.scrollView.contentOffset;
    
    CGFloat rightMax = frame.origin.x + frame.size.width;
    CGFloat leftMin = frame.origin.x;
    if (rightMax >= pointOffset.x + SCREEN_WIDTH || rightMax >= self.titles.count * _itemWidth) {
        pointOffset.x = rightMax - SCREEN_WIDTH;
        self.scrollView.contentOffset = pointOffset;
    }
    
    if (leftMin <= pointOffset.x || leftMin <= 0) {
        pointOffset.x = leftMin;
        self.scrollView.contentOffset = pointOffset;
    }
    
    
}

@end
