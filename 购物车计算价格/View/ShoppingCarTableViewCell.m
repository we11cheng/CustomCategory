//
//  ShoppingCarTableViewCell.m
//  ShoppingCar
//
//  Created by administrator on 2017/5/3.
//  Copyright © 2017年 JohnLai. All rights reserved.
//

#import "ShoppingCarTableViewCell.h"
#import "Masonry.h"

@interface ShoppingCarTableViewCell ()

@property (nonatomic,strong) UILabel *priceLB;
@property (nonatomic,strong) UIButton *choseBtn;

@end

@implementation ShoppingCarTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
    }
    return self;
}

#pragma mark - customCell
- (void)createCell{
    __weak typeof(self) weakSelf = self;
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakSelf.contentView);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-1);
    }];
    
    self.priceLB = [[UILabel alloc]init];
    self.priceLB.textColor = [UIColor redColor];
    [bgView addSubview:self.priceLB];
    [self.priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(17);
        make.centerY.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(150, 17));
    }];
    
    self.choseBtn = [[UIButton alloc]init];
    [self.choseBtn setImage:[UIImage imageNamed:@"icon_noChose"] forState:UIControlStateNormal];
    [self.choseBtn setImage:[UIImage imageNamed:@"icon_chose"] forState:UIControlStateSelected];
    [self.choseBtn addTarget:self action:@selector(choseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.choseBtn];
    [self.choseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(-17);
        make.centerY.equalTo(bgView);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
}

#pragma mark - setter
- (void)setPrice:(NSInteger)price{
    self.priceLB.text = [NSString stringWithFormat:@"¥%ld",price];
}

- (void)setSelectedStutas:(BOOL)selectedStutas{
    self.choseBtn.selected = selectedStutas;
}

#pragma mark - action
- (void)choseBtnAction{
    self.choseBtn.selected = !self.choseBtn.selected;
    if (self.ChoseBtnBlock) {
        self.ChoseBtnBlock(self, self.choseBtn.selected);
    }
}

@end
