//
//  TagsVC.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/30.
//

#import "TagsVC.h"
#import "ApiUtil.h"
#import "AskAnswerModel.h"
#import "TagArticleCell.h"
#import "TabBarView.h"
#import "TagItemVC.h"

#define TAB_HEIGHT 30

@interface TagsVC ()<OnTagListener,UIScrollViewDelegate>

@property(nonatomic,strong) TabBarView *tabBarView;

@property(nonatomic,strong) UIScrollView *contentScrollView;

@property(nonatomic,strong) NSMutableDictionary *articles;

@property(nonatomic,strong) NSMutableArray *tableViews;

@property(nonatomic,strong) AskAnswerModel *currentModel;

@end

@implementation TagsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.articles = [[NSMutableDictionary alloc] init];
    self.tableViews = [[NSMutableArray alloc] init];
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, TAB_HEIGHT + 10)];
    self.tabBarView = [[TabBarView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, TAB_HEIGHT)];
    self.tabBarView.listener = self;
    [container addSubview:self.tabBarView];
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TAB_HEIGHT + 10, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_HEIGHT - 10 - 100)];
    [self.contentScrollView setPagingEnabled:YES];
    [self.view addSubview:container];
    [self.view addSubview:self.contentScrollView];
    
    [self initTabView];
}

- (void)initTabView{
    if (!self.tixiModel) {
        return;
    }
    NSMutableArray *tags = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.tixiModel.children.count; i++) {
        TiXiItemModel *item = self.tixiModel.children[i];
        [tags addObject:item.name];
        TagItemVC *vc = [[TagItemVC alloc] init];
        [self addChildViewController:vc];
        vc.cid = item.id_;
        vc.view.frame = CGRectMake(i * SCREEN_WIDTH, 0, self.contentScrollView.frame.size.width, self.contentScrollView.frame.size.height);
        NSLog(@"contentSizeHeight = %f screenHeight = %f",self.contentScrollView.frame.size.height,SCREEN_HEIGHT);
        [self.contentScrollView addSubview:vc.view];
        [vc willMoveToParentViewController:self];
    }
    [self.tabBarView tags:tags index:self.currentIndex];
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width * self.tixiModel.children.count, 0);
    self.contentScrollView.delegate = self;
    [self loadArticleByModel:self.currentIndex];
}

- (void)loadArticleByModel:(NSInteger)currentIndex{
    self.currentIndex = currentIndex;
    [self.contentScrollView setContentOffset:CGPointMake(currentIndex * self.contentScrollView.frame.size.width, 0) animated:YES];
}

- (void)onTagSelected:(NSInteger)index {
    [self loadArticleByModel:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int offset = (int)scrollView.contentOffset.x % (int)scrollView.frame.size.width;
    if (!offset) {
        int pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
//        [self loadArticleByModel:pageIndex];
        [self.tabBarView scoll2Index:pageIndex];
    }
}

@end
