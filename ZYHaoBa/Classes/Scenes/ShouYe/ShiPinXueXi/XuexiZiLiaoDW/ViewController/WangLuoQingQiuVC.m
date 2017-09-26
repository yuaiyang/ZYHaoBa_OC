//
//  WangLuoQingQiuVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/13.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "WangLuoQingQiuVC.h"

@interface WangLuoQingQiuVC ()<NSURLConnectionDataDelegate>

// 图形验证码
@property (weak, nonatomic) IBOutlet UIImageView *imagView;
// 验证码 返回信息
@property (weak, nonatomic) IBOutlet UITextField *imagCodeF;
// 获取手机验证码
- (IBAction)postPhoneCode:(UIButton *)sender;


// 用来存放服务器返回的所有数据（代理请求会使用到）
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation WangLuoQingQiuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 请求图形验证码
    [self getImgData];
    
}

#pragma mark 获取图形验证码Get请求（三种方式）
- (void)getImgData {
    [self showHudInView:self.view hint:nil];
    // 转码
    NSString *urlStr = [ZY_NEWPHONENUMSENDIMGCODE stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // URL里面不能包含中文
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2.2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url]; // 默认就是GET请求
    request.timeoutInterval = 5; // 设置请求超时
    
//    [self getRequestGetImgCode1:request];
    [self getRequestGetImgCode2:request];
//    [self getRequestGetImgCode3:request];
}

// 同步 会阻塞主线程
- (void)getRequestGetImgCode1:(NSURLRequest *)request {
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    self.imagView.image = [UIImage imageWithData:data];
    [self hideHud];
}
// 异步
- (void)getRequestGetImgCode2:(NSURLRequest *)request {
    // 设置队列（返回主队列）
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {  // 当请求结束的时候调用 (拿到了服务器的数据, 请求失败)
        
        // 隐藏HUD (刷新UI界面, 一定要放在主线程, 不能放在子线程)
        [self hideHud];
        
        /**
         解析data :
         */
        if (data) { // 请求成功
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            NSString *error = dict[@"error"];
//            if (error) { // 请求失败
//                [self showHint:error];
//            } else { // 请求成功
//                NSString *success =  dict[@"success"];
//                [self showHint:success];
//            }
            // 以上为一般请求数据解析格式 本次特殊直接加载图片
            self.imagView.image = [UIImage imageWithData:data];
            
        } else { // 请求失败
            [self hideHud];
            [self showHint:@"网络繁忙, 请稍后再试"];
        }
    }];

}

// 异步-代理
- (void)getRequestGetImgCode3:(NSURLRequest *)request {
    //    [NSURLConnection connectionWithRequest:request delegate:self];
    //    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //    [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    
    NSURLConnection *conn4 = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [conn4 start];
}

// 代理方法
/**
 *  请求错误(失败)的时候调用(请求超时\断网\没有网, 一般指客户端错误)
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    xh(@"connection:didFailWithError:");
    [self hideHud];
    
    [self showHint:@"网络繁忙, 请稍后再试"];
}

/**
 *  当接受到服务器的响应(连通了服务器)就会调用
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    xh(@"connection:didReceiveResponse:");
    
    // 初始化数据
    self.responseData = [NSMutableData data];
}


/**
 *  当接受到服务器的数据就会调用(可能会被调用多次, 每次调用只会传递部分数据)
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    xh(@"connection:didReceiveData:");
    
    // 拼接(收集)数据
    [self.responseData appendData:data];
}

/**
 *  当服务器的数据接受完毕后就会调用
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    xh(@"connectionDidFinishLoading:");
    
    // 隐藏HUD
    [self hideHud];
    
    self.imagView.image = [UIImage imageWithData:self.responseData];
}

#pragma mark 获取手机验证码POST请求（只是请求方式不一样，其他和get请求一样）
- (void)postRequestGetphoneCode {
    // 2.发送请求给服务器(带上图形验证码)
    // POST请求:请求体
    
    // 2.1.设置请求路径
    NSURL *url = [NSURL URLWithString:ZY_NEWPHONENUMSENDCODE];
    
    // 2.2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url]; // 默认就是GET请求
    request.timeoutInterval = 5; // 设置请求超时
    request.HTTPMethod = @"POST"; // 设置为POST请求
    
    // 通过请求头告诉服务器客户端的类型
    [request setValue:@"zhnegyu-iOS" forHTTPHeaderField:@"User-Agent"];
   
    /**
     Host: 192.168.1.200:8080
     User-Agent: iPhone Simulator; iPhone OS 7.1; en_US
     Accept: text/html
     Accept-Language: zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3
     Accept-Encoding: gzip, deflate
    */

    
    // 设置请求体
    NSString *param = [NSString stringWithFormat:@"mobiletelno=%@&code=%@", @"15034322235",[self.imagCodeF.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    
    // 2.3.发送请求
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {  // 当请求结束的时候调用 (拿到了服务器的数据, 请求失败)
        // 隐藏HUD (刷新UI界面, 一定要放在主线程, 不能放在子线程)
        [self hideHud];
        /**
         解析data :
         */
        if (data) { // 请求成功
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSString *msg = dict[@"msg"];
            [self showHint:msg];
        } else { // 请求失败
            [self showHint:@"网络繁忙, 请稍后再试"];
        }
    }];
}

#pragma mark 注意事项 URL中不能包含汉子，所以中文必须进行转码后请求 一般get请求会涉及
- (void)zhuanMa {
    // eg：
    // 2.1.设置请求路径
    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.1.200:8080/MJServer/login?username=%@&pwd=%@", @"正羽", @"哈哈"];
    
    // 转码
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // URL里面不能包含中文
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 最后一个url才是可以使用的
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 点击获取手机验证码
- (IBAction)postPhoneCode:(UIButton *)sender {
    [self postRequestGetphoneCode];
}
@end
