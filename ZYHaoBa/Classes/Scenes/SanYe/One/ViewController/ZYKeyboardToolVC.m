//
//  ZYKeyboardToolVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/16.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYKeyboardToolVC.h"
#import "KeyboardTool.h"

@interface ZYKeyboardToolVC () <KeyboardToolDelegate, UITextFieldDelegate>

// 键盘工具自定义视图
@property (weak, nonatomic) KeyboardTool *KeyboardTool;

// 建立所有文本输入控件的数组
@property (strong, nonatomic) NSArray *textFiledArray;

// 用户选中的文本框
@property (weak, nonatomic) UITextField *selectedTextField;

@end

@implementation ZYKeyboardToolVC


-(void)viewDidLoad {
    // 1. 实例化视图
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    // 2. 创建UILabel
    [self createLabelWithFrame:CGRectMake(20, 20, 80, 30) text:@"姓名"];
    [self createLabelWithFrame:CGRectMake(20, 56, 80, 30) text:@"QQ"];
    [self createLabelWithFrame:CGRectMake(20, 92, 80, 30) text:@"生日"];
    [self createLabelWithFrame:CGRectMake(20, 128, 80, 30) text:@"城市"];
    
    // 3. 创建TextField
    // 注意：因为文本空间需要使用KeyboardTool作为助手视图，
    // 因此，在定义文本空间的助手视图之前，需要实例化KeyboardTool视图
    self.KeyboardTool = [KeyboardTool KeyboardTool];
    [self.KeyboardTool setToolDelegate:self];
    UITextField *nameText = [self createTextFiledWithFrame:CGRectMake(105, 20, 195, 30) placeHolder:@"请输入姓名"];
    [nameText setInputAccessoryView:self.KeyboardTool];
    
    UITextField *qqText = [self createTextFiledWithFrame:CGRectMake(105, 56, 195, 30) placeHolder:@"请输入QQ"];
    [qqText setInputAccessoryView:self.KeyboardTool];
    
    UITextField *birthdayText = [self createTextFiledWithFrame:CGRectMake(105, 92, 195, 30) placeHolder:@"请选择生日"];
    [birthdayText setInputAccessoryView:self.KeyboardTool];
    
    UITextField *cityText = [self createTextFiledWithFrame:CGRectMake(105, 128, 195, 30) placeHolder:@"请选择城市"];
    [cityText setInputAccessoryView:self.KeyboardTool];
    
    // 实例化文本框数组
    self.textFiledArray = @[nameText, qqText, birthdayText, cityText];
    
    //    // 常用遍历视图中子视图控件，并查找其中指定类型的方法
    //    for (UIView *textField in self.view.subviews) {
    //        // 判断遍历的控件类型是否是文本框控件
    //        if ([textField isKindOfClass:[UITextField class]]) {
    //            [self.textFiledArray addObject:textField];
    //        }
    //    }
    xh(@"%@", self.textFiledArray);
}
//#pragma mark 初始化界面
//- (void)loadView


#pragma mark 私有方法
#pragma mark 创建TextField
- (UITextField *)createTextFiledWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder
{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    // 1）设置边框
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    // 2) 设置垂直居中排列
    [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    // 3) 文本的占位提示信息
    [textField setPlaceholder:placeHolder];
    // 4) 将文本添加到根视图
    [self.view addSubview:textField];
    
    // 5 添加文本框的代理，以便光标进入文本框时记录
    [textField setDelegate:self];
    
    return textField;
}

#pragma mark 创建UILabel
- (void)createLabelWithFrame:(CGRect)frame text:(NSString *)text
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    [label setText:text];
    
    [self.view addSubview:label];
}

#pragma mark UITextField代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 记录当前选中的文本框
    self.selectedTextField = textField;
    
    NSUInteger index = [self.textFiledArray indexOfObject:textField];
    // 如果是数组中第一个文本框，禁用上一个按钮
    self.KeyboardTool.prevButton.enabled = (index != 0);
    // 如果是数组中最后一个文本框，禁用下一个按钮
    self.KeyboardTool.nextButton.enabled = (index != self.textFiledArray.count - 1);
}

#pragma mark 键盘助手视图代理方法
- (void)KeyboardTool:(KeyboardTool *)keyboard buttonType:(KeyboardToolButtonType)buttonType
{
    /**
     上一个&下一个文本控件的切换
     */
    xh(@"%d", buttonType);
    if (kKeyboardToolButtonDone == buttonType) {
        // 关闭键盘
        [self.view endEditing:YES];
    } else {
        // 1. 获取当前选中的文本控件
        // 2. 获取当前空间在数组中的索引
        NSUInteger index = [self.textFiledArray indexOfObject:self.selectedTextField];
        if (kKeyboardToolButtonNext == buttonType) {
            index++;
        } else {
            index--;
        }
        
        UITextField *textField = self.textFiledArray[index];
        
        [textField becomeFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
