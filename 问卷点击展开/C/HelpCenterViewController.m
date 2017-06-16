//
//  HelpCenterViewController.m
//  KCB
//
//  Created by haozp on 16/1/5.
//  Copyright © 2016年 haozp. All rights reserved.
//
#define SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)

#import "HelpCenterViewController.h"
#import "ProblemTitleModel.h"
#import "AnswerModel.h"
#import "HeadView.h"
#import "AnswerCell.h"

@interface HelpCenterViewController () <UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *answersArray;
@property (nonatomic, assign) CGSize textSize;
@end

@implementation HelpCenterViewController
- (NSMutableArray *)answersArray{
    if (_answersArray == nil) {
        self.answersArray = [NSMutableArray array];
    }
    return _answersArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.sectionHeaderHeight = 50;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self loadData];
    
}

#pragma mark 加载数据
- (void)loadData
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"problemCenter.plist" withExtension:nil];
    NSArray *tempArray = [NSArray arrayWithContentsOfURL:url];
    
    self.answersArray = [NSMutableArray array];
    for (NSDictionary *dict in tempArray) {
        ProblemTitleModel *titleGroup = [ProblemTitleModel friendGroupWithDict:dict];
        [self.answersArray addObject:titleGroup];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.answersArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ProblemTitleModel *titleGroup = self.answersArray[section];
    NSInteger count = titleGroup.isOpened ? titleGroup.infor.count : 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    AnswerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnswerCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ProblemTitleModel *titleGroup = self.answersArray[indexPath.section];
    AnswerModel *answerModel = titleGroup.infor[indexPath.row];
    
    cell.textViewLabel.text = answerModel.answer;
    
    self.textSize = [self getLabelSizeFortextFont:[UIFont systemFontOfSize:15] textLabel:answerModel.answer];
//    NSLog(@"====%f",self.textSize.height);

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return self.textSize.height+20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    
    headView.delegate = self;
    headView.titleGroup = self.answersArray[section];
    
    return headView;
}

- (void)clickHeadView
{
    [self.tableView reloadData];
}


- (CGSize)getLabelSizeFortextFont:(UIFont *)font textLabel:(NSString *)text{
    NSDictionary * totalMoneydic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize totalMoneySize =[text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-16,1000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:totalMoneydic context:nil].size;
    return totalMoneySize;
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
