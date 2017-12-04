//
//  ZYPresentAlertVC.m
//  ZYHaoBa
//
//  Created by 一路财富 on 2017/12/4.
//  Copyright © 2017年 正羽. All rights reserved.
//

#import "ZYPresentAlertVC.h"

@interface ZYPresentAlertVC ()

@end

@implementation ZYPresentAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor    = [UIColor colorWithWhite:0.6 alpha:0.5];
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    
    [btn setTitle:@"dissmis" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(onClickBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
}

#pragma Mark - Action

-(void)onClickBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
