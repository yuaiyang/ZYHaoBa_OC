//
//  ZYExpressionView.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/16.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYExpressionView.h"

@interface ZYExpressionView()<UITextFieldDelegate,UITextViewDelegate>
{
    UITextField *textField1;
}
@property (weak, nonatomic) UITextView *textView;

@end


@implementation ZYExpressionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self creareView];
    }
    return self;
}

- (void)creareView {
    // 创建一个textField
    textField1 = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, 280, 30)];
    textField1.delegate = self;
    [textField1 setBorderStyle:UITextBorderStyleRoundedRect];
    textField1.placeholder = @"请输入\ue001";
    [self addSubview:textField1];
    
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 193)];
    textView.delegate = self;
    // 设置键盘return为完成
    textView.returnKeyType=UIReturnKeyDone;
    [self addSubview:textView];
    self.textView = textView;
    [self.textView setFont:[UIFont systemFontOfSize:32]];
    
    unichar emoteChar = 0xe000;
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < 1000; i++) {
        [string appendFormat:@"%C ", emoteChar++];
    }
    [self.textView setText:string];
}

#pragma mark 点击页面隐藏键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [textField1 resignFirstResponder];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [textField1 resignFirstResponder];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     [textField1 resignFirstResponder];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [textField1 resignFirstResponder];
}

#pragma mark textfield代理方法隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark textView代理方法隐藏键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
