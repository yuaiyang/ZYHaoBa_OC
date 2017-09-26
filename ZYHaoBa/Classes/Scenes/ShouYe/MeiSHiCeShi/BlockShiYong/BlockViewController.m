//
//  BlockViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/19.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "BlockViewController.h"
#import "BlockTableViewController.h"

@interface BlockViewController ()<BlockTableViewControllerDelegate>

//block显示传递数据
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UILabel *lable3;
@property (weak, nonatomic) IBOutlet UILabel *lable4;

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Block的设置";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点击跳转" style:(UIBarButtonItemStylePlain) target:self action:@selector(didClickRightBtn)];
    
    // 调用设置通知
    [self testNotification];
}

- (void)didClickRightBtn {
    BlockTableViewController * view = [[BlockTableViewController alloc] init];
    view.delegate = self;
    
    view.title = @"block...返回参数";
    
#warning - 实现block方法
    view.oneBlock = ^{
        xh(@"调用第一个Block");
        self.lable1.text = @"已点击调用第一个Block";
    };
    
    view.twoBlock = ^(NSString *str){
        xh(@"调用第二个Block传递参数：%@",str);
        self.lable2.text = [NSString stringWithFormat:@"调用第二个Block传递参数：%@",str];
    };
    
    view.threeBlock = ^(NSString *str,NSArray *arr){
        xh(@"调用第三个Block传递参数:%@",str);
        xh(@"调用第三个Block传递数组:%@",arr);
        self.lable3.text = [NSString stringWithFormat:@"调用第三个Block传递参数:%@,数组：%@",str,arr];
    };
    
    view.fourBlock = ^(NSString *str){
        xh(@"调用第四个Block传递参数:%@",str);
        self.lable2.text = [NSString stringWithFormat:@"调用第四个Block传递参数:%@",str];
    };
    
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 实现代理方法
-(void)getValue:(NSString *)value {
    xh(@"代理传递的值：%@",value);
    NSString *str = [NSString stringWithFormat:@"代理传递的值：%@",value];
    showAlert(str);
}

-(void)testDlegate {
    xh(@"需要实现代理方法");
    showAlert(@"需要实现代理方法");
}

#pragma mark - 通知的使用
- (void)testNotification {
    //获取通知中心单例对象 添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"testNot" object:nil];
}

- (void)notificationAction:(id)sender {
    NSString *str = [NSString stringWithFormat:@"通知传递的值：%@",sender];
    showAlert(str);
}

#warning 必须移除通知
-(void)dealloc {
    //    移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
