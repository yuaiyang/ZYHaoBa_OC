//
//  PhotoViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/14.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "PhotoViewController.h"

#define kImageFileName @"userImage.png"

@interface PhotoViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) UIButton *button;//相册
@property (weak, nonatomic) UIButton *button1;//照相机
@end

@implementation PhotoViewController

#pragma mark 实例化视图
- (void)loadView
{
    [super loadView];
    // 1. 实例化根视图，视图实例化时默认是透明
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    // 2. 创建一个按钮，等下选择图片后，在按钮中显示选择的图片
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button1 setFrame:CGRectMake((SCREEN_WIDTH - 200)*0.5, 20, 200, 30)];
    [button1 setTitle:@"打开相机照相" forState:UIControlStateNormal];
    [button1 setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:button1];
    self.button1 = button1;
    
    // 按钮监听方法
    [button1 addTarget:self action:@selector(clickButton1) forControlEvents:UIControlEventTouchUpInside];
    
    // 3. 创建一个按钮，等下选择图片后，在按钮中显示选择的图片
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setFrame:CGRectMake((SCREEN_WIDTH - 200)*0.5, CGRectGetMaxY(button1.frame)+20, 200, 200)];
    [button setTitle:@"选择相册照片" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.view addSubview:button];
    self.button = button;
    
    // 按钮监听方法
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 需要找出沙盒路径
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 设置保存文件名称
    NSString *path = [documents[0] stringByAppendingPathComponent:kImageFileName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    [self.button setImage:image forState:UIControlStateNormal];
}

#pragma mark 按钮点击方法
- (void)clickButton
{
    // 显示照片选择控制器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    // 1) 照片源
    // a 照片库[用相机拍摄以及用电脑同步的]
    // b 保存的图像[用相机拍摄的]
    // c 照相机
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    // 2) 是否允许编辑
    [imagePicker setAllowsEditing:YES];
    
    // 3) 设置代理
    [imagePicker setDelegate:self];
    
    // 4) 显示照片选择控制器，显示modal窗口
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark UIImagePicker代理方法
#pragma mark 照片选择完成的代理方法，照片信息保存在info参数中
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    xh(@"info %@", info);
    // 获取编辑后的照片
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
    // 设置照片
    [self.button setImage:image forState:UIControlStateNormal];
    
    // 关闭照片选择器
    // 注意：使用照片选择器选择的图片，只是保存在内存中
    // 如果需要再次使用，选择照片后，需要做保存处理
    [self dismissViewControllerAnimated:YES completion:^{
        
        // 要保存照片需要NSData做中转
        NSData *imageData = UIImagePNGRepresentation(image);
        
        // 需要找出沙盒路径
        NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // 设置保存文件名称
        NSString *path = [documents[0] stringByAppendingPathComponent:kImageFileName];
        // 保存文件
        xh(@"%@", path);
        [imageData writeToFile:path atomically:YES];
    }];
}

#pragma mark - 打开相机照相
-(void)clickButton1 {
    //判断是否可以打开相机,模拟器无法使用此功能
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        
        picker.allowsEditing = YES; //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"您没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
