//
//  UIJiChuXueXiTVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/26.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "UIJiChuXueXiTVC.h"
#import "ButtonShiYongVC.h"
#import "TuPianChaKanQiVC.h"
#import "JiuGongGeVC.h"
#import "JiuGongGeModel.h"

@interface UIJiChuXueXiTVC ()
@property (nonatomic, strong)NSMutableArray * allDataArr;
@end

@implementation UIJiChuXueXiTVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UIJiChuXueXiTVC_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.allDataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            ButtonShiYongVC * view = [[ButtonShiYongVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            TuPianChaKanQiVC * view = [[TuPianChaKanQiVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 2:
        {
             JiuGongGeVC* view = [[JiuGongGeVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 懒加载
-(NSMutableArray *)allDataArr {
    if (!_allDataArr) {
        _allDataArr = [NSMutableArray arrayWithObjects:@"入门（内部有枚举）",@"图片查看器",@"九宫格（数据模型封装处理）",@"应用程序管理，",@"超级猜图", nil];
    }
    return _allDataArr;
}
@end
