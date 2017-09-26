//
//  NetworkNotificationDelayViewController.m
//  allinone
//
//  Created by Johnil on 16/2/27.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "NetworkNotificationDelayViewController.h"
#import "AORequest.h"
@interface NetworkNotificationDelayViewController ()

@end

@implementation NetworkNotificationDelayViewController {
    NSMutableArray *_datas;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_datas removeAllObjects];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<10; i++) {
        [_datas addObject:@(i)];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [AORequest requestApi:@"delay" parames:nil success:^(id responseObject) {
        _datas[3] = responseObject;
        self.navigationItem.title = [[responseObject allValues] firstObject];
    } failed:^(id responseObject) {
        
    }];
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
