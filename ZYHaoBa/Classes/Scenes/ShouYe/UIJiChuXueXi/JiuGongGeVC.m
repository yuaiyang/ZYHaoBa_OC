//
//  JiuGongGeVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/11/3.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "JiuGongGeVC.h"
#import "JiuGongGeModel.h"

@interface JiuGongGeVC ()
/** 应用程序列表 */
@property (nonatomic, strong) NSArray *appList;
@end

@implementation JiuGongGeVC

- (NSArray *)appList
{
    if (_appList == nil) {
        _appList = [JiuGongGeModel appList];
    }
    return _appList;
}

- (void)viewDidLoad
{
    self.title = @"九宫格";
    [super viewDidLoad];
    
    // 搭建界面，九宫格
#define kAppViewW 80    //每个item宽
#define kAppViewH 90    //每个item高
#define kColCount 3     //每行数量
#define kStartY   20    //距view顶部距离
#define kAllItemCount   15    //item个数
    
    // 320 - 3 * 80 = 80 / 4 = 20
    CGFloat marginX = (SCREEN_WIDTH - kColCount * kAppViewW) / (kColCount + 1);
    CGFloat marginY = 10;
    
    for (int i = 0; i < kAllItemCount; i++) {
        // 行
        // 0, 1, 2 => 0
        // 3, 4, 5 => 1
        int row = i / kColCount;
        
        // 列
        // 0, 3, 6 => 0
        // 1, 4, 7 => 1
        // 2, 5, 8 => 2
        int col = i % kColCount;
        
        CGFloat x = marginX + col * (marginX + kAppViewW);
        CGFloat y = kStartY + marginY + row * (marginY + kAppViewH);
        
        UIView *appView = [[UIView alloc] initWithFrame:CGRectMake(x, y, kAppViewW, kAppViewH)];
        //        appView.backgroundColor = [UIColor redColor];
        [self.view addSubview:appView];
        
        // 实现视图内部细节
        //        NSDictionary *dict = self.appList[i];
        JiuGongGeModel *appInfo = self.appList[i];
        
        // 1> UIImageView
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kAppViewW, 50)];
        //        icon.backgroundColor = [UIColor greenColor];
        
        // 设置图像
        //        icon.image = [UIImage imageNamed:dict[@"icon"]];
        //        icon.image = [UIImage imageNamed:appInfo.icon];
        icon.image = appInfo.image;
        
        // 设置图像填充模式，等比例显示(CTRL+6)
        icon.contentMode = UIViewContentModeScaleAspectFit;
        
        [appView addSubview:icon];
        
        // 2> UILabel -> 应用程序名称
        // CGRectGetMaxY(frame) = frame.origin.y + frame.size.height
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame), kAppViewW, 20)];
        //        lable.backgroundColor = [UIColor blueColor];
        
        // 设置应用程序名称
        //        lable.text = dict[@"name"];
        lable.text = appInfo.name;
        
        // 设置字体
        lable.font = [UIFont systemFontOfSize:13.0];
        lable.textAlignment = NSTextAlignmentCenter;
        
        [appView addSubview:lable];
        
        // 3> UIButton -> 下载按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lable.frame), kAppViewW, 20)];
        button.backgroundColor = [UIColor redColor];
        button.titleLabel.textColor = [UIColor whiteColor];
    
        // 按钮都是有状态的，不同状态可以对应不同的标题
        [button setTitle:appInfo.download forState:UIControlStateNormal];
        // *** 一定不要使用以下方法，修改按钮标题
        //        button.titleLabel.text = @"aaa";
        
        // 修改字体（titleLabel是只读的）
        // readonly表示不允许修改titleLabel的指针，但是可以修改label的字体
        // 提示：按钮的字体是不区分状态的！
        button.titleLabel.font = [UIFont systemFontOfSize:12.0];
        
        [appView addSubview:button];
    }
}

@end
