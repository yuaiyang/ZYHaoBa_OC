//
//  DaohangLanSheZhiVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/20.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "DaohangLanSheZhiVC.h"

@interface DaohangLanSheZhiVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isShow;
}
@property (nonatomic, strong)UITableView * listTableView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation DaohangLanSheZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [ZYProTools setZYTitleLabel:@"导航栏设置" fontSize:17];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全部" style:(UIBarButtonItemStylePlain) target:self action:@selector(didClickRightButtonItem)];
    //    富文本
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15<=10], NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
}

#pragma mark - didClickRightButtonItem
- (void)didClickRightButtonItem {
    [self.view addSubview:self.listTableView];
    
    //定义动画，进行对应的底部按钮数组视图切换动画处理操作
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setType:kCATransitionPush];
    
    //定义字符串，进行对应子动画类型的设定保存处理
    NSString *subType=nil;
    //当对应的视图为要显示状态时设定其动画方向为从右向左
    if(isShow) {
        isShow = NO;
        self.listTableView.hidden = YES;
        subType=kCATransitionFromTop;
    }
    //当对应的视图为要隐藏状态时设定其动画方向为从左向右
    else {
        isShow = YES;
        self.listTableView.hidden = NO;
        subType=kCATransitionFromBottom;
    }
    
    //为对应的按钮数组视图添加动画
    [animation setSubtype: subType];
    
    [self.listTableView.layer addAnimation:animation forKey:@"Transition"];
}

-(UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderHeight*4)];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
//        _listTableView.hidden = YES;
    }
    return _listTableView;
}

#pragma mark - tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr = @"daohanglan_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellStr];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.textLabel.text = [NSString stringWithFormat:@"点击第%ld行",(long)indexPath.row];
    [self didClickRightButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
