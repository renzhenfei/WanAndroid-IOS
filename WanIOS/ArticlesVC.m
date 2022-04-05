//
//  ArticlesVC.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/23.
//

#import "ArticlesVC.h"
#import "ApiUtil.h"
#import "TiXiModel.h"
#import "NavModel.h"
#import "TagsVC.h"
#import "TapGestureWithArgs.h"

struct ModelAndIndex {
    int modelIndex;
    int tagIndex;
};

@interface ArticlesVC ()

@property(nonatomic,strong) UISegmentedControl *segment;

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) UIScrollView *scrollView2;

@property(nonatomic,strong) NSArray<TiXiModel*>* models;//体系

@property(nonatomic,strong) NSArray<NavModel*>* models2;//导航

@property(nonatomic,strong) UILabel *test;

@property(nonatomic,strong) MBProgressHUD* progress;

@end

@implementation ArticlesVC

static NSString* cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.test = [[UILabel alloc] init];
    // Do any additional setup after loading the view.
    self.segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"体系",@"导航", nil]];
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(onSegmentSelect:) forControlEvents:UIControlEventValueChanged];
    
    //体系
    self.navigationItem.titleView = self.segment;
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    //导航
    self.scrollView2 = [[UIScrollView alloc] init];
    self.scrollView2.showsHorizontalScrollIndicator = false;
    self.scrollView2.showsVerticalScrollIndicator = false;
    [self.view addSubview:self.scrollView2];
    [self.scrollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    self.scrollView2.hidden = YES;
    
    [self initData];
}

- (void)onSegmentSelect:(UISegmentedControl *)segmentControl{
    if (segmentControl.selectedSegmentIndex == 0) {
        [self initData];
        self.scrollView.hidden = false;
        self.scrollView2.hidden = true;
    }else if (segmentControl.selectedSegmentIndex == 1){
        [self initData2];
        self.scrollView.hidden = true;
        self.scrollView2.hidden = false;
    }
}

- (void)initData{
    if (self.models) {
        return;
    }
    self.progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApiUtil request:API_TIXI succBlock:^(id  _Nonnull info) {
        self.models = [NSArray yy_modelArrayWithClass:[TiXiModel class] json:info];
        [self addTags];
        } faildBlock:^(NSInteger code, NSString * _Nonnull msg) {
            NSLog(@"%@",msg);
            [self.progress hideAnimated:YES];
        }];
}

- (void)initData2{
    if (self.models2) {
        return;
    }
    self.progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ApiUtil request:API_NAV succBlock:^(id  _Nonnull info) {
        self.models2 = [NSArray yy_modelArrayWithClass:[NavModel class] json:info];
        [self addTags2];
        } faildBlock:^(NSInteger code, NSString * _Nonnull msg) {
            NSLog(@"%@",msg);
            [self.progress hideAnimated:YES];
        }];
}
     
- (void)addTags{
    int top = 10;
    for (int j = 0; j < self.models.count; j++) {
        TiXiModel* m = self.models[j];
        if (m.children.count <= 0) {
            continue;
        }
        CGSize size = [self sizeWithText:m.name];
        UILabel *caogory = [[UILabel alloc] initWithFrame:CGRectMake(0, top, size.width, size.height)];
        top += size.height;
        //标题和内容之间的距离
        top += 6;
        caogory.text = m.name;
        [self.scrollView addSubview:caogory];
        int left = 0;
        for (int i = 0; i < m.children.count; i++) {
            TiXiItemModel *mm = m.children[i];
            size = [self sizeWithText:mm.name];
            if (left + size.width + 10 > self.scrollView.bounds.size.width) {
                //换行
                top += size.height;
                //上下的间距
                top += 6;
                //item的上下内边距
                top += 6;
                left = 0;
            }
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(left, top, size.width + 10, size.height + 6)];
            name.userInteractionEnabled = YES;
            TapGestureWithArgs *gesture = [[TapGestureWithArgs alloc] initWithTarget:self action:@selector(onTagClick:)];
            gesture.arg1 = j;
            gesture.arg2 = i;
            [name addGestureRecognizer:gesture];
            name.textAlignment = NSTextAlignmentCenter;
            name.backgroundColor = UIColor.grayColor;
            name.textColor = UIColor.whiteColor;
            name.layer.cornerRadius = 5;
            name.layer.masksToBounds = true;
            name.text = mm.name;
            [self.scrollView addSubview:name];
            left += size.width;
            //左右内边距
            left += 10;
            //item之间的间隙
            left += 6;
        }
        top += size.height;
        top += 16;
    }
    self.scrollView.contentSize = CGSizeMake(0, top);
    [self.progress hideAnimated:YES];
}

- (void)addTags2{
    int top = 10;
    for (int j=0; j < self.models2.count; j++) {
        NavModel* m = self.models2[j];
        if (m.articles.count <= 0) {
            continue;
        }
        CGSize size = [self sizeWithText:m.name];
        UILabel *caogory = [[UILabel alloc] initWithFrame:CGRectMake(0, top, size.width, size.height)];
        top += size.height;
        //标题和内容之间的距离
        top += 6;
        caogory.text = m.name;
        [self.scrollView2 addSubview:caogory];
        int left = 0;
        for (int i = 0; i < m.articles.count; i++) {
            NavItemModel *mm = m.articles[i];
            size = [self sizeWithText:mm.title];
            if (left + size.width + 10 > self.scrollView2.bounds.size.width) {
                //换行
                top += size.height;
                //上下的间距
                top += 6;
                //item的上下内边距
                top += 6;
                left = 0;
            }
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(left, top, size.width + 10, size.height + 6)];
            TapGestureWithArgs *gesture = [[TapGestureWithArgs alloc] initWithTarget:self action:@selector(onTagClick2:)];
            name.userInteractionEnabled = YES;
            gesture.arg1 = j;
            gesture.arg2 = i;
            [name addGestureRecognizer:gesture];
            name.textAlignment = NSTextAlignmentCenter;
            name.backgroundColor = UIColor.grayColor;
            name.textColor = UIColor.whiteColor;
            name.layer.cornerRadius = 5;
            name.layer.masksToBounds = true;
            name.text = mm.title;
            [self.scrollView2 addSubview:name];
            left += size.width;
            //左右内边距
            left += 10;
            //item之间的间隙
            left += 6;
        }
        top += size.height;
        top += 16;
    }
    self.scrollView2.contentSize = CGSizeMake(0, top);
    [self.progress hideAnimated:YES];
}

//体系
- (void)onTagClick:(UIGestureRecognizer *)gesture{
    TapGestureWithArgs *ges = (TapGestureWithArgs *)gesture;
    TagsVC *tagVC = [[TagsVC alloc] init];
    tagVC.currentIndex = ges.arg2;
    tagVC.tixiModel = self.models[ges.arg1];
    tagVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tagVC animated:YES];
}

//导航
- (void)onTagClick2:(UIGestureRecognizer *)gesture{
    TapGestureWithArgs *ges = (TapGestureWithArgs *)gesture;
    NavModel *navModel = self.models2[ges.arg1];
    CommonWebVC *webVC = [[CommonWebVC alloc] init];
    webVC.url = navModel.articles[ges.arg2].link;
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (CGSize)sizeWithText:(NSString* )text{
    NSDictionary *attrs = @{NSFontAttributeName:self.test.font};
    return [text sizeWithAttributes:attrs];
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
