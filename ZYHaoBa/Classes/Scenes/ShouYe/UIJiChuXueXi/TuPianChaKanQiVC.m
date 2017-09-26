//
//  TuPianChaKanQiVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/31.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "TuPianChaKanQiVC.h"
#import "KVOModel.h"

/**
 用纯代码开发的过程
 
 1. 确定界面元素，要有什么内容
 2. 用代码来搭建界面
 3. 编写代码
 */

@interface TuPianChaKanQiVC ()
/**
 @proerty
 1. 创建了getter & setter方法
 2. 生成一个带_的成员变量，直接读取成员变量不会经过getter方法&setter方法
 
 strong & weak
 * 控件
 如果是用Stroyboard拖线，控件用weak
 如果用代码创建界面，控件可以用strong
 * 自定对象，需要使用strong
 * NSString，使用copy
 * 数字型的int，使用assign
 */
@property (nonatomic, strong) UILabel *noLabel;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

/** 当前显示的照片索引 */
@property (nonatomic, assign) int index;
/** 图片信息的数组 */
@property (nonatomic, strong) NSArray *imageList;

@property (nonatomic, strong) KVOModel *person;
@end

@implementation TuPianChaKanQiVC

/**
 懒加载(延迟加载)，通过getter实现
 
 效果：让对象在最需要的时候才创建！
 */
- (NSArray *)imageList
{
    NSLog(@"读取图像信息");
    if (_imageList == nil) {
        NSLog(@"实例化数组");
        
        NSDictionary *dict1 = @{@"name": @"Yosemite00.jpg", @"desc": @"表情1"};
        NSDictionary *dict2 = @{@"name": @"Yosemite01.jpg", @"desc": @"病例1"};
        NSDictionary *dict3 = @{@"name": @"Yosemite02.jpg", @"desc": @"吃牛扒1"};
        NSDictionary *dict4 = @{@"name": @"Yosemite03.jpg", @"desc": @"蛋疼1"};
        NSDictionary *dict5 = @{@"name": @"Yosemite04.jpg", @"desc": @"网吧1"};
        
        _imageList = @[dict1, dict2, dict3, dict4, dict5];
    }
    return _imageList;
}

#pragma mark - 控件的懒加载
// 在getter方法中，不要再使用self. 否则会重复调用getter方法，造成死循环
- (UILabel *)noLabel
{
    if (_noLabel == nil)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
        
        _noLabel = label;
        _noLabel.textAlignment  = NSTextAlignmentCenter;
        [self.view addSubview:_noLabel];
    }
    return _noLabel;
}

- (UIImageView *)iconImage
{
    if (_iconImage == nil)
    {
        CGFloat imageW = 200;
        CGFloat imageH = 200;
        CGFloat imageX = (self.view.bounds.size.width - imageW) * 0.5;
        CGFloat imageY = CGRectGetMaxY(self.noLabel.frame) + 20;
        
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        [self.view addSubview:_iconImage];
    }
    return _iconImage;
}

- (UILabel *)descLabel
{
    if (_descLabel == nil)
    {
        CGFloat descY = CGRectGetMaxY(self.iconImage.frame);
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, descY, self.view.bounds.size.width, 100)];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        
        // 需要Label具有“足够的高度”，不限制显示的行数
        _descLabel.numberOfLines = 0;
        [self.view addSubview:_descLabel];
    }
    return _descLabel;
}

- (UIButton *)leftButton
{
    if (_leftButton == nil) {
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        CGFloat centerY = self.iconImage.center.y;
        CGFloat centerX = self.iconImage.frame.origin.x * 0.5;
        _leftButton.center = CGPointMake(centerX, centerY);
        
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        [self.view addSubview:_leftButton];
        
        _leftButton.tag = -1;
        
        [_leftButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        CGFloat centerY = self.iconImage.center.y;
        CGFloat centerX = self.iconImage.frame.origin.x * 0.5;
        _rightButton.center = CGPointMake(self.view.bounds.size.width - centerX, centerY);
        
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"common_icon_arrow"] forState:UIControlStateNormal];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"common_icon_checkmark"] forState:UIControlStateHighlighted];
        [self.view addSubview:_rightButton];
        
        _rightButton.tag = 1;
        
        [_rightButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

/** 在viewDidLoad创建界面 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    [self.view addSubview:self.noLabel];
    
    KVOModel *p = [[KVOModel alloc] init];
    self.person = p;
    
    // 显示照片信息
    [self showPhotoInfo];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"%@", self.person);
}

/**
 重构的目的：让相同的代码只出现一次
 */
- (void)showPhotoInfo
{
    // 设置序号
    self.noLabel.text = [NSString stringWithFormat:@"%d/%d", self.index + 1, 5];
    
    // 效率不高，每次都会生成数组
    // 如何解决？使用属性记录字典数组
    //    NSDictionary *dict1 = @{@"name": @"biaoqingdi", @"desc": @"表情1"};
    //    NSDictionary *dict2 = @{@"name": @"bingli", @"desc": @"病例1"};
    //    NSDictionary *dict3 = @{@"name": @"chiniupa", @"desc": @"吃牛扒1"};
    //    NSDictionary *dict4 = @{@"name": @"danteng", @"desc": @"蛋疼1"};
    //    NSDictionary *dict5 = @{@"name": @"wangba", @"desc": @"网吧1"};
    //    NSArray *array = @[dict1, dict2, dict3, dict4, dict5];
    
    // 设置图像和描述
    self.iconImage.image = [UIImage imageNamed:self.imageList[self.index][@"name"]];
    self.descLabel.text = self.imageList[self.index][@"desc"];
    
    self.rightButton.enabled = (self.index != 4);
    self.leftButton.enabled = (self.index != 0);
}

// 在OC中，很多方法的第一个参数，都是触发该方法的对象！
- (void)clickButton:(UIButton *)button
{
    // 根据按钮调整当前显示图片的索引?
    self.index += button.tag;
    
    [self showPhotoInfo];
}
@end
