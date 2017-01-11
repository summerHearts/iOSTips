//
//  BaseViewController.m
//  iOSTips
//
//  Created by Kenvin on 17/1/10.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate= self;
    }
    return _webView;
}
@end
