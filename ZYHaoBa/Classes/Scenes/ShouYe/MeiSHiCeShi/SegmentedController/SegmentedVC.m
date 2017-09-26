//
//  SegmentedVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/20.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "SegmentedVC.h"

@interface SegmentedVC ()

@end

@implementation SegmentedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSegmentedControl];
}

#pragma mark 设置SegmentedControl
- (void)setSegmentedControl {
    NSArray *array = [NSArray arrayWithObjects:@"会员等级",@"会员特权",@"财富值", nil];
    UISegmentedControl *segmentedController = [[UISegmentedControl alloc] initWithItems:array];
    segmentedController.frame = CGRectMake(20, 10, SCREEN_WIDTH-40, kNav_HEIGHT);
    
    [segmentedController addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];

    // 设置UISegmentedControl的边框线
    segmentedController.layer.cornerRadius = 5.0;
    segmentedController.clipsToBounds = YES;
    [segmentedController setTintColor:[UIColor grayColor]];
    
    [segmentedController setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17.0]} forState:UIControlStateNormal];
//    // 设置选中的文字颜色
    [segmentedController setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor orangeColor]} forState:UIControlStateSelected];
    segmentedController.selectedSegmentIndex = 0;
    [self.view addSubview:segmentedController];
    
}

-(void)segmentAction:(UISegmentedControl *)sender
{
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
        
        }
            break;
        case 1:
        {
        }
            break;
        case 2:
        {
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
