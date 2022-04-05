//
//  CodeVC.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/23.
//

#import "CodeVC.h"
#import "ApiUtil.h"
#import "AskAnswerModel.h"
#import "AskAnswerCell.h"

#import "UITableViewEndRefresh.h"
#import "CommonRefreshHeader.h"
#import "CommonRefreshFooter.h"

@interface CodeVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) AskAnswerModel *model;

@property(nonatomic,assign) int currentPage;

@end

@implementation CodeVC

static NSString* const cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableViewEndRefresh alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = false;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[AskAnswerCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.mj_header = [CommonRefreshHeader headerWithRefreshingBlock:^{
        self.currentPage = 0;
        [self initData];
    }];
    self.tableView.mj_footer = [CommonRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    [self initData];
}

- (void)loadMoreData{
    NSString *url = [API_ASK_ANSWER stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithFormat:@"%d",self.currentPage++]];
    [ApiUtil request:url succBlock:^(id  _Nonnull info) {
        [self.model.datas addObjectsFromArray: [AskAnswerModel yy_modelWithDictionary:info].datas];
        [self.tableView reloadData];
    } faildBlock:^(NSInteger code, NSString * _Nonnull msg) {
    }];
}

- (void)initData{
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [API_ASK_ANSWER stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithFormat:@"%d",self.currentPage++]];
    [ApiUtil request:url succBlock:^(id  _Nonnull info) {
        self.model = [AskAnswerModel yy_modelWithDictionary:info];
        [self.tableView reloadData];
        [progress hideAnimated:YES];
    } faildBlock:^(NSInteger code, NSString * _Nonnull msg) {
        [progress hideAnimated:YES];
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model ? self.model.datas.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AskAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [cell setData:self.model.datas[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        CommonWebVC *webVC = [[CommonWebVC alloc] init];
        webVC.url = self.model.datas[indexPath.row].link;
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
}

@end
