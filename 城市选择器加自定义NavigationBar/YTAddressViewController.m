//
//  YTAddressViewController.m
//  LoveFreshBeenOC
//
//  Created by youyou on 16/3/18.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "YTAddressViewController.h"
#import "YTNavBar.h"

@interface YTAddressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic,strong)NSString *add;
/**
 *  当前城市数据源，服务器取
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  索引数据源
 */
@property (nonatomic, strong) NSMutableArray *indexSource;

@end

@implementation YTAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIColor *gray = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    YTNavBar *bar = [[YTNavBar alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,64) backColor:gray centerTitle:@"选择城市" backAction:@selector(goBa) target:self title:@"返回" backImage:@"re@2x.png"];
    [self.view addSubview:bar];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.frame.size.width-60,30,55,25);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont  systemFontOfSize:16]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self initData];
    [self initTableView];
    
    
    // Do any additional setup after loading the view.
}
-(void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}
-(void)initData {
    self.dataSource = [[NSMutableArray alloc] init];
    self.indexSource = [[NSMutableArray alloc] init];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *city = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    _dataSource = [self sortArray:city];
}

-(NSMutableArray *)sortArray:(NSMutableArray *)arrayToSort {
    NSMutableArray *arrayForArrays = [[NSMutableArray alloc] init];
    
    //根据拼音对数组排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    //排序
    [arrayToSort sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *tempArray = nil;
    BOOL flag = NO;
    
    //分组
    for (int i = 0; i < arrayToSort.count; i++) {
        NSString *pinyin = [arrayToSort[i] objectForKey:@"pinyin"];
        NSString *firstChar = [pinyin substringToIndex:1];
        //        NSLog(@"%@",firstChar);
        if (![_indexSource containsObject:[firstChar uppercaseString]]) {
            [_indexSource addObject:[firstChar uppercaseString]];
            tempArray = [[NSMutableArray alloc] init];
            flag = NO;
        }
        if ([_indexSource containsObject:[firstChar uppercaseString]]) {
            [tempArray addObject:arrayToSort[i]];
            if (flag == NO) {
                [arrayForArrays addObject:tempArray];
                flag = YES;
            }
        }
    }
    
    return arrayForArrays;
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_indexSource objectAtIndex:section];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _indexSource;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"selectedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.textLabel.text = [[self.dataSource[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.add = [[self.dataSource[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
}




-(void)goBa {
    if(self.delegate && [self.delegate respondsToSelector:@selector(select:)]) {
        [self.delegate select:self.add];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
