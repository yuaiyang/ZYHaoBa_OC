//
//  ZYSOViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/14.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYSOViewController.h"

@interface ZYSOViewController ()<NSURLSessionDataDelegate>

@end


@implementation ZYSOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试请求数据";
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSURL *url = [NSURL URLWithString:KURLSTRING];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    [task resume];
}
#pragma mark NSURLSessionDataDelegate
/*
 // 只要访问的是HTTPS的路径就会调用
 // 该方法的作用就是处理服务器返回的证书, 需要在该方法中告诉系统是否需要安装服务器返回的证书
 // NSURLAuthenticationChallenge : 授权质问
 //+ 受保护空间
 //+ 服务器返回的证书类型
 - (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
 {
 //    xh(@"didReceiveChallenge");
 //    xh(@"%@", challenge.protectionSpace.authenticationMethod);
 
 // 1.从服务器返回的受保护空间中拿到证书的类型
 // 2.判断服务器返回的证书是否是服务器信任的
 if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
 xh(@"是服务器信任的证书");
 // 3.根据服务器返回的受保护空间创建一个证书
 //         void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *)
 //         代理方法的completionHandler block接收两个参数:
 //         第一个参数: 代表如何处理证书
 //         第二个参数: 代表需要处理哪个证书
 //创建证书
 NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
 // 4.安装证书   completionHandler(NSURLSessionAuthChallengeUseCredential , credential);
 }
 }
 */
- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    //AFNetworking中的处理方式
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    //判断服务器返回的证书是否是服务器信任的
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        /*disposition：如何处理证书
         NSURLSessionAuthChallengePerformDefaultHandling:默认方式处理
         NSURLSessionAuthChallengeUseCredential：使用指定的证书    NSURLSessionAuthChallengeCancelAuthenticationChallenge：取消请求
         */
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
    }
    //安装证书
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}
// 接收到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    xh(@"didReceiveResponse");
    completionHandler(NSURLSessionResponseAllow);
}
// 接收到服务器返回的数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    xh(@"didReceiveData");
}
// 请求完毕
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    xh(@"didCompleteWithError");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
