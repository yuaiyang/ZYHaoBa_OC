//
//  DuoXuanshanChuCellTVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/22.
//  Copyright © 2016年 正羽. All rights reserved.
//  本页还可以直接跳转 可以删除页面

#import "DuoXuanshanChuCellTVC.h"
#import "ProductTableViewCell.h"
#import "Product.h"
//跳转的删除页面
#import "UsedTableViewController.h"

#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(100)]

@interface DuoXuanshanChuCellTVC ()<UITableViewDelegate,UITableViewDataSource>


{
    //展示数据源数组
    NSMutableArray *dataArray;
    //全选按钮
    UIButton *selectAll;
    //是否全选
    BOOL isSelect;
    
    //已选的商品集合
    NSMutableArray *selectGoods;
}

@end

@implementation DuoXuanshanChuCellTVC

-(void)viewWillAppear:(BOOL)animated
{
    //每次进入购物车的时候把选择的置空
    [selectGoods removeAllObjects];
    isSelect = NO;
    selectAll.selected = NO;
    [self creatData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc]init];
    selectGoods = [[NSMutableArray alloc]init];
    [self setNav];
    [self createTableView];
}

- (void)createTableView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = 0;
    self.tableView.rowHeight = 50;
    
    [self createTopView];
}

- (void)createTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [label setText:@"全部"];
    [label setTextColor:[UIColor redColor]];
    label.textAlignment = NSTextAlignmentLeft;
    label.frame = CGRectMake(15, 20, 220, 20);
    [topView addSubview:label];
    
    //全选按钮
    selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:15];
    [selectAll setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    selectAll.frame = CGRectMake(15, 10, SCREEN_WIDTH - 30, 30);
    [selectAll setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateSelected];
    //    selectAll.backgroundColor = [UIColor lightGrayColor];
    [selectAll setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //
    [selectAll setTitle:@"        " forState:UIControlStateNormal];
    selectAll.imageEdgeInsets = UIEdgeInsetsMake(0,SCREEN_WIDTH - 50,0,selectAll.titleLabel.bounds.size.width);
    [topView addSubview:selectAll];
    
    
    topView.backgroundColor = [UIColor whiteColor];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:line];
    
    self.tableView.tableHeaderView = topView;
}

-(void)selectAllBtnClick:(UIButton*)button
{
    //点击全选时,把之前已选择的全部删除
    [selectGoods removeAllObjects];
    
    button.selected = !button.selected;
    isSelect = button.selected;
    if (isSelect) {
        
        for (Product *model in dataArray) {
            [selectGoods addObject:model];
        }
        
    }
    else
    {
        [selectGoods removeAllObjects];
        
    }
    
    [self.tableView reloadData];
}

#pragma mark uitableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier=@"ProductTableViewCell";
    ProductTableViewCell *productcell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (productcell == nil) {
        productcell = [[ProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    productcell.selectionStyle=UITableViewCellSelectionStyleNone;
    productcell.isSelected = isSelect;
    //是否被选中
    if ([selectGoods containsObject:[dataArray objectAtIndex:indexPath.row]]) {
        productcell.isSelected = YES;
    }
    
    productcell.cartBlock = ^(BOOL isSelec){
        
        if (isSelec) {
            [selectGoods addObject:[dataArray objectAtIndex:indexPath.row]];
        }
        else
        {
            [selectGoods removeObject:[dataArray objectAtIndex:indexPath.row]];
        }
        
        if (selectGoods.count == dataArray.count) {
            selectAll.selected = YES;
        }
        else
        {
            selectAll.selected = NO;
        }
        
    };
    [productcell reloadDataWith:[dataArray objectAtIndex:indexPath.row]];
    
    return productcell;
    
}

-(void)creatData
{
    for (int i = 0; i < 10; i++) {
        Product *model = [[Product alloc]init];
        model.nameStr = MJRandomData;
        [dataArray addObject:model];
    }
    
}


#pragma mark ---配置导航条
- (void)setNav{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *additionBtn = [[UIButton alloc] init];
    [additionBtn setTitle:@"保存" forState:UIControlStateNormal];
    additionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [additionBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [additionBtn addTarget:self action:@selector(saveClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    additionBtn.frame = CGRectMake(0, 0, 40, 25);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:additionBtn];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:(UIBarButtonItemStylePlain) target:self action:@selector(didClickRightItem)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item];
}

- (void)didClickRightItem {
    UsedTableViewController * view = [[UsedTableViewController alloc] init];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
}

- (void)saveClickBtn:(UIButton *)btn {
    xh(@"保存");
    NSString *str= @"";
    for (int i = 0; i < selectGoods.count ; i++) {
        Product *model = [[Product alloc]init];
        model = selectGoods[i];
        str = [str stringByAppendingString:model.nameStr];
        
        
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"保存结果：%@", str] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
