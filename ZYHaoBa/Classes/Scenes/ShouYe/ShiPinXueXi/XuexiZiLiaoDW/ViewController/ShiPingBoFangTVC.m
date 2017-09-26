//
//  ShiPingBoFangTVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/14.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ShiPingBoFangTVC.h"
#import "VidioModel.h"
#import "VidioTableViewCell.h"

@interface ShiPingBoFangTVC ()
@property (nonatomic, strong) NSArray *videos;
@end

@implementation ShiPingBoFangTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self showHint:@"正在加载视频信息...."];
    
    //    NSXMLParser  XML 解析
    // MediaPlayer\AVFoundation
    
    // 访问服务器数据
    NSString *urlStr = @"http://192.168.1.200:8080/MJServer/video";
    
    // 发送请求
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url]; // GET
    request.timeoutInterval = 10;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 隐藏
        [self hideHud];
        
        if (data) {
            // 解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSArray *array = dict[@"videos"];
            
            NSMutableArray *videos = [NSMutableArray array];
            for (NSDictionary *videoDict in array) {
                VidioModel *video = [VidioModel videoWithDict:videoDict];
                [videos addObject:video];
            }
            self.videos = videos;
            
            // 刷新表格
            [self.tableView reloadData];
        } else {
            [self showHint:@"网络繁忙!!!"];
        }
    }];

}

#pragma mark 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VidioTableViewCell *cell = [VidioTableViewCell cellWithTableView:tableView];
    
    cell.video = self.videos[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VidioModel *video = self.videos[indexPath.row];
    //    video.url;
    
    // 播放视频
    NSString *videoUrl = [NSString stringWithFormat:@"http://192.168.1.200:8080/MJServer/%@", video.url];
//    HMMoviePlayerViewController *playerVc = [[HMMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:videoUrl]];
//    [self presentMoviePlayerViewControllerAnimated:playerVc];
    
    // 只能全屏播放
    //    MPMoviePlayerController; // 可以随意控制播放器的尺寸
}


@end
