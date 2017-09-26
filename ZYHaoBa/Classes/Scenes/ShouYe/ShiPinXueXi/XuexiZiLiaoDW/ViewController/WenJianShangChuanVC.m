//
//  WenJianShangChuanVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/24.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "WenJianShangChuanVC.h"

#define HMEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface WenJianShangChuanVC ()

@end

@implementation WenJianShangChuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"暂时参考";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self upLoadData];
    [self upLoadFile];

}

/********************上传数据**********************/
#pragma mark - 上传数据
- (void)upLoadData {
    // 1.创建请求
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.200:8080/MJServer/order"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 2.设置请求头
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 3.设置请求体
    NSDictionary *json = @{
                           @"order_id" : @"123",
                           @"user_id" : @"789",
                           @"shop" : @"Toll"
                           };
    
    //    NSData --> NSDictionary
    // NSDictionary --> NSData
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = data;
    
    // 4.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        xh(@"%d", data.length);
    }];
}

/********************上传文件**********************/
#pragma mark - 上传文件
- (void)upLoadFile {
    // Socket 实现断点上传
    
    //apache-tomcat-6.0.41/conf/web.xml 查找 文件的 mimeType
    //    UIImage *image = [UIImage imageNamed:@"test"];
    //    NSData *filedata = UIImagePNGRepresentation(image);
    //    [self upload:@"file" filename:@"test.png" mimeType:@"image/png" data:filedata parmas:@{@"username" : @"123"}];
    
    // 给本地文件发送一个请求
    NSURL *fileurl = [[NSBundle mainBundle] URLForResource:@"itcast.txt" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileurl];
    NSURLResponse *repsonse = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&repsonse error:nil];
    
    // 得到mimeType
    xh(@"%@", repsonse.MIMEType);
    [self upload:@"file" filename:@"itcast.txt" mimeType:repsonse.MIMEType data:data parmas:@{
                                                                                              @"username" : @"999",
                                                                                              @"type" : @"XML"}];
}

- (void)upload:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params
{
    // 文件上传
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.200:8080/MJServer/upload"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 设置请求体
    NSMutableData *body = [NSMutableData data];
    
    /***************文件参数***************/
    // 参数开始的标志
    [body appendData:HMEncode(@"--heima\r\n")];
    // name : 指定参数名(必须跟服务器端保持一致)
    // filename : 文件名
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename];
    [body appendData:HMEncode(disposition)];
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType];
    [body appendData:HMEncode(type)];
    
    [body appendData:HMEncode(@"\r\n")];
    [body appendData:data];
    [body appendData:HMEncode(@"\r\n")];
    
    /***************普通参数***************/
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 参数开始的标志
        [body appendData:HMEncode(@"--heima\r\n")];
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
        [body appendData:HMEncode(disposition)];
        
        [body appendData:HMEncode(@"\r\n")];
        [body appendData:HMEncode(obj)];
        [body appendData:HMEncode(@"\r\n")];
    }];
    
    /***************参数结束***************/
    // heima--\r\n
    [body appendData:HMEncode(@"--heima--\r\n")];
    request.HTTPBody = body;
    
    // 设置请求头
    // 请求体的长度
    [request setValue:[NSString stringWithFormat:@"%zd", body.length] forHTTPHeaderField:@"Content-Length"];
    // 声明这个POST请求是个文件上传
    [request setValue:@"multipart/form-data; boundary=heima" forHTTPHeaderField:@"Content-Type"];
    
    // 发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            xh(@"%@", dict);
        } else {
            xh(@"上传失败");
        }
    }];
}
@end
