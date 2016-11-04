
//
//  QDBWordController.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/31.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "QDBTopic.h"
#import "QDBTopicCell.h"

static NSString *topicCellId = @"topic";

@interface QDBTopicViewController ()
//数据源
@property (nonatomic,strong) NSMutableArray *wordArray;
//当前页
@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,copy) NSString *maxTime;

@property (nonatomic,strong) NSDictionary *params;
@end

@implementation QDBTopicViewController

-(NSMutableArray *)wordArray
{
    if (_wordArray == nil) {
        _wordArray = [NSMutableArray array];
    }
    return _wordArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置刷新控件
    [self setupRefresh];
    
    [self setupTableView];
    
}

-(void)setupTableView
{
    CGFloat topInset = kTopMenuH + kNavH;
    CGFloat bottomInset = self.tabBarController.tabBar.height;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(topInset, 0, bottomInset, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QDBTopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellId];
}

-(void)setupRefresh
{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    //上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

-(void)loadNewData
{
    //结束刷新
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(_topicType);
    params[@"page"] =@(self.currentPage);
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(self.params!=params) return;
        //打印日志
        QDBLog(@"---------%@",responseObject[@"list"]);
        //字典数组 --模型数组
        self.wordArray = [QDBTopic mj_objectArrayWithKeyValuesArray: responseObject[@"list"]];
        self.maxTime = responseObject[@"info"][@"maxtime"];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        self.currentPage = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(self.params!=params) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!"];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        self.currentPage = 0;
    }];
    
}

-(void)loadMoreData
{
    //结束刷新
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    self.currentPage ++ ;
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(_topicType);
    params[@"page"] = @(self.currentPage);
    params[@"maxtime"] = self.maxTime;
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(self.params!=params) return;
        //追加数据
        NSArray * wordArray = [QDBTopic mj_objectArrayWithKeyValuesArray: responseObject[@"list"]];
        [self.wordArray addObjectsFromArray:wordArray];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(self.params!=params) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!"];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        //恢复页码
        self.currentPage -- ;
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.wordArray.count==0);
    return self.wordArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QDBTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellId forIndexPath:indexPath];
    
    //传递数据模型
    cell.topic = self.wordArray[indexPath.row];
    
    return cell;
}

#pragma mark - delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QDBTopic *topic = self.wordArray[indexPath.row];
    
    return topic.rowHeight;
}
@end
