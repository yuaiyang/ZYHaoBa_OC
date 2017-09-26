//
//  ZYAlertVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/11.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYAlertVC.h"

@interface ZYAlertVC ()

@end

@implementation ZYAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark 点击单按钮视图
- (IBAction)didClickSingleBtn:(UIButton *)sender {
    [ZYProTools showZYSingleAlertViewWithTitle:@"提示" Msg:@"测试单按钮提示框" withBtnText:@"知道啦"];
}

#pragma mark 点击双按钮视图
- (IBAction)didClickDoubleBtn:(UIButton *)sender {
    [ZYProTools showZYDoublelAlertViewWithTitle:@"提示" Msg:@"测试双按钮提示框" withLeftText:@"取消" withRightText:@"确定" rightHandler:^(UIAlertAction *action) {
        showAlert(@"点击确定");
    }];
}

#pragma mark 点击底部提示框视图
- (IBAction)didClickBottomBtn:(UIButton *)sender {
    [ZYProTools showBottomAlertViewWithTitle:@"提示" Msg:@"底部提示框" cancelText:@"取消" withActionText:@"测试" actionHandler:^(UIAlertAction *action) {
        showAlert(@"测试底部提示框");
    }];
}

#pragma mark 点击可输入文字提示框视图
- (IBAction)didClickTextFiledAlert:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"信息" preferredStyle:(UIAlertControllerStyleAlert)];
    
    // 为防止block与控制器间循环引用，我们这里需用__weak来预防
    __weak typeof(alert) wAlert = alert;
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"提交" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSString * str = wAlert.textFields.firstObject.text;
        showAlert([NSString stringWithString:str]);
        xh(@"提交 = %@",str);
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"返回" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        xh(@"返回");
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        xh(@"取消");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        xh(@"textField.text = %@",textField.text);
        
        [textField addTarget:self action:@selector(didClickTextFiled:) forControlEvents:UIControlEventTouchDragInside];
    }];
    
    [self presentViewController:alert animated: YES completion: nil];
}

- (void)didClickTextFiled:(UITextField *)textFiled {
    
    NSString *str = [NSString stringWithFormat:@"textFiled = %@",textFiled.text];
    xh(@"didClickTextFiled = %@",str);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
