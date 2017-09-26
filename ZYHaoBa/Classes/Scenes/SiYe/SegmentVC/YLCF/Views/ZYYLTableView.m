
//
//  ZYYLTableView.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYYLTableView.h"
#import "ZYCommonGroup.h"
#import "ZYCommonItem.h"
#import "ZYCommonCell.h"
#import "ZYCommonArrowItem.h"
#import "ZYCommonSwitchItem.h"
#import "ZYCommonLabelItem.h"

#import "NSString+Extension.h"

@interface ZYYLTableView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView * tableView;
/** 创建一个可变数组作为数据源*/
@property (nonatomic, strong)NSMutableArray * groups;

@end

@implementation ZYYLTableView

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupGroups];
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        // 设置tableView属性
        _tableView.backgroundColor = ZYMAINCOLOER;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        // cell之间的间距
        _tableView.sectionFooterHeight = 10;
        _tableView.sectionHeaderHeight = 0;
        _tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
        [self addSubview:_tableView];
    }
    return self;
}

#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZYCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYCommonCell *cell = [ZYCommonCell cellWithTableView:tableView];
    ZYCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    // 设置cell所处的行号 和 所处组的总行数
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZYCommonGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZYCommonGroup *group = self.groups[section];
    return group.header;
}

#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出这行对应的item模型
    ZYCommonGroup *group = self.groups[indexPath.section];
    ZYCommonItem *item = group.items[indexPath.row];
    
    // 2.判断有无需要跳转的控制器
//    if (item.destVcClass) {
//        UIViewController *destVc = [[item.destVcClass alloc] init];
//        destVc.title = item.title;
//        [self.navigationController pushViewController:destVc animated:YES];
//    }
    
    // 3.判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }
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
    group.header = @"第0组view显示头部";
    group.footer = @"第0组view显示尾部的详细信息";
    
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
//        [self presentViewController:alert animated:YES completion:nil];
    };
    
    // 2.设置组的所有行数据
    ZYCommonArrowItem *clearCache = [ZYCommonArrowItem itemWithTitle:@"清除图片缓存"];
    // 设置缓存的大小
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    [caches stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
//    NSString *imageCachePath = [SDImageCache sharedImageCache].diskCachePath;
    long long fileSize = [caches fileSize];
    
    clearCache.subtitle = [NSString stringWithFormat:@"(%.1fM)", fileSize / (1000.0 * 1000.0)];
    
    __weak typeof(clearCache) weakClearCache = clearCache;
    __weak typeof(self) weakVc = self;
    clearCache.operation = ^{
        
        // 清除缓存
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr removeItemAtPath:caches error:nil];
        
        // 设置subtitle
        weakClearCache.subtitle = nil;
        
        // 刷新表格
        [weakVc.tableView reloadData];
    };

    
    group.items = @[newFriend, clearCache];
}

- (void)setupGroup1
{
    // 1.创建组
    ZYCommonGroup *group = [ZYCommonGroup group];
    [_groups addObject:group];
    
    // 设置组的基本数据
    group.header = @"第1组view显示头部";
    group.footer = @"第1组view显示尾部的详细信息";
    
    // 2.设置组的所有行数据
    ZYCommonArrowItem *album = [ZYCommonArrowItem itemWithTitle:@"我的相册" icon:@"album"];
    album.subtitle = @"(100)";
    album.operation = ^{
        xh(@"点击cell用block执行其他事件，提示：跳转视图用以下方法；album.destVcClass = [ZYSetViewController class];");
    };
//    album.destVcClass = [ZYSetViewController class];
    
    ZYCommonArrowItem *collect = [ZYCommonArrowItem itemWithTitle:@"我的收藏" icon:@"collect"];
    collect.subtitle = @"(10)";
    collect.badgeValue = @"1";
    album.operation = ^{
        xh(@"点击cell用block执行其他事件，提示，跳当前页面");
    };
//    collect.destVcClass = [MineViewController class];
    
    ZYCommonArrowItem *like = [ZYCommonArrowItem itemWithTitle:@"赞" icon:@"like"];
    like.subtitle = @"(36)";
    like.badgeValue = @"10000";
//    like.destVcClass = [MineViewController class];
    
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



@end
