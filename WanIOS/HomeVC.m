//
//  HomeVC.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/23.
//

#import "HomeVC.h"
#import "ApiUtil.h"
#import "model/BannerModel.h"
#import <SDCycleScrollView.h>
#import "cell/HomeCell.h"
#import "model/ArticleModel.h"
#import "UITableViewEndRefresh.h"
#import "CommonRefreshHeader.h"
#import "CommonRefreshFooter.h"

@interface HomeVC ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) SDCycleScrollView *bannerView;

@property(nonatomic,strong) NSArray<BannerModel*>* models;

@property(nonatomic,strong) ArticleModel *article;

@property(nonatomic,strong) NSArray<ArticleDetail*>* topData;

@property(nonatomic,assign) int currentPage;

@end

@implementation HomeVC

static NSString* const cellId = @"Cell";

- (void)setUpViews{
    
    self.tableView = [[UITableViewEndRefresh alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[HomeCell class] forCellReuseIdentifier:cellId];
    self.tableView.separatorColor = RGB_COLOR(@"#cccccc", 1);
    self.tableView.mj_header = [CommonRefreshHeader headerWithRefreshingBlock:^{
        self.currentPage = 0;
        [self initData];
    }];
    self.tableView.mj_footer = [CommonRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.bannerView = [[SDCycleScrollView alloc] init];
    self.bannerView.delegate = self;
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.bannerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.bannerView.autoScrollTimeInterval = 3.0;
    self.tableView.tableHeaderView = self.bannerView;
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    self.bannerView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 180);
}

- (void)initData{
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApiUtil request:API_HOME andMethod:GET succBlock:^(id  _Nonnull info) {
        self.models = [NSArray yy_modelArrayWithClass:[BannerModel class] json:info];
        [progress hideAnimated:YES];
        NSMutableArray<NSString*>* bannerUrls = [[NSMutableArray alloc] init];
        for (BannerModel* model in self.models) {
            [bannerUrls addObject:model.imagePath];
        }
        self.bannerView.imageURLStringsGroup = bannerUrls;
    } faildBlock:^(NSInteger code, NSString * _Nonnull msg) {
        [progress hideAnimated:YES];
    }];
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [API_HOME_ARTICLE stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithFormat:@"%d",self.currentPage++]];
    [ApiUtil request:url succBlock:^(id  _Nonnull info) {
        [progress hideAnimated:YES];
        self.article = [ArticleModel yy_modelWithDictionary:info];
        [self.tableView reloadData];
    } faildBlock:^(NSInteger code, NSString * _Nonnull msg) {
        [progress hideAnimated:YES];
    }];
    [ApiUtil request:API_HOME_TOP succBlock:^(id  _Nonnull info) {
        self.topData = [NSArray yy_modelArrayWithClass:[ArticleDetail class] json:info];
        for (ArticleDetail* article in self.topData) {
            article.isTop = true;
        }
        [self.tableView reloadData];
    } faildBlock:^(NSInteger code, NSString * _Nonnull msg) {
        
    }];
}

- (void)loadMoreData{
    NSString *url = [API_HOME_ARTICLE stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithFormat:@"%d",self.currentPage++]];
    [ApiUtil request:url succBlock:^(id  _Nonnull info) {
        ArticleModel *newModel = [ArticleModel yy_modelWithDictionary:info];
        [self.article.datas addObjectsFromArray:newModel.datas];
        [self.tableView reloadData];
    } faildBlock:^(NSInteger code, NSString * _Nonnull msg) {
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpViews];
    
    [self initData];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Banner

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    CommonWebVC *webVC = [[CommonWebVC alloc] init];
    webVC.url = self.models[index].url;
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger articleCount = self.article ? self.article.datas.count : 0;
    NSInteger topDataCount = self.topData ? self.topData.count : 0;
    return articleCount + topDataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (self.topData) {
        if (indexPath.row < self.topData.count) {
            [cell setData:self.topData[indexPath.row]];
        }else{
            [cell setData:self.article.datas[indexPath.row - self.topData.count]];
        }
    }else{
        [cell setData:self.article.datas[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommonWebVC *webVC = [[CommonWebVC alloc] init];
    if (self.topData) {
        if (indexPath.row < self.topData.count) {
            webVC.url = self.topData[indexPath.row].link;
        }else{
            webVC.url = self.article.datas[indexPath.row - self.topData.count].link;
        }
    }else{
        webVC.url = self.article.datas[indexPath.row].link;
    }
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end
