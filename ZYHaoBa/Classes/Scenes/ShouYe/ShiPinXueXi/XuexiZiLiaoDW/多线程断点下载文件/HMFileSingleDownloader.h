//
//  HMFileSingleDownloader.h
//  08-多线程断点下载
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMFileDownloader.h"

@interface HMFileSingleDownloader : HMFileDownloader
/**
 *  开始的位置
 */
@property (nonatomic, assign) long long begin;
/**
 *  结束的位置
 */
@property (nonatomic, assign) long long end; 
@end
