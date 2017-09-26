//
//  TaobaoViewController.m
//  allinone
//
//  Created by Johnil on 16/2/25.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "TaobaoViewController.h"

static NSString *cellIdentifier = @"cell";

@interface TaobaoViewController() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation TaobaoViewController {
    UITableView *_tbView;
}

-  (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    _tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.tableFooterView = [UIView new];
    [_tbView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_tbView];
    
    UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    UIImageView *headline = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tb_headline"]];
    [tableHeader addSubview:headline];
    UIImageView *subHead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tb_subHead"]];
    subHead.y = headline.height;
    [tableHeader addSubview:subHead];
    tableHeader.height = headline.height+subHead.height;
    _tbView.tableHeaderView = tableHeader;
    
    UIImageView *navi = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tb_navi"]];
    [self.view addSubview:navi];
    
    UIImageView *tab = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tb_tabbar"]];
    tab.y = self.view.height-tab.height;
    [self.view addSubview:tab];
    
    _tbView.contentInset = UIEdgeInsetsMake(navi.height, 0, tab.height, 0);
    _tbView.scrollIndicatorInsets = _tbView.contentInset;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell.contentView subviewWithTag:1];
    if (imageView==nil) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.tag = 1;
        [cell.contentView addSubview:imageView];
    }
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"tb_sec%ld", indexPath.section]];
    imageView.frame = CGRectMake(0, 0, cell.width, imageView.image.size.height);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [UIImage imageNamed:[NSString stringWithFormat:@"tb_sec%ld_header", section]].size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return [UIImage imageNamed:@"tb_sec3_footer"].size.height;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"tb_sec%ld_header", section]]];
    return imgView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==2) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tb_sec3_footer"]];
        return imgView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIImage imageNamed:[NSString stringWithFormat:@"tb_sec%ld", indexPath.section]].size.height;
}

@end
