//
//  MultiCellStyleTableViewController.m
//  allinone
//
//  Created by Johnil on 16/2/25.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "MultiCellStyleTableViewController.h"

static NSString *cellIdentifier1 = @"JDTableViewCell1";
static NSString *cellIdentifier2 = @"JDTableViewCell2";
static NSString *cellIdentifier3 = @"JDTableViewCell3";

@implementation MultiCellStyleTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.tableView registerClass:NSClassFromString(cellIdentifier1) forCellReuseIdentifier:cellIdentifier1];
    [self.tableView registerClass:NSClassFromString(cellIdentifier2) forCellReuseIdentifier:cellIdentifier2];
    [self.tableView registerClass:NSClassFromString(cellIdentifier3) forCellReuseIdentifier:cellIdentifier3];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [NSString stringWithFormat:@"JDTableViewCell%ld", indexPath.section+1];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIImage imageNamed:[NSString stringWithFormat:@"jd_cell%ld", indexPath.section+1]].size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

@end
