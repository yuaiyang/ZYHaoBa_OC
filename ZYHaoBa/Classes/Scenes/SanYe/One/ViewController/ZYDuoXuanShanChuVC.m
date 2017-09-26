//
//  ZYDuoXuanShanChuVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYDuoXuanShanChuVC.h"

@interface ZYDuoXuanShanChuVC ()<UITableViewDelegate,UITableViewDataSource>

{
    UIBarButtonItem *editBtn;
    UIBarButtonItem *deleteBtn;
    UIBarButtonItem *allselect;
}
@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic ,retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableDictionary *deleteDic;

@end

@implementation ZYDuoXuanShanChuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    self.deleteDic = [[NSMutableDictionary alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self setRightNavgationBtn];
}

#pragma mark 设置右按钮数组
- (void)setRightNavgationBtn {
    editBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:(UIBarButtonItemStylePlain) target:self action:@selector(didClickEditData)];
    allselect = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:self action:@selector(didClickAllselect)];
    deleteBtn = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:(UIBarButtonItemStylePlain) target:self action:@selector(didClickDeleteAction)];
    allselect.enabled = NO;
    
    self.navigationItem.rightBarButtonItems = @[deleteBtn,editBtn,allselect];
}

#pragma markAction-

- (void)didClickEditData {
    if ([editBtn.title isEqualToString:@"编辑"]) {
        editBtn.title = @"确定";
        [self.tableView setEditing:YES animated:YES];
        allselect.enabled = YES;
        allselect.title = @"全选";
    } else {
        editBtn.title = @"编辑";
        [_deleteDic removeAllObjects];
        [self.tableView setEditing:NO animated:YES];
        allselect.enabled = NO;
        allselect.title = @"";
    }
}

- (void)didClickDeleteAction {
    [_dataArray removeObjectsInArray:[_deleteDic allKeys]];
    
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithArray:[_deleteDic allValues]] withRowAnimation:UITableViewRowAnimationFade];
    [_deleteDic removeAllObjects];
}

- (void)didClickAllselect {
    for (int row=0; row<_dataArray.count; row++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [_deleteDic setObject:indexPath forKey:[_dataArray objectAtIndex:indexPath.row]];
    }
}


#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"duoXianChen_Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    xh(@"选中");
    if ([editBtn.title isEqualToString:@"确定"]) {
        [_deleteDic setObject:indexPath forKey:[_dataArray objectAtIndex:indexPath.row]];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([editBtn.title isEqualToString:@"确定"]) {
        [_deleteDic removeObjectForKey:[_dataArray objectAtIndex:indexPath.row]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
