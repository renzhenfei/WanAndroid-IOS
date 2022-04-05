//
//  AppDelegate.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/23.
//

#import "AppDelegate.h"
#import "CustomTabBarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame: UIScreen.mainScreen.bounds];
    CustomTabBarVC *tab = [[CustomTabBarVC alloc] init];
    UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:tab];
    root.navigationBar.hidden = true;
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
