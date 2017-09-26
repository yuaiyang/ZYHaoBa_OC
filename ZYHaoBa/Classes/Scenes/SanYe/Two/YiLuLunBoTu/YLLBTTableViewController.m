//
//  YLLBTTableViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/29.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "YLLBTTableViewController.h"

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"

#import "ZYAlertView.h"

#define KUpdateAlertString @"新版本特性\n1、基金和固收板块分离，理财更方便\n2、优化部分产品细节，体验更加\n2.测试左对齐"

@interface YLLBTTableViewController ()<ClickTapDelegate,ZYAlertViewDelegate>
{
    CycleScrollView*topActivityView;// 创建头部轮播
    ZYAlertView * alertTZView;// 通知弹框
}
@property (nonatomic , retain) NSMutableArray *dataArray;//数据源数组
@property (nonatomic, strong)UIScrollView * topScrollView;// 头部轮播图
@property (nonatomic, strong)NSArray * topActivityImgArr; // 放轮播图数据
@end

@implementation YLLBTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    往轮播添加数据
    [self MakeTopActivityView:self.topActivityImgArr];
    // 设置为头部 随着tableView滚动
    self.tableView.tableHeaderView = self.topScrollView;
    // 设置为尾部 随着tableView滚动
//    self.tableView.tableFooterView = self.topScrollView;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (topActivityView.animationTimer) {
        [topActivityView.animationTimer resumeTimer];
    }
}

-(void)dealloc {
    [topActivityView.animationTimer pauseTimer];
}

#pragma mark- 针对解析出来的数组设置轮播图数据
- (void)MakeTopActivityView:(NSArray *)imgArr {
    //判空处理
    if (imgArr == nil || imgArr.count == 0) {
        return;
    }

    //数据删除
    for (UIView * view in self.topScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    if (imgArr.count == 1) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.topScrollView.frame))];
        imgView.userInteractionEnabled = YES;
        [imgView setImageWithURL:[NSURL URLWithString:[imgArr objectAtIndex:0]]
                placeholderImage:[UIImage imageNamed:@"testImg.png"]
                         options:SDWebImageRefreshCached];
        [self.topScrollView addSubview:imgView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickSingleTopAD)];
        [imgView addGestureRecognizer:tap];
        return;
    }
    
    //AD数组
    NSMutableArray * viewsArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<imgArr.count; i++) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.topScrollView.frame))];
        [imgView setImageWithURL:[NSURL URLWithString:[imgArr objectAtIndex:i]]
                placeholderImage:[UIImage imageNamed:@"testImg.png"]
                         options:SDWebImageRefreshCached];
        [viewsArray addObject:imgView];
    }
    
    if (topActivityView != nil) {
        [topActivityView removeFromSuperview];
        topActivityView = nil;
    }
    
    topActivityView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.topScrollView.frame)) animationDuration:4.f pageCount:(int)viewsArray.count];
    topActivityView.backgroundColor = [UIColor clearColor];
    topActivityView.delegate = self;
    topActivityView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex) {
        return viewsArray[pageIndex];
    };
    topActivityView.viewOfSuperIndex = 1;
    topActivityView.totalPagesCount = ^ NSInteger (void) {
        return viewsArray.count;
    };
    
    [self.topScrollView addSubview:topActivityView];
}

#pragma mark Click Home AD 点击轮播图 代理方法
- (void)ClickScrollViewWithIndex:(int)index {
    showAlert(@"YLLBTTableViewController页面点击轮播图");
    xh(@"YLLBTTableViewController页面点击第%d张轮播图",index);
}

// 用于处理单张图片
- (void)ClickSingleTopAD {
    [self ClickScrollViewWithIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 200;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return self.topScrollView;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"YLLBT_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    隐藏cell直接的线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZYProTools getSizeOfText:_dataArray[indexPath.row] sizeBy:CGSizeMake(SCREEN_WIDTH - 30, 100) font:[UIFont systemFontOfSize:20]].height + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [self showAlertCallPhoneNum];
        }
            break;
        case 1:
        {
            [self showZYAlertViewWithTitle:@"发现新版本" Msg:KUpdateAlertString withLeftText:@"取消" withRightText:@"立即更新" rightHandler:^(UIAlertAction *action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppStore_Link]];
            }];
        }
            break;
        case 2:
        {
            //    列表展示
            alertTZView = [[ZYAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds withTitleStr:@"通知" withContentStr:KUpdateAlertString withButtonStr:@"朕已知"];
            alertTZView.delegate = self;
            [alertTZView show];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark--LazyLoading
-(NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        NSArray * array = [NSArray arrayWithObjects:@"拨打电话-一路财富",@"提示框左对齐",@"弹出通知窗口", nil];
        _dataArray = [NSMutableArray arrayWithArray:array];
        
    }
    return _dataArray;
}

-(UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.showsVerticalScrollIndicator = NO;
    }
    return _topScrollView;
}

-(NSArray *)topActivityImgArr {
    if (!_topActivityImgArr) {
        _topActivityImgArr = [NSArray arrayWithObjects:KIMGURL1,KIMGURL2,KIMGURL3,KIMGURL4, nil];
        _topScrollView.scrollEnabled = NO;
    }
    return _topActivityImgArr;
}

#pragma mark 其他功能
#pragma mark 提示框拨打电话 显示底部
- (void)showAlertCallPhoneNum {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"拨打电话" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [alertView dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        拨打电话
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4000011566"]];
    }];
    [alertView addAction:action1];
    [alertView addAction:action2];
    // 弹出提示框
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:alertView animated: YES completion: nil];
}
#pragma mark iOS8.0以后设置提示框
- (void)showZYAlertViewWithTitle:(nullable NSString *)title Msg:(nullable NSString*)msg withLeftText:(nullable NSString *)leftTxt withRightText:(nullable NSString *)rightTxt rightHandler:(void (^ __nullable)(UIAlertAction *action))rightHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    //行间距
    paragraphStyle.lineSpacing = 2.0;
    
    NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17.0], NSParagraphStyleAttributeName : paragraphStyle};
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:msg];
    [attributedTitle addAttributes:attributes range:NSMakeRange(0, msg.length)];
    [alertController setValue:attributedTitle forKey:@"attributedMessage"];//attributedTitle\attributedMessage
    //end ---
    
    UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:leftTxt
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                                                             }];
    UIAlertAction *defaultAction2 = [UIAlertAction actionWithTitle:rightTxt
                                                             style: UIAlertActionStyleDefault
                                                           handler:rightHandler];
    
    [alertController addAction:defaultAction1];
    [alertController addAction:defaultAction2];

    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:alertController animated: YES completion: nil];
}

#pragma mark ZYAlertViewDelegate
- (void)sendValueOfDidClickBtn:(NSString *)str {
    showAlert(@"点击朕已知实现的代理方法");
    xh(@"点击朕已知实现的代理方法");
}

@end
