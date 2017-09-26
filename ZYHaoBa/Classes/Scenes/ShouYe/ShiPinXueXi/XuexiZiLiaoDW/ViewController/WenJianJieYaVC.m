//
//  WenJianJieYaVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/19.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "WenJianJieYaVC.h"
#import "ZYFileDownloader.h"
#import "SSZipArchive.h"

@interface WenJianJieYaVC ()

@property (nonatomic, strong) ZYFileDownloader *fileDownloader;

@end

@implementation WenJianJieYaVC

- (ZYFileDownloader *)fileDownloader
{
    if (!_fileDownloader) {
        _fileDownloader = [[ZYFileDownloader alloc] init];
        // 需要下载的文件远程URL
        _fileDownloader.url = KDOWNLOADURL;
        // 文件保存到什么地方
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        xh(@"文件解压下载路径：%@",caches);
        NSString *filepath = [caches stringByAppendingPathComponent:@"WenJianJieYaVC.zip"];
        _fileDownloader.destPath = filepath;
        _fileDownloader.progressHandler = ^(double progress) {
            xh(@"------下载进度--%f", progress);
        };
        
        _fileDownloader.completionHandler = ^{
            xh(@"------下载完毕--解压");
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 解压(文件大, 会比较耗时)
                [SSZipArchive unzipFileAtPath:filepath toDestination:caches];
            });
        };
        
        _fileDownloader.failureHandler = ^(NSError *error){
            
        };
    }
    return _fileDownloader;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"文件下载解压";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.fileDownloader start];
}

- (void)createZip
{
    //    [[NSBundle mainBundle] pathForResource:@"minion_01.png" ofType:nil];
    
    // 1.获得mainBundle中所有的png的图片路径
    NSArray *pngs = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:nil];
    
    // 2.zip文件路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    xh(@"===================文件解压路径：%@",caches);
    NSString *zipFilepath = [caches stringByAppendingPathComponent:@"pngs.zip"];
    
    // 3.创建zip文件
    [SSZipArchive createZipFileAtPath:zipFilepath withFilesAtPaths:pngs];
}

@end
