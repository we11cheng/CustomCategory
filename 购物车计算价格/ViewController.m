//
//  ViewController.m
//  ShoppingCar
//
//  Created by administrator on 2017/5/3.
//  Copyright © 2017年 JohnLai. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Tools.h"
#import "Masonry.h"
#import "ShoppingCarModel.h"
#import "ShoppingCarTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UILabel *totalPriceLB;
@property (nonatomic,strong) UIButton *allChoseBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self createUI];
    [self getData];
}

#pragma mark - data
- (void)getData{
   //模拟数据
    for (NSInteger i = 0; i < 21; i ++) {
        ShoppingCarModel *model = [[ShoppingCarModel alloc]init];
        model.price = arc4random()%500 + 1;
        model.isSelected = 0;
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)createUI{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-45);
    }];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tableView.mas_bottom);
        make.left.right.bottom.equalTo(weakSelf.view);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [bgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    self.totalPriceLB = [[UILabel alloc]init];
    self.totalPriceLB.text = @"合计：¥0";
    self.totalPriceLB.textColor = [UIColor redColor];
    self.totalPriceLB.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:self.totalPriceLB];
    [self.totalPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(bgView);
        make.right.equalTo(bgView.mas_right).offset(-100);
        make.height.mas_equalTo(17);
    }];
    
    self.allChoseBtn = [[UIButton alloc]init];
    [self.allChoseBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.allChoseBtn setTitle:@"取消全选" forState:UIControlStateSelected];
    [self.allChoseBtn setTitleColor:[UIColor colorWithRed:0x37/255.0 green:0xcc/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    [self.allChoseBtn setTitleColor:[UIColor colorWithRed:0x87/255.0 green:0xce/255.0 blue:0xfa/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [self.allChoseBtn addTarget:self action:@selector(allChoseAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.allChoseBtn];
    [self.allChoseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.totalPriceLB.mas_right);
        make.top.right.bottom.equalTo(bgView);
    }];
}

#pragma mark - tableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"ShoppingCarTableViewCell";
    ShoppingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ShoppingCarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
    }
    ShoppingCarModel *model = [self.dataSource objectAtIndex:indexPath.row];
    cell.price = model.price;
    cell.selectedStutas = model.isSelected;
    
    //block callback
    /*
    __weak typeof(self) weakSelf = self;
    cell.ChoseBtnBlock = ^(__weak UITableViewCell *tapCell, BOOL selected) {
        //使用model动态记录cell按钮选中情况
        NSIndexPath *path = [tableView indexPathForCell:tapCell];
        ShoppingCarModel *carModel = [self.dataSource objectAtIndex:path.row];
        carModel.isSelected = selected;
        if (!selected) {
            weakSelf.allChoseBtn.selected = selected;
        }
        [weakSelf calculateWhetherFutureGenerations];
       
    };
    */
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShoppingCarModel *model = [self.dataSource objectAtIndex:indexPath.row];
    model.isSelected = !model.isSelected;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]]  withRowAnimation:UITableViewRowAnimationNone];
    [self calculateWhetherFutureGenerations];
}

#pragma mark - action
- (void)allChoseAction{
    self.allChoseBtn.selected = !self.allChoseBtn.selected;
    NSInteger totalPrice = 0;
    for (NSInteger i = 0; i < self.dataSource.count; i ++) {
        ShoppingCarModel *model = [self.dataSource objectAtIndex:i];
        model.isSelected = self.allChoseBtn.selected;
        if (self.allChoseBtn.selected) {
            totalPrice += model.price;
        }
    }
    self.totalPriceLB.text = [NSString stringWithFormat:@"合计：¥%ld",totalPrice];
    [self.tableView reloadData];
}

//计算是否全选
- (void)calculateWhetherFutureGenerations{
    NSInteger totalSelected = 0;
    NSInteger totalPrice = 0;
    for (NSInteger i = 0; i < self.dataSource.count; i ++){
        ShoppingCarModel *model = [self.dataSource objectAtIndex:i];
        if (model.isSelected) {
            totalSelected ++;
            totalPrice += model.price;
        }
    }
    
    if (totalSelected == self.dataSource.count) {
        self.allChoseBtn.selected = YES;
    }else{
        self.allChoseBtn.selected = NO;
    }
    self.totalPriceLB.text = [NSString stringWithFormat:@"合计：¥%ld",totalPrice];
}

#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
