//
//  QDBRecommendTagsVC.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/28.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBRecommendTagsVC.h"
#import <AFNetworking.h>
#import "QDBTagModel.h"
#import "QDBRecommedTagCell.h"

static NSString *const tagReuseId = @"tagId";

@interface QDBRecommendTagsVC ()
//数据源
@property (nonatomic,strong) NSArray *tags;
@end

@implementation QDBRecommendTagsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.navigationItem.title = @"推荐标签";
    //设置背景色
    self.tableView.backgroundColor = GlobalBackGroundColor;
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QDBRecommedTagCell class]) bundle:nil] forCellReuseIdentifier:tagReuseId];
    //发送网络请求
    [self loadRecommendTags];
}

- (void)loadRecommendTags
{
    [SVProgressHUD show];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组-》模型数组
        self.tags = [QDBTagModel mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新表格
        [self.tableView reloadData];
        //关闭指示器
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
   
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QDBRecommedTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagReuseId forIndexPath:indexPath];
    
    cell.tagModel = self.tags[indexPath.row];
    
    return cell;
}
@end
