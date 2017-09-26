//
//  ZYErWebView.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYErWebView.h"

@interface ZYErWebView()<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView * webView;

@end

@implementation ZYErWebView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _webView.delegate = self;
        [self addSubview:_webView];
        // 清空缓存
        [self clearWebViewCash];
    }
    return self;
}

-(void)setUrlString:(NSString *)urlString {
// 请求H5数据 其他请求同理
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

#pragma mark- 定义函数，进行对应的缓存清空操作处理
- (void)clearWebViewCash {
    //定义变量，进行对应cookie中储存的对应cookie对象的保存处理，进行对应的清空缓存操作处理
    NSHTTPCookie *currentCookie;
    
    //定义变量，获取对应的cookie存储器
    NSHTTPCookieStorage *currentCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    //调用循环，清除对应的cookie存储器的cookie
    for(currentCookie in [currentCookieStorage cookies]) {
        [currentCookieStorage deleteCookie:currentCookie];
    }
    
    //清除对应的url缓存操作
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
