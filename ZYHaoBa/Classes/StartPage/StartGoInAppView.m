//
//  StartGoInAppView.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/23.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "StartGoInAppView.h"
#import <AVFoundation/AVFoundation.h>

@interface StartGoInAppView()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) UIButton *goInButton;

@end

@implementation StartGoInAppView


-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creacteVidioPlayer];
        [self createButton];
    }
    return self;
}

#pragma mark 播放视频
- (void)creacteVidioPlayer {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"welcome_video" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player.volume = 0;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.layer.bounds;
    [self.layer addSublayer:playerLayer];
    
    [self.player play];
    
    // 播放结束时响应通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moivePlayDidEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.player.currentItem];
}

#pragma mark 视频循环播放
- (void)moivePlayDidEnd:(NSNotification *)notification {
    
    AVPlayerItem *item = notification.object;
    [item seekToTime:kCMTimeZero];
    [self.player play];
}

#pragma mark 创建Button
- (void)createButton {
    _goInButton = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 60, SCREEN_WIDTH - 40, 30)];
    _goInButton.backgroundColor = [UIColor redColor];
    [_goInButton setTitle:@"进入App" forState:(UIControlStateNormal)];
    [_goInButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _goInButton.layer.cornerRadius = 10;
    [_goInButton addTarget:self action:@selector(didClickGoInApp) forControlEvents:(UIControlEventTouchDown)];
    
    [self addSubview:_goInButton];
}

- (void)didClickGoInApp {
    
    [UIView animateWithDuration:1.0 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
