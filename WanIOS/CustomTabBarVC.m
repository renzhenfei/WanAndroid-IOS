//
//  CustomTabBarVC.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/23.
//

#import "CustomTabBarVC.h"
#import "HomeVC.h"
#import "ArticlesVC.h"
#import "CodeVC.h"
#import "MineVC.h"

@interface CustomTabBarVC ()

@end

@implementation CustomTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewControllers];
}

- (void)addChildViewControllers {
    [self addTabItem:[[HomeVC alloc] init] andTitle:TAB_HOME andNormalIcon:@"ic_bottom_bar_home" andSelectedIcon:nil tag:100];
    [self addTabItem:[[ArticlesVC alloc] init] andTitle:TAB_ARTICLE andNormalIcon:@"ic_bottom_bar_navi" andSelectedIcon:nil tag:101];
    [self addTabItem:[[CodeVC alloc] init] andTitle:TAB_CODE andNormalIcon:@"ic_bottom_bar_ques" andSelectedIcon:nil tag:102];
//    [self addTabItem:[[MineVC alloc] init] andTitle:TAB_MINE andNormalIcon:nil andSelectedIcon:nil tag:103];
}

- (void)addTabItem:(BaseViewController *)childVC andTitle:(NSString*)title andNormalIcon:(NSString*)normalIconName andSelectedIcon:(NSString*)selectedIconName tag:(NSInteger)tag {
    childVC.tabBarItem.image = [UIImage imageNamed:normalIconName];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedIconName];
    childVC.title = title;
    childVC.tabBarItem.tag = tag;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nc];
}

@end
