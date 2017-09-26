//
//  WebViewShiYongVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/25.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "WebViewShiYongVC.h"

@interface WebViewShiYongVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)clearAd;
- (IBAction)getHtmlTitle;
@end

@implementation WebViewShiYongVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"关于.txt" withExtension:nil];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"deal.html" withExtension:nil];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test.html" withExtension:nil];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 设置需要检测的数据类型
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webView.delegate = self;
    
    /*
     self.webView.scalesPageToFit 是一个自动布局属性
     */
//    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:request];
}

- (IBAction)clearAd {
    // 清除广告
    // 执行JavaScript代码, 把header和footer给删掉
    // document.getElementsByTagName('header')[0].remove();
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('header')[0].remove();"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('footer')[0].remove();"];
    
    // HTML5 : 跨平台(网页) JavaScript
    // PhoneGap
    // Sencha-touch
    // jQuery-Mobile
}

- (IBAction)getHtmlTitle {
    NSString *titl = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title;"];
    self.title = titl;
}

- (void)openMyAlbum
{
    // 打开相册
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)openMyCamera
{
    // 打开照相
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate
/**
 当webView发送一个请求之前都会调用这个方法, 返回YES, 可以加载这个请求, 返回NO, 代表禁止加载这个请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    // 找到url中的 range 范围的长度 部位0
    /*
     ios:// 是自己额外制定的一份协议 区分其他协议 比如和http：//协议分开
     */
    NSRange range = [url rangeOfString:@"ios://"];
    if (range.length != 0) {
        // 截取方法名
        NSString *method = [url substringFromIndex:range.location + range.length];
        // 将方法名转为SEL类型
        SEL selector = NSSelectorFromString(method);
        [self performSelector:selector withObject:nil];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/********************基本使用************************/
//添加SearchBar并遵循代理后可以调用
#pragma mark - UISearchBarDelegate
/**
 *  搜索框的文字改变了
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    xh(@"textDidChange----%@", searchText);
}

/**
 *  点击了"搜索"按钮
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 开始加载网页
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", searchBar.text]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
/**
 *  UIWebView开始加载资源的时候调用(开始发送请求)
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    xh(@"webViewDidStartLoad---");
}

/**
 *  UIWebView加载完毕的时候调用(请求完毕)
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    xh(@"webViewDidFinishLoad---");
    
#warning - 设置iOS7以后，webView加载会有一小段空白处理
//    webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    或者在控制器设置 adjust scroll View insets 勾取消
    
    // 控制器前进和回退按钮的可用性
//    self.backItem.enabled = [webView canGoBack];
//    self.forwardItem.enabled = [webView canGoForward];
    
    // 获得当前网页的标题
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title;"];
}

/**
 *  UIWebView加载失败的时候调用(请求失败)
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    xh(@"didFailLoadWithError---");
}

//如果要实现网页自带前进 后退
/*
 *[self.webView goBack];
 *[self.webView goForward];
 */

@end
