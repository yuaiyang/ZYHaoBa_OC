//
//  ZYAlertView.m
//  text
//
//  Created by ylcf on 16/6/20.
//  Copyright © 2016年 ylcf. All rights reserved.
//

#import "ZYAlertView.h"

@implementation ZYAlertView

- (id)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titleStr withContentStr:(NSString *)contentStr withButtonStr:(NSString *)buttonStr
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleStr = titleStr;
        _contentStr = contentStr;
        _buttonStr = buttonStr;
        [self creatView];
    }
    return self;
}

- (void)creatView
{
    _subBackView = [[UIView alloc] initWithFrame:self.frame];
    _subBackView.backgroundColor = [UIColor blackColor];
    _subBackView.alpha = 0;
    [self addSubview:_subBackView];
    
    UIView *backView = [[UIView alloc] init];
    backView.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0 - 50);
    backView.bounds = CGRectMake(0, 0, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.4);
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    _backView = backView;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, backView.frame.size.width, 30)];
    titleLabel.text = _titleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    [backView addSubview:titleLabel];
    
    UITextView *contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 50, CGRectGetWidth(backView.frame) - 40, backView.frame.size.height - 111)];
    //    textview 改变字体的行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:17],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    contentTextView.attributedText = [[NSAttributedString alloc] initWithString:_contentStr attributes:attributes];
    
    contentTextView.backgroundColor = [UIColor clearColor];
    contentTextView.textColor = [UIColor grayColor];
    [backView addSubview:contentTextView];
    
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, backView.frame.size.height - 61, backView.frame.size.width, 1)];
    lable.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:204/255.0 alpha:1];
    [backView addSubview:lable];
    
    UIButton *certainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    certainButton.frame = CGRectMake(0, backView.frame.size.height - 60, backView.frame.size.width, 60);
    [certainButton setTitleColor:[UIColor colorWithRed:56/255.0 green:173/255.0 blue:255/255.0 alpha:1] forState:(UIControlStateNormal)];
    certainButton.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [certainButton setTitle:_buttonStr forState:UIControlStateNormal];
    [certainButton addTarget:self action:@selector(certainButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:certainButton];
}

#pragma mark certainButtonClick
- (void)certainButtonClick
{
    [UIView animateWithDuration:0.4 animations:^{
        _backView.alpha = 0.0;
        _subBackView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    if ([_delegate respondsToSelector:@selector(sendValueOfDidClickBtn:)]) {
        [_delegate sendValueOfDidClickBtn:@"1"];
    }
}

#pragma mark show
-(UIView*)topView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return  window.subviews[0];
}

- (void)show
{
    [UIView animateWithDuration:0.5 animations:^{
        _backView.alpha = 1;
        _subBackView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
    }];
    [[self topView] addSubview:self];
    [self showAnimation];
}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

#pragma mark Animation
- (void)showAnimation {
    CAKeyframeAnimation *alertViewshowAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    alertViewshowAnimation .duration = 0.4;
    alertViewshowAnimation .values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                       [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                                       [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                                       [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    alertViewshowAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    alertViewshowAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_backView.layer addAnimation:alertViewshowAnimation forKey:nil];
}

@end
