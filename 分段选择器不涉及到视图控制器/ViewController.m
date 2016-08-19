//
//  ViewController.m
//  WJSegmentMenu
//
//  Created by 吴计强 on 16/3/22.
//  Copyright © 2016年 com.firsttruck. All rights reserved.
//

#import "ViewController.h"
#import "WJSegmentMenu.h"


@interface ViewController ()<WJSegmentMenuDelegate>
{
    UILabel *_lb;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WJSegmentMenu";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self createSegmentMenu];
    
    
    
}
- (void)createSegmentMenu{
    
    WJSegmentMenu *segmentMenu = [[WJSegmentMenu alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    segmentMenu.delegate = self;
    [segmentMenu segmentWithTitles:@[@"完成",@"未完成",@"待接单"]];
    [self.view addSubview:segmentMenu];
}

- (void)segmentWithIndex:(NSInteger)index title:(NSString *)title{
    
    if (_lb == nil) {
        NSLog(@"index : %ld ,title : %@",index,title);
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
        lb.text = [NSString stringWithFormat:@"index : %ld          title :%@ ",index,title];
        lb.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [self.view addSubview:lb];
        _lb = lb;
    }else{
        _lb.text = [NSString stringWithFormat:@"index : %ld          title :%@ ",index,title];
    }
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
