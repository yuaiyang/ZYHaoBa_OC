//
//  UsedTableViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "UsedTableViewController.h"
#import "UsedTableViewCell.h"

static NSString *ID_cell = @"Used_Cell";

@interface UsedTableViewController ()
{
    UIBarButtonItem *rightAllButton;
    UIBarButtonItem *rightButton;
    UIBarButtonItem *deleteButton;
}
@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong)NSMutableArray * deleteArray;

@property(nonatomic, assign)BOOL cellBtnIsSelected;
@property(nonatomic, assign)BOOL cellBtnIsEnabled;

@end

@implementation UsedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellBtnIsSelected = NO;
    _cellBtnIsEnabled = NO;
    // Do any additional setup after loading the view.
    rightAllButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(allSelectedBtn)];
    rightButton = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(selectedBtn:)];
    
    deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:(UIBarButtonItemStyleDone) target:self action:@selector(didClickDeleteBtnItem)];
    deleteButton.enabled = NO;
    
    self.navigationItem.rightBarButtonItems = @[rightButton,deleteButton,rightAllButton];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UsedTableViewCell" bundle:nil] forCellReuseIdentifier:ID_cell];
}

// 点击删除
- (void)didClickDeleteBtnItem {
    xh(@"删除前的dataArray：%@",self.dataArray);
    xh(@"要删除的deleteArray：%@",self.deleteArray);
    [self.dataArray removeObjectsInArray:self.deleteArray];
    xh(@"删除后的dataArray：%@",self.dataArray);
    _cellBtnIsSelected = NO;
    
    NSString *str = [_deleteArray componentsJoinedByString:@","];
    
    xh(@"需要删除的数组：%@",str);
    // 完成后需要自动点击取消
    [self selectedBtn:rightButton];
    
    [self.tableView reloadData];
    // 上传服务器 服务器删除数据
}

//点击全选
- (void)allSelectedBtn {
    _cellBtnIsSelected = YES;
    
    [self.tableView reloadData];
    self.deleteArray = [NSMutableArray arrayWithArray:_dataArray];
    // 判断删除数组是否为空
    if (_deleteArray.count != 0) {
        deleteButton.enabled = YES;
    } else {
        deleteButton.enabled = NO;
    }
}
//点击编辑
- (void)selectedBtn:(UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"编辑"]) {
        _cellBtnIsEnabled = YES;
        rightAllButton.title = @"全选";
        rightButton.title = @"取消";
        [self.tableView reloadData];
    } else {
        _cellBtnIsEnabled = NO;
        deleteButton.enabled = NO;
        rightAllButton.title = @"";
        rightButton.title = @"编辑";
        // 点击取消 那么所有选中都需要取消
        _cellBtnIsSelected = NO;
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning 111111
    //    [self.dataArray removeAllObjects];
    //    // 如果数据源数组为空 那么编辑按钮也不显示
    //    if (self.dataArray.count == 0) {
    //        rightButton.title = @"";
    //    }
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UsedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_cell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellBtn.enabled = _cellBtnIsEnabled;
    cell.cellBtn.selected = _cellBtnIsSelected;
    cell.index = indexPath;
    cell.label1.text = self.dataArray[indexPath.row];
    __weak UsedTableViewController *weakSelf = self;
    cell.chooseBlock = ^(NSIndexPath *index,NSString *ID,BOOL isSelected){
        [weakSelf editorRowAtIndexPath:index ID:ID selected:isSelected];
    };
    return cell;
}

#pragma mark 回调block方法实现数据添加存储
- (void)editorRowAtIndexPath:(NSIndexPath *)indexPath ID:(NSString *)ID selected:(BOOL)selected {
    if (selected) {
        [self.deleteArray addObject:ID];
        xh(@"选中：%@",_deleteArray);
    } else {
        [self.deleteArray removeObject:ID];
        xh(@"未选中：%@",_deleteArray);
    }
    // 当删除数组没有数据时 删除按钮不可点击
    if (_deleteArray.count != 0) {
        deleteButton.enabled = YES;
    } else {
        deleteButton.enabled = NO;
    }
    //    xh(@"=======第%ld行,ID:%@选择：%d",(long)indexPath.row,ID,selected);
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(NSMutableArray *)deleteArray {
    if (!_deleteArray) {
        _deleteArray = [NSMutableArray array];
    }
    return _deleteArray;
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"23",@"13"];
        _dataArray = [NSMutableArray arrayWithArray:array];
    }
    return _dataArray;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"23",@"13"]];
}

@end
