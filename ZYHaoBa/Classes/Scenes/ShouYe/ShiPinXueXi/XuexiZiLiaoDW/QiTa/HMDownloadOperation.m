//
//  HMDownloadOperation.m
//  04-自定义Operation
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMDownloadOperation.h"

@implementation HMDownloadOperation

/**
 *  在main方法中实现具体操作
 */
- (void)main
{
    @autoreleasepool {
        if (self.isCancelled) return;
        
        NSURL *downloadUrl = [NSURL URLWithString:self.url];
        NSData *data = [NSData dataWithContentsOfURL:downloadUrl]; // 这行会比较耗时
        
        if (self.isCancelled) return;
        
        UIImage *image = [UIImage imageWithData:data];
        
        if (self.isCancelled) return;
        
        if ([self.delegate respondsToSelector:@selector(downloadOperation:didFinishDownload:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{ // 回到主线程, 传递图片数据给代理对象
                [self.delegate downloadOperation:self didFinishDownload:image];
            });
        }
    }
}

@end
