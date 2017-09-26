//
//  FengZhuangDaWenJianXiaZaiVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/18.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "FengZhuangDaWenJianXiaZaiVC.h"
#import "ZYFileDownloader.h"

@interface FengZhuangDaWenJianXiaZaiVC ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) ZYFileDownloader *fileDownloader;

- (IBAction)start:(UIButton *)button;
@end

@implementation FengZhuangDaWenJianXiaZaiVC

- (ZYFileDownloader *)fileDownloader
{
    if (!_fileDownloader) {
        _fileDownloader = [[ZYFileDownloader alloc] init];
        // 需要下载的文件远程URL
        _fileDownloader.url = KDOWNLOADURL;
        // 文件保存到什么地方
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        xh(@"大文件封装下载路径：--- %@",caches);
        NSString *filepath = [caches stringByAppendingPathComponent:@"FengZhuangDaWenJianXiaZaiVC.zip"];
        _fileDownloader.destPath = filepath;
        //        typeof(10) a = 20; // int a = 20;
        
        __weak typeof(self) vc = self;
        _fileDownloader.progressHandler = ^(double progress) {
            vc.progressView.progress = progress;
        };
        
        _fileDownloader.completionHandler = ^{
            xh(@"------下载完毕");
        };
        
        _fileDownloader.failureHandler = ^(NSError *error){
            
        };
    }
    return _fileDownloader;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"大文件下载封装";
}

// 按钮文字: "开始", "暂停"
- (IBAction)start:(UIButton *)button { // self.currentLength == 200
    if (self.fileDownloader.isDownloading) { // 暂停下载
        [self.fileDownloader pause];
        
        [button setTitle:@"恢复" forState:UIControlStateNormal];
    } else { // 开始下载
        [self.fileDownloader start];
        
        [button setTitle:@"暂停" forState:UIControlStateNormal];
    }
}

@end
