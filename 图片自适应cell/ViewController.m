//
//  ViewController.m
//  ImageAdaptive
//
//  Created by 刘硕 on 2016/11/23.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "ViewController.h"
#import "MainTableViewCell.h"
#import "UIImageView+WebCache.h"
static NSString *const ReusableID = @"MAIN";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *picArr;
@property (nonatomic, strong) NSMutableDictionary *rowHeightDict;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self createUI];
    
    [self loadData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initData {
    _rowHeightDict = [[NSMutableDictionary alloc]init];
}

- (void)createUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:ReusableID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowHeightDict.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReusableID];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_picArr[indexPath.row]];
    if (!image) {
        cell.photoImageView.image = [UIImage imageNamed:@"placehold"];
    } else {
        cell.photoImageView.image = image;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_rowHeightDict[[NSNumber numberWithInteger:indexPath.row]]) {
        return [_rowHeightDict[[NSNumber numberWithInteger:indexPath.row]] floatValue];
    }
    return 200.0;
}

- (void)loadData {
    //图片数组
    _picArr = [[NSMutableArray alloc]initWithArray:@[@"http://o9kg05vzs.bkt.clouddn.com/ass_199_579_249.jpg",
                                                     @"http://o9kg05vzs.bkt.clouddn.com/ass_199_580_504.jpg",
                                                     @"http://o9kg05vzs.bkt.clouddn.com/ass_199_576_939.jpg",
                                                     @"http://o9kg05vzs.bkt.clouddn.com/ass_199_578_287.jpg",
                                                     @"http://o9kg05vzs.bkt.clouddn.com/ass_199_577_411.jpg",
                                                     @"http://o9kg05vzs.bkt.clouddn.com/ass_199_574_677.jpg",
                                                     @"http://o9kg05vzs.bkt.clouddn.com/ass_199_575_858.jpg",
                                                     @"http://o9kg05vzs.bkt.clouddn.com/ass_199_573_546.jpg",
                                                     @"http://o9kg05vzs.bkt.clouddn.com/ass_199_572_892.jpg"]];
    
    for (NSInteger i = 0; i < _picArr.count; i++) {
        //获取图片网址
        NSString *picUrl = _picArr[i];
        //根据图片网址获取缓存
        UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:picUrl];
        if (cachedImage) {//若存在 计算图片真实需要显示高度 存入字典
            float height = cachedImage.size.height * self.view.bounds.size.width / cachedImage.size.width;
            [_rowHeightDict setObject:[NSNumber numberWithFloat:height] forKey:[NSNumber numberWithInteger:i]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {//不存在缓存 使用SDWebImageDownloader下载
            [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:picUrl] options:SDWebImageDownloaderProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (finished) {
                    //对现在图片进行缓存
                    [[SDImageCache sharedImageCache] storeImage:image forKey:picUrl toDisk:YES];
                    float height = image.size.height * self.view.bounds.size.width / image.size.width;
                    [_rowHeightDict setObject:[NSNumber numberWithFloat:height] forKey:[NSNumber numberWithInteger:i]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
