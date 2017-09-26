//
//  GetCacheVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/25.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "GetCacheVC.h"

@interface GetCacheVC ()

@end

@implementation GetCacheVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.创建请求
    NSURL *url = [NSURL URLWithString:KWEBVIEWURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 2.设置缓存策略(有缓存就用缓存，没有缓存就重新请求)
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    // 3.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            xh(@"%@", data);
        }
    }];
}

/**
 // 定期处理缓存
 //    if (缓存没有达到7天) {
 //        request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
 //    }
 // 获得全局的缓存对象
 NSURLCache *cache = [NSURLCache sharedURLCache];
 //    if (缓存达到7天) {
 //        [cache removeCachedResponseForRequest:request];
 //    }
 
 // lastCacheDate = 2014-06-30 11:04:30
 
 NSCachedURLResponse *response = [cache cachedResponseForRequest:request];
 if (response) {
 xh(@"---这个请求已经存在缓存");
 } else {
 xh(@"---这个请求没有缓存");
 }
 */


@end
