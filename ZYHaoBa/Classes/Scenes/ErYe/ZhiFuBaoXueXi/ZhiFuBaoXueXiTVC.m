//
//  ZhiFuBaoXueXiTVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZhiFuBaoXueXiTVC.h"
#import "ZYZhiFuBaoXueXiModel.h"
// 支付宝支付
#import "GalenPayPasswordView.h"


@interface ZhiFuBaoXueXiTVC ()

// 保存所有跳转数据
@property (nonatomic, strong)NSMutableArray * allDataArr;
// 保存单个跳转数据 跳转页面标题；跳转页面名称；跳转页面需要附带的信息arr；
//@property (nonatomic, strong)NSDictionary* allDataDic;
@end

@implementation ZhiFuBaoXueXiTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBaseData];
}

- (void)setUpBaseData {
    // 原始数据
    NSArray *arr = [NSArray arrayWithObjects:
                    @{@"titleName":@"支付宝支付页面",@"pushViewName":@"GalenPayPasswordView",@"isPushNewView":@"0"},
                    @{@"titleName":@"待添加",@"pushViewName":@"",@"isPushNewView":@"1"}, nil];
    // 加入数组
    for (NSDictionary *dic in arr) {
        ZYZhiFuBaoXueXiModel *model = [[ZYZhiFuBaoXueXiModel alloc] init];
        model.titleName = [dic objectForKey:@"titleName"];
        model.pushViewName = [dic objectForKey:@"pushViewName"];
        model.isPushNewViewStr = [dic objectForKey:@"isPushNewView"];
        [self.allDataArr addObject:model];
    }
}

/*=================tableView数据===================*/
#pragma mark tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"erYe_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ZYZhiFuBaoXueXiModel *model = _allDataArr[indexPath.row];
    cell.textLabel.text = model.titleName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYZhiFuBaoXueXiModel *model = _allDataArr[indexPath.row];
    // 是否会push新页面
    if (model.isPushNewView) {
        UIViewController *view = [[NSClassFromString(model.pushViewName) alloc] init];
        view.title = model.titleName;
        [self.navigationController pushViewController:view animated:YES];
    } else {
        [self isNoPushNewViewAtIndexPath:indexPath model:model];
    }
}

// 不用跳转新页面的item进行单独处理
- (void)isNoPushNewViewAtIndexPath:(NSIndexPath *)indexPath model:(ZYZhiFuBaoXueXiModel *)model {
    if ([model.pushViewName isEqualToString:@"GalenPayPasswordView"]) {
        GalenPayPasswordView *payPassword=[GalenPayPasswordView tradeView];
        [payPassword showInView:self.view.window];
        __block typeof(GalenPayPasswordView *) blockPay=payPassword;
        [payPassword setFinish:^(NSString * pwd) {
            
            [blockPay showProgressView:@"正在处理..."];
            
            [blockPay performSelector:@selector(showSuccess:) withObject:self afterDelay:3.0];
        }];
        
        [payPassword setLessPassword:^{
            NSLog(@"忘记密码？");
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 保存所有数据的最大数组（内部保存字典）
-(NSMutableArray *)allDataArr {
    if (!_allDataArr) {
        _allDataArr = [NSMutableArray array];
    }
    return _allDataArr;
}

//-(NSDictionary *)allDataDic {
//    if (!_allDataDic) {
//        _allDataDic = @{};
//    }
//    return _allDataDic;
//}
@end
