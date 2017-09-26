//
//  DuoXianChengDuanDianXiaZaiVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/19.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "DuoXianChengDuanDianXiaZaiVC.h"
#import "HMFileMultiDownloader.h"

@interface DuoXianChengDuanDianXiaZaiVC ()
@property (nonatomic, strong) HMFileMultiDownloader *fileMultiDownloader;
@end

@implementation DuoXianChengDuanDianXiaZaiVC

-  (HMFileMultiDownloader *)fileMultiDownloader
{
    if (!_fileMultiDownloader) {
        _fileMultiDownloader = [[HMFileMultiDownloader alloc] init];
        // 需要下载的文件远程URL
        _fileMultiDownloader.url = KDOWNLOADURL;
        // 文件保存到什么地方
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filepath = [caches stringByAppendingPathComponent:@"DuoXianChengDuanDianXiaZaiVC.zip"];
        _fileMultiDownloader.destPath = filepath;
    }
    return _fileMultiDownloader;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"多线程断点下载";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.fileMultiDownloader start];
}

@end
