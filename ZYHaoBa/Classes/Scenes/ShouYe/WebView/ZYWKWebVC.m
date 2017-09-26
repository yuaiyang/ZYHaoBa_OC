//
//  ZYWKWebVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/12/27.
//  Copyright © 2016年 正羽. All rights reserved.
//  本文件所在文件夹其他文件，如果不使用IMYWebView，那么其他文件均没用

#import "ZYWKWebVC.h"
#import "IMYWebView.h"

#import <WebKit/WebKit.h>
@interface ZYWKWebVC ()
@property(strong,nonatomic)IMYWebView* webView;
@end

@implementation ZYWKWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // IMYWebView
//    [self createIMYWebView];
    // WKWebView
    [self createWKWebView];
    // UIWebView
//    [self createUIWebView];
}

#pragma mark -使用IMYWebView的框架
-(void)createIMYWebView {
     // 需要导入#import "IMYWebView.h"头文件其他不用 这个貌似有些问题 有进度条，演示貌似没看见
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化方法可以设置是后使用WKWebView
    self.webView = [[IMYWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    
    if(_webView.usingUIWebView)
    {
        self.title = @"ClickRefresh-UIWebView";
    }
    else
    {
        self.title = @"ClickRefresh-WKWebView";
    }
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:KWEBVIEWURL]]];
}

#pragma mark -自建WKwebView加载
- (void)createWKWebView {
    // 需要导入WebKit包和导入头文件
    WKWebView* wkwebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [wkwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:KTTTTT]]];
    [self.view addSubview:wkwebView];
}

#pragma mark -自建UIwebView加载
- (void)createUIWebView {
    // 不需要导入任何东西
    UIWebView* uiwebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:uiwebView];
    uiwebView.backgroundColor = [UIColor clearColor];
    uiwebView.opaque = NO;
    [uiwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:KWEBVIEWURL]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    self.view = nil;
}

@end
