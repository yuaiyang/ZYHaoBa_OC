//
//  ConfigTableViewController.m
//  allinone
//
//  Created by Johnil on 16/2/24.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "ConfigTableViewController.h"

static NSString *cellIdentifier = @"customCell";

@interface ConfigTableViewController() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ConfigTableViewController{
    NSArray *_datas;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"颜色配置";
    
    _datas = @[@0,@0x01d2cd,@0xe40947,@0x095be4,@0x66e409,@0xe45609];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView1{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if ([_datas[indexPath.row] integerValue]==0) {
        cell.textLabel.text = @"默认";
    } else {
        cell.imageView.image = [UIImage imageWithColor:UIColorFromRGB([_datas[indexPath.row] unsignedLongLongValue]) size:CGSizeMake(40, 40)];
        cell.textLabel.text = [NSString stringWithFormat:@"0x%llX", [_datas[indexPath.row] unsignedLongLongValue]];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_datas[indexPath.row] integerValue]==0) {
        /**
         *  Use the UIAppearance protocol to get the appearance proxy for a class. You can customize the appearance of instances of a class by sending appearance modification messages to the class’s appearance proxy
         */
        [[UINavigationBar appearance] setTitleTextAttributes:nil];
        [[UINavigationBar appearance] setBarTintColor:nil];
        [[UITextView appearance] setTintColor:nil];
        [[UIToolbar appearance] setTintColor:nil];
        [[UITextField appearance] setTintColor:nil];
        self.navigationController.navigationBar.barTintColor = nil;
        self.navigationController.navigationBar.titleTextAttributes = nil;
        self.navigationController.navigationBar.tintColor = nil;
    } else {
        UIColor *color = UIColorFromRGB([_datas[indexPath.row] unsignedLongLongValue]);
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [[UINavigationBar appearance] setBarTintColor:color];
        [[UITextView appearance] setTintColor:color];
        [[UIToolbar appearance] setTintColor:color];
        [[UITextField appearance] setTintColor:color];
        self.navigationController.navigationBar.barTintColor = color;
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
}

@end
