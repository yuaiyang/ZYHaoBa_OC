
//
//  MineViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "MineViewController.h"
/** 存放数据模型的数组模型 */
#import "ZYCommonGroup.h"
/** 基类模型 其他模型在他基础上进行 */
#import "ZYCommonItem.h"
/** 根据模型设置每个cell的样式 */
#import "ZYCommonCell.h"
/** 模型-最右边的箭头 */
#import "ZYCommonArrowItem.h"
/** 模型-最右边的开关 */
#import "ZYCommonSwitchItem.h"
/** 模型-最右边的文字显示 */
#import "ZYCommonLabelItem.h"
/** 点击设置跳转设置VC */
#import "ZYSetViewController.h"


@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    // 初始化模型数据
    [self setupGroups];
    // 设置“退出登录”
    [self setupFooter];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
}

- (void)setting
{
    ZYSetViewController *setting = [[ZYSetViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)setupFooter
{
    // 1.创建按钮
    UIButton *logout = [[UIButton alloc] init];
    
    // 2.设置属性
    logout.titleLabel.font = [UIFont systemFontOfSize:14];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:RGBCOLOR(255, 10, 10) forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置尺寸(tableFooterView和tableHeaderView的宽度跟tableView的宽度一样)
    logout.height = 35;
    
    self.tableView.tableFooterView = logout;
}

/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
    ZYCommonGroup *group = [ZYCommonGroup group];
    
    [self.groups addObject:group];
    
    // 设置组的基本数据
    group.header = @"第0组viewController显示头部";
    group.footer = @"第0组viewController显示尾部的详细信息";
    
    // 2.设置组的所有行数据
    ZYCommonArrowItem *newFriend = [ZYCommonArrowItem itemWithTitle:@"新的好友" icon:@"new_friend"];
    newFriend.badgeValue = @"5";
    newFriend.operation = ^{
        xh(@"点击cell想要操作的事，可以在这里面写");
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击cell想要操作的事，可以在这里面写" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            xh(@"点击确定后想做的事");
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    };
    
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    // 1.创建组
    ZYCommonGroup *group = [ZYCommonGroup group];
    [self.groups addObject:group];
    
    // 设置组的基本数据
    group.header = @"第1组viewController显示头部";
    group.footer = @"第1组viewController显示尾部的详细信息";
    
    // 2.设置组的所有行数据
    ZYCommonArrowItem *album = [ZYCommonArrowItem itemWithTitle:@"我的相册" icon:@"album"];
    album.subtitle = @"(100)";
    album.operation = ^{
        xh(@"点击cell用block执行其他事件，提示：跳转视图用以下方法；album.destVcClass = [ZYSetViewController class];");
    };
    album.destVcClass = [ZYSetViewController class];
    
    ZYCommonArrowItem *collect = [ZYCommonArrowItem itemWithTitle:@"我的收藏" icon:@"collect"];
    collect.subtitle = @"(10)";
    collect.badgeValue = @"1";
    album.operation = ^{
        xh(@"点击cell用block执行其他事件，提示，跳当前页面");
    };
    collect.destVcClass = [MineViewController class];
    
    ZYCommonArrowItem *like = [ZYCommonArrowItem itemWithTitle:@"赞" icon:@"like"];
    like.subtitle = @"(36)";
    like.badgeValue = @"10000";
    like.destVcClass = [MineViewController class];
    
    group.items = @[album, collect, like];
}

- (void)setupGroup2
{
    // 1.创建组
    ZYCommonGroup *group = [ZYCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    ZYCommonArrowItem *album = [ZYCommonArrowItem itemWithTitle:@"找人" icon:@"album"];
    album.subtitle = @"(名人，有意思的人都在这里)";
    
    ZYCommonArrowItem *collect = [ZYCommonArrowItem itemWithTitle:@"游戏中心" icon:@"collect"];
    
    ZYCommonArrowItem *like = [ZYCommonArrowItem itemWithTitle:@"周边" icon:@"like"];
    like.badgeValue = @"10000000";
    
    ZYCommonArrowItem *newFriend = [ZYCommonArrowItem itemWithTitle:@"帐号管理"];
    
    ZYCommonLabelItem *readMdoe = [ZYCommonLabelItem itemWithTitle:@"阅读模式"];
    readMdoe.text = @"有图模式";
    
    ZYCommonSwitchItem *video = [ZYCommonSwitchItem itemWithTitle:@"视频0" icon:@"like"];
    video.operation = ^{
        xh(@"----点击了视频---");
    };
    
    ZYCommonSwitchItem *video1 = [ZYCommonSwitchItem itemWithTitle:@"视频1"];
    video.operation = ^{
        xh(@"----点击了视频1---");
    };
    
    group.items = @[album, collect, like, newFriend, readMdoe, video, video1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
