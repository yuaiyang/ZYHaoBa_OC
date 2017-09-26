//
//  NetworkDelayViewController.m
//  allinone
//
//  Created by Johnil on 16/2/27.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "NetworkDelayViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NetworkNotificationDelayViewController.h"

@interface NetworkDelayViewController ()

@end

@implementation NetworkDelayViewController {
    MPMoviePlayerController *_player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _player = [[MPMoviePlayerController alloc] init];
    _player.view.frame = CGRectMake(0, 64, self.view.width, self.view.width/16.*9.);
    _player.controlStyle = MPMovieControlStyleDefault;
    _player.repeatMode = MPMovieRepeatModeOne;
    [self.view addSubview:_player.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _player.contentURL = [NSURL URLWithString:@"http://pl.youku.com/playlist/m3u8?vid=370551814&type=mp4&ts=1456536121&keyframe=0&ep=dCaRHEyOUM8C5CfYjD8bZH23ciNcXP0N9hqAgNpjBNQmQeq7&sid=6456536121474123ae6dc&token=2924&ctype=12&ev=1&oip=465375064"];
        if (self.navigationController.visibleViewController==self) {
            [_player prepareToPlay];
            [_player play];
        }
    });
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NetworkNotificationDelayViewController *vc = [[NetworkNotificationDelayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
