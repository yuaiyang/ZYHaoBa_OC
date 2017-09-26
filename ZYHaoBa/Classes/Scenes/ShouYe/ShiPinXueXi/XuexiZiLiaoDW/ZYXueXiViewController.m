//
//  ZYXueXiViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/29.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYXueXiViewController.h"
#import "DuoXianChengViewController.h"
#import "NSOperationViewController.h"
#import "WangLuoQingQiuVC.h"
#import "ShuJuJiaMiVC.h"
#import "ShiPingBoFangTVC.h"
#import "DaWenJianXiaZaiVC.h"
#import "FengZhuangDaWenJianXiaZaiVC.h"
#import "WenJianJieYaVC.h"
#import "DuoXianChengDuanDianXiaZaiVC.h"
#import "WenJianShangChuanVC.h"
#import "GetCacheVC.h"
#import "WangLuoJianCeVC.h"
#import "WebViewShiYongVC.h"

@interface ZYXueXiViewController ()
@property (nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation ZYXueXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学习目录";
   
}

#pragma mark Table view data source UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"xuexi_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    隐藏cell直接的线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZYProTools getSizeOfText:_dataArray[indexPath.row] sizeBy:CGSizeMake(SCREEN_WIDTH - 30, 50) font:[UIFont systemFontOfSize:20]].height + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            DuoXianChengViewController * view = [[DuoXianChengViewController alloc] init];
            view.title = _dataArray[indexPath.row];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            NSOperationViewController * view = [[NSOperationViewController alloc] init];
            view.title = _dataArray[indexPath.row];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 2:
        {
            WangLuoQingQiuVC * view = [[WangLuoQingQiuVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 3:
        {
            ShuJuJiaMiVC * view = [[ShuJuJiaMiVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 4:
        {
            ShiPingBoFangTVC * view = [[ShiPingBoFangTVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 5:
        {
            // 暂时无法使用
            return;
        }
            break;
        case 6:
        {
            DaWenJianXiaZaiVC * view = [[DaWenJianXiaZaiVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 7:
        {
            FengZhuangDaWenJianXiaZaiVC * view = [[FengZhuangDaWenJianXiaZaiVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 8:
        {
            WenJianJieYaVC * view = [[WenJianJieYaVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 9:
        {
            DuoXianChengDuanDianXiaZaiVC * view = [[DuoXianChengDuanDianXiaZaiVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 10:
        {
            WenJianShangChuanVC * view = [[WenJianShangChuanVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 11:
        {
            GetCacheVC * view = [[GetCacheVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 12:
        {
            WangLuoJianCeVC * view = [[WangLuoJianCeVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 13:
        {
            WebViewShiYongVC * view = [[WebViewShiYongVC alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark--LazyLoading
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithObjects:@"0.多线程",@"1.NSOperation(读取plist文件,更改原有cell图片，label等位置)",@"2.网络请求",@"3.数据加密（shaXX解密有问题，无Key）",@"4.视频播放(使用KVC赋值存在id等关键字处理等问题)",@"5.XML解析(动态库加载配置，ARC库添加MRC使用配置，)",@"6.大文件下载(暂停，恢复，解压，断点下载)",@"7.大文件下载封装",@"8.文件下载解压",@"9.多线程断点下载（包含6，7，8内容；比较复杂,block简洁声明使用，只读属性使用...）",@"文件上传",@"get请求做缓存",@"网络监测",@"网页视图的使用", nil];
    }
    return _dataArray;
}

@end
