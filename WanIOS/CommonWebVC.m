//
//  CommonWebVC.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import "CommonWebVC.h"
#import <WebKit/WebKit.h>

@interface CommonWebVC ()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,strong) WKWebView *webView;

@property(nonatomic,strong) UIProgressView *progress;

@end

@implementation CommonWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 2)];
    if (@available(iOS 11.0,*)) {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 62)];
    }else{
        self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    }
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progress];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progress.progress = self.webView.estimatedProgress;
        if (self.progress.progress == 0.1) {
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progress.transform = CGAffineTransformMakeScale(1.0f, .4f);
            } completion:^(BOOL finished) {
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [self.webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.progress.hidden = NO;
//    self.progress.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.progress.hidden = YES;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    self.progress.hidden = YES;
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
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
