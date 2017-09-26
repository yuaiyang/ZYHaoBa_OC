//
//  ZiTiSuiYiPaiBuVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/19.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZiTiSuiYiPaiBuVC.h"
#import "JHCusomHistory.h"

@interface ZiTiSuiYiPaiBuVC ()

@end

@implementation ZiTiSuiYiPaiBuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /*        添加自定义视图         */
    JHCusomHistory *history = [[JHCusomHistory alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT) andItems:@[@"熊出没",@"死神来了19",@"钢铁侠0",@"海上钢琴师",@"最后一只恐龙",@"苍井空",@"假如爱有天意",@"好好先生",@"特种部队",@"生化危机",@"魔兽",@"魔兽2"] andItemClickBlock:^(NSInteger i) {
        
        
        /*        相应点击事件 i为点击的索引值         */
        
    }];
    
    [self.view addSubview:history];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
