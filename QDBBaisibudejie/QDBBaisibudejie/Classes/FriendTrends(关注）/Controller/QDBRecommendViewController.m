//
//  QDBRecommendViewController.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/25.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//1重复发送网络请求问题   2.分页加载数据     3.网络慢带来的一些细节问题   4.共用tableView 带来的header  footer问题

#import "QDBRecommendViewController.h"
#import "AFNetworking.h"
#import "QDBRecommendTagModel.h"
#import "QDBCategoryCell.h"
#import "QDBUserModel.h"
#import "QDBRecommendUserCell.h"
#import <MJRefresh.h>

static NSString *categoryCell = @"category";
static NSString *userCell = @"userCell";

#define QDBSelectTagModel self.tagsArray[[self.leftView indexPathForSelectedRow].row]

@interface QDBRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@property (nonatomic,strong) NSArray *tagsArray;

//请求参数
@property (nonatomic,strong) NSMutableDictionary *params;

//管理
@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation QDBRecommendViewController

-(AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置表格
    [self setupTableView];
    //设置标题
    self.navigationItem.title = @"推荐关注";
    //设置背景颜色
    self.view.backgroundColor = GlobalBackGroundColor;
    
    //获取分类请求
    [self loadCategoryRequest];
    
}

-(void)loadCategoryRequest
{
    //转动指示器
    [SVProgressHUD show];
    //发送网络请求获取左侧类别
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //关闭指示器
        [SVProgressHUD dismiss];
//        QDBLog(@"-----%@",responseObject);
        NSArray *listArray = responseObject[@"list"];
        self.tagsArray =[QDBRecommendTagModel mj_objectArrayWithKeyValuesArray:listArray];
        //刷新数据
        [self.leftView reloadData];
        
        //默认选中第一个
        [self.leftView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        //开始刷新
        [self.rightTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"信息加载失败！"];
    }];

}

-(void)setupTableView
{
    //tableView数据源代理
    self.leftView.dataSource = self;
    self.leftView.delegate = self;
    self.rightTableView.dataSource = self;
//    self.rightTableView.delegate = self;
    self.rightTableView.rowHeight = 75;
    self.leftView.tableFooterView = [[UIView alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置顶部缩进
    self.leftView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //注册cell
    [self.leftView registerNib:[UINib nibWithNibName:@"QDBCategoryCell" bundle:nil] forCellReuseIdentifier:categoryCell];
    //注册cell
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([QDBRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userCell];
    //上拉加载更多
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.rightTableView.mj_footer.hidden = YES;
    //下拉刷新
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

}

-(void)checkTableFooterState
{
    QDBRecommendTagModel *tagModel = QDBSelectTagModel;
    //是否隐藏表尾部
     self.rightTableView.mj_footer.hidden = !(tagModel.users.count>8);
    
    //结束刷新
    if (tagModel.total == tagModel.users.count) {
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.rightTableView.mj_footer endRefreshing];
    }

}
/**
 *  加载更多数据
 */
-(void)loadMoreData
{
    QDBRecommendTagModel *tagModel = QDBSelectTagModel;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] =@(tagModel.id);
    params[@"page"] = @(++tagModel.currentpage);
    self.params = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *usersArray = [QDBUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [tagModel.users addObjectsFromArray:usersArray];
        //不是当前请求 直接返回
        if (self.params!= params)  return;
        //刷新数据
        [self.rightTableView reloadData];
        //检查表尾状态
        [self checkTableFooterState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //不是当前请求 直接返回
        if (self.params!= params)  return;
        //提示加载失败
        [SVProgressHUD showErrorWithStatus:@"加载信息失败！"];
        //结束刷新
        [self.rightTableView.mj_footer endRefreshing];
    }];

}
/**
 *  下拉加载最新数据
 */
-(void)loadNewData
{
    QDBRecommendTagModel *tagModel = QDBSelectTagModel;
    //设置初始页码为1
    tagModel.currentpage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] =@(tagModel.id);
    params[@"page"] = @(tagModel.currentpage);
    self.params = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *usersArray = [QDBUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //记录总数
        tagModel.total = [responseObject[@"total"] integerValue];
        
        //移除旧数据
        [tagModel.users removeAllObjects];
        
        //添加
        [tagModel.users addObjectsFromArray:usersArray];
        
        //不是当前请求 直接返回
        if (self.params!= params)  return;
        
        //刷新数据
        [self.rightTableView reloadData];
        
        //结束表头刷新
        [self.rightTableView.mj_header endRefreshing];
        
        //检查表尾状态
        [self checkTableFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //不是当前请求 直接返回
        if (self.params!= params)  return;
        //提示加载失败
        [SVProgressHUD showErrorWithStatus:@"加载信息失败！"];
        //结束表头刷新
        [self.rightTableView.mj_header endRefreshing];
    }];

}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //判断是否需要显示右侧尾部视图
    if (tableView == self.leftView) {
        
        return self.tagsArray.count;

    }else{
        //检测表尾状态
        [self checkTableFooterState];
        
        return [QDBSelectTagModel users].count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.leftView) {
        //创建cell
      QDBCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCell forIndexPath:indexPath];
        //传递数据模型
        cell.recommendTagModel = self.tagsArray[indexPath.row];
        return cell;
    }else{
        //创建cell
       QDBRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userCell forIndexPath:indexPath];
        //传递模型
        cell.userModel = [QDBSelectTagModel users][indexPath.row];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//        //结束刷新
    if ([self.rightTableView.mj_header isRefreshing]) {
        [self.rightTableView.mj_header endRefreshing];

    }
    if ([self.rightTableView.mj_footer isRefreshing]) {
        [self.rightTableView.mj_footer endRefreshing];

    }
    QDBRecommendTagModel *tagModel = self.tagsArray[indexPath.row];
    if (tagModel.users.count) {
        //有数据 刷新
        [self.rightTableView reloadData];
    }else{
        //赶紧刷新数据
        [self.rightTableView reloadData];
           
        //下拉刷新
        [self.rightTableView.mj_header beginRefreshing];
    }
    
}

-(void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}
@end
