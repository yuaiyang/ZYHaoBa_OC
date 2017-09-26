//
//  FSScrollViewNestTableView.m
//  ZYHaoBa
//
//  Created by 一路财富 on 2017/9/26.
//  Copyright © 2017年 正羽. All rights reserved.
//

#import "FSScrollViewNestTableView.h"
#import "FSBaseViewController.h"

#import "FSBaselineTableViewCell.h"
#import "FSLoopScrollView.h"

@interface FSScrollViewNestTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView* tableView;

@end

@implementation FSScrollViewNestTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一页" style:(UIBarButtonItemStylePlain) target:self action:@selector(btnClick)];
    
    // 单独一个喇叭循环
//    FSLoopScrollView *loopView = [FSLoopScrollView loopTitleViewWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 50) isTitleView:YES titleImgArr:@[@"avatar_vgirl",@"avatar_enterprise_vip",@"avatar_vgirl",@"avatar_vgirl",@"avatar_enterprise_vip"]];
//    loopView.titlesArr = @[@"这是一个简易的文字轮播",
//                           @"This is a simple text rotation",
//                           @"นี่คือการหมุนข้อความที่เรียบง่าย",
//                           @"Это простое вращение текста",
//                           @"이것은 간단한 텍스트 회전 인"];
//    loopView.tapClickBlock = ^(FSLoopScrollView *loopView){
//        NSString *message = [NSString stringWithFormat:@"老%ld被点啦",(long)loopView.currentIndex+1];
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"大顺啊" message:message delegate:self cancelButtonTitle:@"love you" otherButtonTitles:nil, nil];
//        [alert show];
//    };
//    [self.view addSubview:loopView];
    
    // 都有
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *FSBaselineTableViewCellIdentifier = @"FSBaselineTableViewCellIdentifier";
    FSBaselineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FSBaselineTableViewCellIdentifier];
    if (!cell) {
        cell = [[FSBaselineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FSBaselineTableViewCellIdentifier];
    }
    return cell;
}

- (void)btnClick
{
    [self.navigationController pushViewController:[[FSBaseViewController alloc]init] animated:YES];
}

@end
