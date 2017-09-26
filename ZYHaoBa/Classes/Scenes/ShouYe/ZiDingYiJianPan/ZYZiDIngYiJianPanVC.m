//
//  ZYZiDIngYiJianPanVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/12/14.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYZiDIngYiJianPanVC.h"
#import "ZYKeyboard.h"

@interface ZYZiDIngYiJianPanVC ()
{
    UIButton *doneInKeyboardButton;
}
@property (strong, nonatomic)UITextField *textField;
@property (nonatomic, strong)ZYKeyboard *keyboard;

@property (nonatomic, strong)NSString *allSelectedStr;
@end

@implementation ZYZiDIngYiJianPanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加键盘
    //    [self.view addSubview:self.keyboard];
    // 注册通知得到键盘点击的数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickNumberKeyboard:) name:ZYNumberDidSelectedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickToolBarDelete) name:ZYToolBarDidSelectedDeleteNotification object:nil];
    
    // 设置页面出现就弹出键盘方便用户输入
    self.textField.inputView = self.keyboard;
}

- (void)didClickNumberKeyboard:(NSNotification *)info {
    
    NSString *tempStr = info.userInfo[ZYSelectedNumber];
    if ([tempStr isEqualToString:@"123"] || [tempStr isEqualToString:@"abc"]) {
        return;
    }else if ([tempStr isEqualToString:@"确认"]) {
        NSLog(@"self.allSelectedStr：%@，拿到数据该做什么就去操作吧！",self.allSelectedStr);
        [self.view endEditing:YES];
    } else {
        if (self.allSelectedStr == nil) {
            self.allSelectedStr = tempStr;
        } else {
            self.allSelectedStr = [self.allSelectedStr stringByAppendingString:tempStr];
        }
        self.textField.text = self.allSelectedStr;
        NSLog(@"点击了：%@",tempStr);
    }
}

-(void)didClickToolBarDelete {
    [self.textField deleteBackward];
    self.allSelectedStr = self.textField.text;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 40)];
        _textField.placeholder = @"纯自定义键盘";
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:_textField];
    }
    return _textField;
}

-(ZYKeyboard *)keyboard {
    if (_keyboard == nil) {
        _keyboard = [ZYKeyboard keyboard];
    }
    return _keyboard;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
