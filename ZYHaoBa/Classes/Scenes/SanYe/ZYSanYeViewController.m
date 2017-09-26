//
//  ZYSanYeViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/11.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYSanYeViewController.h"
#import "ZYSOViewController.h"
#import "PhotoViewController.h"
#import "ZYKeyboardToolVC.h"
#import "ZYDatePickerVC.h"
#import "JPCLViewController.h"
#import "ZYSingletonTool.h"
#import "ZYNetTool.h"
#import "ZYAlertVC.h"
#import "ZYAnimationVC.h"
#import "ZYDuoXuanShanChuVC.h"

#import "ChaoJiCaiTuVC.h"
#import "BrickViewController.h"
#import "ZY2048ViewController.h"
#import "YLLBTTableViewController.h"
#import "PlayVidioViewController.h"

@interface ZYSanYeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSArray * sectionArr;
@property (nonatomic, strong)NSArray * rowArr;
@property (nonatomic, strong)NSArray * rowArr1;
@property (nonatomic, strong)NSArray * rowArrOfSwift;

@end

@implementation ZYSanYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标题目录";
    [self.view addSubview:self.tableView];
}

#pragma mark tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
       return self.rowArr.count;
    } else if (section == 1) {
        return self.rowArr1.count;
    } else {
        return self.rowArrOfSwift.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [ZYProTools getSizeOfText:_rowArr[indexPath.row] sizeBy:CGSizeMake(SCREEN_WIDTH - 30, 100) font:[UIFont systemFontOfSize:20]].height + 20;
    } else if (indexPath.section == 1) {
        return [ZYProTools getSizeOfText:_rowArr1[indexPath.row] sizeBy:CGSizeMake(SCREEN_WIDTH - 30, 100) font:[UIFont systemFontOfSize:20]].height + 20;
    } else {
        return [ZYProTools getSizeOfText:_rowArrOfSwift[indexPath.row] sizeBy:CGSizeMake(SCREEN_WIDTH - 30, 100) font:[UIFont systemFontOfSize:20]].height + 20;;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"san_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = _rowArr[indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = _rowArr1[indexPath.row];
    } else {
        cell.textLabel.text = _rowArrOfSwift[indexPath.row];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 20)];
    [label setTextColor:[UIColor redColor]];
    label.text = _sectionArr[section];
    return (UIView *)label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self didSelectRowAtIndexPathSectionOne:indexPath];
    } else if (indexPath.section == 1) {
        [self didSelectRowAtIndexPathSectionTwo:indexPath];
    } else if (indexPath.section == 2) {
        [self didSelectRowAtIndexPathSectionThree:indexPath];
    }
}

#pragma mark 点击第一个section中的row
- (void)didSelectRowAtIndexPathSectionOne:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            // 宏定义跳转
            PUSHVIEW_ZY(SOViewController);
            //                ZYSOViewController * view = [[ZYSOViewController alloc] init];
            //                view.title = _rowArr[indexPath.row];
            //                [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            PhotoViewController * view = [[PhotoViewController alloc] init];
            view.title = _rowArr[indexPath.row];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 2:
        {
            ZYKeyboardToolVC * view = [[ZYKeyboardToolVC alloc] init];
            view.title = _rowArr[indexPath.row];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 3:
        {
            ZYDatePickerVC * view = [[ZYDatePickerVC alloc] init];
            view.title = _rowArr[indexPath.row];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 4:
        {
            // 2) 弹出提示框，显示当前选中的商品名称
            // 除了取消按钮外，提示框中可以有多个按钮
            // 1> 如果一共只有一个按钮，将取消按钮的文字设置成"确定"
            // 2> 如果一共只有两个按钮，将otherButton的第一个按钮设置位"确定"
            // 3> 如果超过三个按钮，会纵向排列
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"标题" message:@"信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            // 2.1 设置alertView的属性
            // 1> 提示框样式，仅适用于输入一条文本，如果需要输入复杂信息，需要弹出其他的视图控制器
            
            [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
            // 2> 将商品信息设置给提示框中的文本框
            UITextField *textFiled = [alertView textFieldAtIndex:0];
            [textFiled setText:@"输入内容"];
            // 3> 使用alertView的tag记录用户选择的行
            //    [alertView setTag:indexPath.row];
            
            [alertView show];
            // 3) 在弹出的提示框中修改数据
            // 4) 在提示框中"确定"，保存数据
        }
            break;
        case 5:
        {
            JPCLViewController * view = [[JPCLViewController alloc] init];
            view.title = _rowArr[indexPath.row];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 6:
        {
            ZYSingletonTool *tool1 = [ZYSingletonTool sharedSingletonTool];
            ZYSingletonTool *tool2 = [ZYSingletonTool sharedSingletonTool];
            ZYSingletonTool *tool3 = [[ZYSingletonTool alloc] init];
            ZYSingletonTool *tool4 = [[ZYSingletonTool alloc] init];
            xh(@"一样就对啦---tool1地址：%p, tool2地址：%p, tool3地址：%p, tool4地址：%p,",tool1,tool2,tool3,tool4);
            
            ZYNetTool *netTool1 = [ZYNetTool sharedNetTool];
            ZYNetTool *netTool2 = [ZYNetTool sharedNetTool];
            ZYNetTool *netTool3 = [[ZYNetTool alloc] init];
            ZYNetTool *netTool4 = [[ZYNetTool alloc] init];
            xh(@"和tool的不一样就对啦---netTool1地址：%p, netTool2地址：%p, netTool3地址：%p, netTool4：%p,",netTool1,netTool2,netTool3,netTool4);
            
        }
            break;
        case 7:
        {
            ZYAlertVC * view = [[ZYAlertVC alloc] init];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 8:
        {
            ZYAnimationVC * view = [[ZYAnimationVC alloc] init];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 9:
        {
            ZYDuoXuanShanChuVC * view = [[ZYDuoXuanShanChuVC alloc] init];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 点击第二个section中的row
- (void)didSelectRowAtIndexPathSectionTwo:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            ChaoJiCaiTuVC * view = [[ChaoJiCaiTuVC alloc] init];
            view.title = _rowArr1[indexPath.row];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            BrickViewController * view = [[BrickViewController alloc] init];
            view.title = _rowArr1[indexPath.row];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 2:
        {
            ZY2048ViewController * view = [[ZY2048ViewController alloc] init];
            view.title = _rowArr1[indexPath.row];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 3:
        {
            YLLBTTableViewController * view = [[YLLBTTableViewController alloc] init];
            view.title = _rowArr1[indexPath.row];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 4:
        {
            PlayVidioViewController * view = [[PlayVidioViewController alloc] init];
            view.title = _rowArr1[indexPath.row];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
            case 5:
        {
            // 获取设备UUID
            NSString *uuid1 = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            NSString *uuid2 = [ZYProTools uuid];
            NSString *uuid3 = [ZYProTools stringWithUUID];
            
            [ZYProTools showLeftAlineAlertViewWithTitle:@"UUID" Msg:[NSString stringWithFormat:@"1、uuid1 = ‘%@’\n2、uuid2 = ‘%@’\n3、uuid3 = ‘%@’",uuid1,uuid2,uuid3] withLeftText:@"取消" withRightText:@"确定" rightHandler:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark 点击第三个section中的row
- (void)didSelectRowAtIndexPathSectionThree:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            xh(@"dsfdfdsfdf");
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 懒加载
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNav_HEIGHT - kTab_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSArray *)sectionArr {
    if (!_sectionArr) {
        _sectionArr = @[@"常用功能",@"一般游戏",@"swift学习"];
    }
    return _sectionArr;
}

-(NSArray *)rowArr {
    if (!_rowArr) {
        _rowArr = @[@"测试Https数据请求（证书处理）",@"1.获取系统相片",@"2.自定义KeyboardTool",@"3.时间选择器",@"4.提示框设置可输入信息",@"5.键盘处理",@"6.创建单利（宏），查看指针类型地址可以分辨",@"7.iOS 8.0后提示框",@"8.动画视图测试",@"9.多选删除"];
    }
    return _rowArr;
}

-(NSArray *)rowArr1 {
    if (!_rowArr1) {
        _rowArr1 = @[@"超级猜图",@"1.打砖块",@"2.2048",@"3.一路轮播图",@"4.视频播放（隐藏导航栏）",@"5.获取UUID"];
    }
    return _rowArr1;
}

-(NSArray *)rowArrOfSwift {
    if (!_rowArrOfSwift) {
        _rowArrOfSwift = @[@"swift学习"];
    }
    return _rowArrOfSwift;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
