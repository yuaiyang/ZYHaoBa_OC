//
//  HMDownloadOperation.h
//  04-自定义Operation
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 heima. All rights reserved.
//  一个下载操作就交给一个HMDownloadOperation对象

#import <Foundation/Foundation.h>

@class HMDownloadOperation;

@protocol HMDownloadOperationDelegate <NSObject>
@optional
- (void)downloadOperation:(HMDownloadOperation *)operation didFinishDownload:(UIImage *)image;
@end

@interface HMDownloadOperation : NSOperation
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<HMDownloadOperationDelegate> delegate;
@end
