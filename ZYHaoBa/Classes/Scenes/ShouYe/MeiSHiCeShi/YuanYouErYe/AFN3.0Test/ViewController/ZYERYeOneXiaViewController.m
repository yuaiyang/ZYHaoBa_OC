//
//  ZYERYeOneXiaViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYERYeOneXiaViewController.h"
#import "ZYErYeTwoViewController.h"

@interface ZYERYeOneXiaViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * DataArray;

@end

@implementation ZYERYeOneXiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.urlString;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNav_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    self.DataArray = [NSMutableArray arrayWithObjects:@"测试",@"测试", nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.DataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"erYeOneXia_Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    cell.textLabel.text = _DataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYErYeTwoViewController * view = [[ZYErYeTwoViewController alloc]
                                      init];
    view.urlString = @"跳转三级页面";
    [self.navigationController pushViewController:view animated:YES];
}


-(NSMutableArray *)DataArray {
    if (!_DataArray) {
        _DataArray = [NSMutableArray array];
        
    }
    return _DataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
