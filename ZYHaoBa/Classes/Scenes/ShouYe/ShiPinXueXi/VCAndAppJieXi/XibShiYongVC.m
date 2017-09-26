//
//  XibShiYongVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/21.
//  Copyright © 2016年 正羽. All rights reserved.
//

// 注意：
// 1) 在加载xib时，不需要指定扩展名
//    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:[NSBundle mainBundle]];

// 2) 通常[NSBundle mainBundle]官方已经做了 直接nil就好
/*
 1. 优先加载View.xib
 2. 其次再找ViewController.xib
 3. 执行内部的创建过程
 */


#import "XibShiYongVC.h"

@interface XibShiYongVC ()

@end

@implementation XibShiYongVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        xh(@"come here %@ %@", nibNameOrNil, nibBundleOrNil);
    }
    
    return self;
}

// 通常在使用Storyboard或者xib的方式时，不要重写loadView方法！
//- (void)loadView
//{
//    [super loadView];
//    xh(@"load view");
//}

// 这个方法做什么 暂时未知11111111111
- (void)awakeFromNib
{
    xh(@"awake from nib");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Xib使用";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickMe
{
    xh(@"click me");
}


@end
