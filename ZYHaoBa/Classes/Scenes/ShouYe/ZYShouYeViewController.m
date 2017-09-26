//
//  ZYShouYeViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/11.
//  Copyright © 2016年 正羽. All rights reserved.
//

/* 本页面去plist文件更改数据即可完成
1、son字段和pushViewNames一一对应，即可完成跳转配置
2、需要增加学习记录，pushViewNames这个字段实际是txt的名字
*/

#import "ZYShouYeViewController.h"
#import "MyHeader.h"
// 学习记录
#import "XueXiJiLuVC.h"

@interface ZYShouYeViewController ()<UIScrollViewDelegate,MyHeaderDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataList;
// 所有标题行的字典
@property (strong, nonatomic) NSMutableDictionary *sectionDict;

@end

@implementation ZYShouYeViewController
/*
 1. 初始化数据
 2. 增加分组，并设置标题栏基本样式
 3. 自定义标题栏视图
 4. 添加自定义是视图中的按钮监听事件
 5. 自定义视图中的按钮被点击后，需要通知视图控制器做后续处理
 6. 处理展开折叠
 7. 定义一个数据字典，记录所有分组的展开折叠情况
 8. 根据展开折叠情况，刷新数组
 9. 箭头的旋转
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    // 1. 初始化数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ShouYeData" ofType:@"plist"];
    self.dataList = [NSArray arrayWithContentsOfFile:path];
    // 2. 设置标题行高
    [self.tableView setSectionHeaderHeight:kHeaderHeight];
    // 3. 设置表格行高
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setRowHeight:50];
    // 4. 初始化展开折叠字典
    self.sectionDict = [NSMutableDictionary dictionaryWithCapacity:self.dataList.count];
    // 5. 给表格注册可重用标题行
    [self.tableView registerClass:[MyHeader class] forHeaderFooterViewReuseIdentifier:@"MyHeader"];
}

#pragma mark 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 如果字典中分组对应的折叠状态，返回0，否则返回数组的数量
    //    BOOL isOpen = [self.sectionStates[@(section)]boolValue];
    MyHeader *header = self.sectionDict[@(section)];
    BOOL isOpen = header.isOpen;
    if (isOpen) {
        // 1. 从数组中取出sction对应字典
        NSDictionary *dict = self.dataList[section];
        
        // 2. 返回字典中数组的数量
        NSArray *array = dict[@"son"];
        
        return array.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ShouYe_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.numberOfLines = 0;
    }
    // 1. 从数组中取出indexPath.row对应的字典
    NSDictionary *dict = self.dataList[indexPath.section];
    // 2. 从字典中取出对应的数组
    NSArray *array = dict[@"son"];
    // 3. 填充表格内容
    [cell.textLabel setText:array[indexPath.row]];
    // 4. 设置第四个section无选中标记
    if (indexPath.section == 3) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 从数组中取出indexPath.row对应的字典
    NSDictionary *dict = self.dataList[indexPath.section];
    // 2. 从字典中取出对应的数组
    NSArray *array = dict[@"son"];
    CGFloat rowHeight = [ZYProTools getSizeOfText:array[indexPath.row] sizeBy:CGSizeMake(SCREEN_WIDTH - 30, 100) font:[UIFont systemFontOfSize:20]].height;
    if (rowHeight < 30) {
        rowHeight = 40;
    }
    return rowHeight;
}

#pragma mark 表格标题栏
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 如果要对标题栏进行优化，需要使用UITableViewHeaderFooterView类型的视图
    static NSString *HeaderID = @"MyHeader";
    // 1. 在缓冲池查找可重用的标题行
    //    MyHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
    // 从字典中读取标题行
    MyHeader *header = self.sectionDict[@(section)];
    if (header == nil) {
        xh(@"实例化标题栏");
        // 实例化表格标题，一定要用initWithReuseIdentifier方法
        header = [[MyHeader alloc]initWithReuseIdentifier:HeaderID];
        // 设置代理
        [header setDelegate:self];
        // 将自定义标题栏加入字典
        [self.sectionDict setObject:header forKey:@(section)];
    }
    
    NSDictionary *dict = self.dataList[section];
    NSString *groupName = dict[@"group"];
    [header.button setTitle:groupName forState:UIControlStateNormal];
    // 在标题栏自定义视图中记录对应的分组数
    [header setSection:section];
    return header;
}

#pragma mark 自定义标题栏代理方法
- (void)myHeaderDidSelectedHeader:(MyHeader *)header {
    xh(@"点击按钮 %d", header.section);
    // 处理展开折叠
    // 需要记录每个分组的展开折叠情况
    //    BOOL isOpen = [self.sectionStates[@(header.section)]boolValue];
    // 从字典中取出标题栏
    MyHeader *myHeader = self.sectionDict[@(header.section)];
    
    BOOL isOpen = myHeader.isOpen;
    [myHeader setIsOpen:!isOpen];
    //    [self.sectionStates setObject:@(!isOpen) forKey:@(header.section)];
    
    //    [header setIsOpen:!isOpen];
    // 刷新数据，以下代码是刷新全部数据
    //    [self.tableView reloadData];
    
    // 在tableView的开发中，如果可能，应该尽量避免去刷新全部数据
    // 本应用中，可以刷新指定分组
#warning 此处有陷阱
    // 注意：一旦刷新表格数据，表格中的标题行，会重新被实例化，而不会从缓存池中加载
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:header.section] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#pragma mark - 显示顺序 学习记录 视频学习 网络下载学习 没事测试
    // 1. 从数组中取出indexPath.row对应的字典
    NSDictionary *dict = self.dataList[indexPath.section];
    // 2. 从字典中取出对应的数组
    NSArray *array = dict[@"son"];
    NSArray *VCArray = dict[@"pushViewNames"];
    // 取出需要的值
    NSString *titleName = array[indexPath.row];
    NSString *VCName = VCArray[indexPath.row];

    if (indexPath.section == 0){
        XueXiJiLuVC * view = [[XueXiJiLuVC alloc] init];
        view.txtName = VCName;
        [self zypushWithViewCotroller:view pushViewTitle:titleName];
    } else {
        UIViewController *vc = [[NSClassFromString(VCName) alloc] init];
        if (vc == nil) {
            vc = [[UIViewController alloc] init];
            vc.title = @"控制器不存在";
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        [self zypushWithViewCotroller:vc pushViewTitle:titleName];
    }
}

- (void)zypushWithViewCotroller:(UIViewController *)VCName pushViewTitle:(NSString *)title {
    VCName.title = title;
    VCName.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VCName animated:YES];
}

#pragma mark 当应用程序出现内存警告时，控制器可以在此方法中，释放自己的资源
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
