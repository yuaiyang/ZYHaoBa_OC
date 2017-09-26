//
//  VCAndAppJieXiVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/21.
//  Copyright © 2016年 正羽. All rights reserved.
//  本页面是对AppDelegate和我们使用的ViewController使用的一些常识解析 需要在控制台看数据 方便理解

#import "VCAndAppJieXiVC.h"
#import "XibShiYongVC.h"

@interface VCAndAppJieXiVC ()

@end

@implementation VCAndAppJieXiVC
/*
 1.以下方法都需要调用：super方法（父类方法）<loadView例外>
 2.loadView是一个及其复杂的方法，如果需要自定义视图布局，那么不用调用其super方法
 3.每一个ViewController的view都是懒加载，在每次需要使用时就会调用
*/

#pragma mark 加载视图 <先加载，后显示>
//当访问UIViewController的view属性时，view如果此时是nil，那么VC会自动调用loadView方法来初始化一个UIView并赋值给view属性。此方法用在初始化关键view，需要注意的是，在view初始化之前，不能先调用view的getter方法，否则将导致死循环（除非先调用了[supper loadView];）
- (void)loadView
{
    // 注意：直接调用会死循环
    //    xh(@"%@", self.view);
    
    // 在loadView中，不应该调用父类的loadView方法
    //    [super loadView];
    
    // 如果用纯代码的方式开发，视图界面的设置需要写在此方法中！！！
    // 1> 首先需要初始化视图
    // 2> UIController中的视图是懒（延迟）加载的，在需要的时候在创建
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(110, 100, 100, 40)];
    
    [self.view addSubview:button];
    
    UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, 200, 40)];
    // 用代码创建文本框时，默认是没有边框的，需要自行制定一下
    [textFiled setBorderStyle:UITextBorderStyleLine];
    
    [self.view addSubview:textFiled];
}

#pragma mark 视图完成加载，马上就要出现了
//当VC的view对象载入内存后调用，用于对view进行额外的初始化操作
- (void)viewDidLoad {
    [super viewDidLoad];
    
    xh(@"view Did Load %@", self.view.superview);
    // self.view默认是透明的
    //    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    // 创建导航栏右按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Xib" style:(UIBarButtonItemStylePlain) target:self action:@selector(didClickRightBtnItem)];
    
}

/**
 viewDidLoad方法完成后，只是视图完成了加载工作
 此时：视图控制器尚没有把视图交给AppDelegate的UIWindow
 
 视图控制器会在视图显示前，将view交给UIWindow
 */

#pragma mark 视图将要出现
//在view即将添加到视图层级中(显示给用户)且任意显示动画切换之前调用(这个时候supperView还是nil)。这个方法中完成任何与视图显示相关的任务，例如改变视图方向、状态栏方向、视图显示样式等
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
#pragma mark 视图出现
//在view被添加到视图层级中，显示动画切换之后调用(这时view已经添加到supperView中)。在这个方法中执行视图显示相关附件任务，如果重载了这个方法，必须在方法中调用[supper viewDidAppear];
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    xh(@"view %@", self.view.superview);
}
#pragma mark 视图将要重新布局
//view即将布局其Subviews。比如view的bounds改变了(例如状态栏从不显示到显示，视图方向变化)，要调整Subviews的位置，在调整之前要做的一些工作就可以在该方法中实现
-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}
#pragma mark 视图完成重新布局
//view已经布局其Subviews。比如view的bounds改变了(例如状态栏从不显示到显示，视图方向变化)，已经调整Subviews的位置，在调整完成之后要做的一些工作就可以在该方法中实现。
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
#pragma mark
//view即将从superView中移除且移除动画切换之前，此时还没有调用removeFromSuperview。
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
#pragma mark
//view从superView中移除，移除动画切换之后调用，此时已调用removeFromSuperview
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

//视图被销毁，此处需要对你在init和viewDidLoad中创建的对象进行释放
-(void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickRightBtnItem {
    XibShiYongVC * view = [[XibShiYongVC alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

@end
