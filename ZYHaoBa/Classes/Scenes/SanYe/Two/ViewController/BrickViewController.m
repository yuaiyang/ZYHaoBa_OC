//
//  BrickViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/14.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "BrickViewController.h"

@interface BrickViewController ()

{
    // 小球的初始位置
    CGPoint         _originBallCenter;
    // 挡板的初始位置
    CGPoint         _originPaddleCenter;
    // 游戏时钟
    CADisplayLink   *_gameTimer;
    // 小球的速度
    CGPoint         _ballVelocity;
    // 挡板的水平速度
    CGFloat         _paddleVelocityX;
}

@end

@implementation BrickViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 记录小球初始中心点位置
    _originBallCenter = _ballImageView.center;
    // 记录挡板初始中心点位置
    _originPaddleCenter = _paddleImageView.center;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 碰撞检测方法
// 与屏幕的碰撞检测
- (void)intersectWithScreen
{
    // 与屏幕上方的碰撞检测
    if (CGRectGetMinY(_ballImageView.frame) <=0) {
        _ballVelocity.y = ABS(_ballVelocity.y);
    }
    
    // 与屏幕左侧的碰撞检测
    if (CGRectGetMinX(_ballImageView.frame) <= 0) {
        _ballVelocity.x = ABS(_ballVelocity.x);
    }
    
    // 与屏幕右侧的碰撞检测
    if (CGRectGetMaxX(_ballImageView.frame) >= self.view.bounds.size.width) {
        _ballVelocity.x = -ABS(_ballVelocity.x);
    }
    
    // 从屏幕下方掉出，游戏结束
    if (CGRectGetMinY(_ballImageView.frame) >= self.view.bounds.size.height) {
        xh(@"你输了!");
        // 关闭时钟
        [_gameTimer invalidate];
        
        // 提示用户输了
        [_messageLabel setHidden:NO];
        [_messageLabel setText:@"你输啦~~~"];
        // 启用点击屏幕手势识别
        [_tapGesure setEnabled:YES];
    }
}

// 与砖块的碰撞检测
- (void)intersectWithBlocks
{
    for (UIImageView *block in _blockImages) {
        // 循环检测砖块是否与小球碰撞，如果发生碰撞，翻转小球的速度
        if (CGRectIntersectsRect(block.frame, _ballImageView.frame) && ![block isHidden]) {
            // 把砖块隐藏起来
            [block setHidden:YES];
            
            // 翻转小球Y方向速度
            _ballVelocity.y *= -1;
        }
    }
    
    // 所有的砖块都被隐藏了，说明游戏胜利
    BOOL win = YES;
    for (UIImageView *block in _blockImages) {
        if (![block isHidden]) {
            win = NO;
            
            break;
        }
    }
    
    // 游戏胜利的处理
    if (win) {
        // 关闭时钟
        [_gameTimer invalidate];
        
        // 提示用户输了
        [_messageLabel setHidden:NO];
        [_messageLabel setText:@"欧耶~~~"];
        // 启用点击屏幕手势识别
        [_tapGesure setEnabled:YES];
    }
}

// 与挡板的碰撞检测
- (void)intersectWithPaddle
{
    if (CGRectIntersectsRect(_paddleImageView.frame, _ballImageView.frame)) {
        // 小球Y方向速度翻转
        _ballVelocity.y = -ABS(_ballVelocity.y);
        
        // 增加小球水平方向的速度，简单修正一下小球的水平速度
        _ballVelocity.x += _paddleVelocityX / 120.0;
    }
}

// 屏幕刷新时执行的方法
- (void)step
{
    xh(@"屏幕刷新了");
    [self intersectWithScreen];
    [self intersectWithBlocks];
    [self intersectWithPaddle];
    
    // 更新小球位置
    [_ballImageView setCenter:CGPointMake(_ballImageView.center.x + _ballVelocity.x,
                                          _ballImageView.center.y + _ballVelocity.y)];
}

// 点击屏幕，开始游戏
- (IBAction)tapScreen:(id)sender
{
    xh(@"点击屏幕了!");
    
    // 禁用点击屏幕手势识别
    [_tapGesure setEnabled:NO];
    
    // 消息标签隐藏
    [_messageLabel setHidden:YES];
    // 小球
    [_ballImageView setCenter:_originBallCenter];
    // 挡板
    [_paddleImageView setCenter:_originPaddleCenter];
    // 砖块，把隐藏的砖块恢复
    for (UIImageView *block in _blockImages) {
        [block setHidden:NO];
    }
    
    // 给小球设置初始速度11111
    _ballVelocity = CGPointMake(0.0, -15.0);
    
    // 定义游戏时钟
    _gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    
    // 把游戏时钟添加到主运行循环中
    [_gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

// 拖拽挡板
- (IBAction)dragPaddle:(UIPanGestureRecognizer *)sender
{
    // 拖拽手指时，改变挡板的位置
    // 需要判断手指是否在拖动
    if (UIGestureRecognizerStateChanged == sender.state) {
        // 取出手指移动到的位置
        CGPoint location = [sender locationInView:self.view];
        // 将挡板的水平位置设置为手指的位置
        [_paddleImageView setCenter:CGPointMake(location.x, _paddleImageView.center.y)];
        
        // 记录挡板的水平移动速度
        _paddleVelocityX = [sender velocityInView:self.view].x;
        xh(@"%f", _paddleVelocityX);
    } else if (UIGestureRecognizerStateEnded == sender.state) {
        // 恢复手指移动速度
        _paddleVelocityX = 0;
    }
}


@end
