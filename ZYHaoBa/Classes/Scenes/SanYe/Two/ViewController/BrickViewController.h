//
//  BrickViewController.h
//  ZYHaoBa
//
//  Created by ylcf on 16/9/14.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYViewController.h"

@interface BrickViewController : ZYViewController

// 砖块图像数组
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *blockImages;
// 小球图像视图
@property (weak, nonatomic) IBOutlet UIImageView *ballImageView;
// 挡板图像视图
@property (weak, nonatomic) IBOutlet UIImageView *paddleImageView;
// 消息标签
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
// 点击屏幕手势识别
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesure;

// 点按屏幕，开始游戏
- (IBAction)tapScreen:(id)sender;
// 拖拽挡板
- (IBAction)dragPaddle:(UIPanGestureRecognizer *)sender;


@end
