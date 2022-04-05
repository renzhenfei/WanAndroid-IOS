//
//  TagItemVC.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/4/1.
//

#import "TagItemVC.h"
#import "AskAnswerModel.h"
#import "TagArticleCell.h"
#import "ApiUtil.h"
#import "UITableViewEndRefresh.h"
#import "CommonRefreshHeader.h"
#import "CommonRefreshFooter.h"

@interface TagItemVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) AskAnswerModel *model;

@property(nonatomic,strong) MBProgressHUD* progress;

@property(nonatomic,assign) int currentPage;

@end

@implementation TagItemVC

static NSString * const cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableViewEndRefresh alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.showsHorizontalScrollIndicator = false;
    [self.tableView registerClass:[TagArticleCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    self.tableView.mj_header = [CommonRefreshHeader headerWithRefreshingBlock:^{
        self.currentPage = 0;
        [self initData];
    }];
    self.tableView.mj_footer = [CommonRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [self initData];
}

- (void)initData{
    self.progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%ld",API_TIXI_ARTICLE,self.cid];
    url = [url stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithFormat:@"%d",self.currentPage++]];
    [ApiUtil request:url succBlock:^(id  _Nonnull info) {
        self.model = [AskAnswerModel yy_modelWithDictionary:info];
        [self.tableView reloadData];
        [self.progress hideAnimated:YES];
    } faildBlock:^(NSInteger code, NSString * _Nonnull msg) {
        [self.progress hideAnimated:YES];
    }];
}

- (void)loadMoreData{
    NSString *url = [NSString stringWithFormat:@"%@%ld",API_TIXI_ARTICLE,self.cid];
    url = [url stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithFormat:@"%d",self.currentPage++]];
    [ApiUtil request:url succBlock:^(id  _Nonnull info) {
        [self.model.datas addObjectsFromArray: [AskAnswerModel yy_modelWithDictionary:info].datas];
        [self.tableView reloadData];
    } faildBlock:^(NSInteger code, NSString * _Nonnull msg) {
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model ? self.model.datas.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TagArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
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
