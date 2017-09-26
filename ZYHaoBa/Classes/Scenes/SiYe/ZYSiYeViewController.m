//
//  ZYSiYeViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/11.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYSiYeViewController.h"
#import "ZYSetViewController.h"
#import "ZYMsgViewController.h"
#import "MineViewController.h"

#import "ZYCommonGroup.h"
#import "ZYCommonItem.h"
#import "ZYCommonCell.h"
#import "ZYCommonArrowItem.h"
#import "ZYCommonSwitchItem.h"
#import "ZYCommonLabelItem.h"

#import "ZYYLTableView.h"


@interface ZYSiYeViewController ()

@property (nonatomic, retain)ZYYLTableView * YLView;
//@property (nonatomic, strong) NSMutableArray *groups;

@property (nonatomic, strong)UILabel * descriptionLabel;

@end

@implementation ZYSiYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBarButonItem];
    [self setSegmentedControl];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    缺点:打破以前的布局,慎用（重新布局）
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark 设置左右按钮
- (void)createNavigationBarButonItem {
    //* 2.左按钮
    UIButton * setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    setBtn.frame = CGRectMake(0, 0, 44, 44);
    [setBtn setTitle:@"设置" forState:(UIControlStateNormal)];
    [setBtn addTarget:self action:@selector(ClickMineSet) forControlEvents:UIControlEventTouchUpInside];
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:setBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
//    negativeSpacer.width = -15;//调整位置方便
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backNavigationItem];
    
    //* 3.右按钮
    UIButton * msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBtn.frame = CGRectMake(0, 0, 44, 44);
    [msgBtn setTitle:@"信息" forState:(UIControlStateNormal)];
    [msgBtn addTarget:self action:@selector(clickNoticeMsg) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *setNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:msgBtn];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, setNavigationItem];
}

#pragma mark 设置SegmentedControl
- (void)setSegmentedControl {
    NSArray *array = [NSArray arrayWithObjects:@"VC",@"tableView",@"ZZ", nil];
    UISegmentedControl *segmentedController = [[UISegmentedControl alloc] initWithItems:array];    
    [segmentedController addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [segmentedController setTintColor:[UIColor whiteColor]];
    [segmentedController setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    // 设置选中的文字颜色
    [segmentedController setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    segmentedController.selectedSegmentIndex = 2;
    [self.view addSubview:self.descriptionLabel];//添加默认选择的2
    self.navigationItem.titleView = segmentedController;
}

-(void)segmentAction:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
            MineViewController * view = [[MineViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            [_descriptionLabel removeFromSuperview];
            
            [self.view addSubview:self.YLView];
        }
            break;
        case 2:
        {
            [_YLView removeFromSuperview];
            
            [self.view addSubview:_descriptionLabel];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark- 左右按钮实现方法
- (void)ClickMineSet {
    ZYSetViewController * view = [[ZYSetViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)clickNoticeMsg {
    ZYMsgViewController * view = [[ZYMsgViewController alloc] init];
    view.hidesBottomBarWhenPushed = YES;//隐藏tabBar
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark 懒加载
-(ZYYLTableView *)YLView {
    if (!_YLView) {
        _YLView = [[ZYYLTableView alloc] initWithFrame:CGRectMake(0, kNav_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-kNav_HEIGHT-kTab_HEIGHT)];
    }
    return _YLView;
}

-(UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, kNav_HEIGHT, SCREEN_WIDTH - 80, SCREEN_HEIGHT-kNav_HEIGHT-kTab_HEIGHT)];
//        _descriptionLabel.backgroundColor = [UIColor grayColor];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.text = @"选择1：跳转ViewController的cell，选择2：跳转当前页面的tableView;一些代码方便维护的方法";
    }
    return _descriptionLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
