//
//  ZYErYeViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/11.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYErYeViewController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "ShouYeTestViewController.h"
// tableView跳转页面
#import "HMComposeViewController.h"
#import "ZhiFuBaoXueXiTVC.h"
#import "DuoGongNengVC.h"

@interface ZYErYeViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

/**
 *  指示label
 */
@property (nonatomic, strong) UILabel *indicateLabel;

// tableView数据
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * allDataArr;
//@property (nonatomic, strong)NSMutableDictionary *sectionDataDic;
//@property (nonatomic, strong)NSMutableArray * rowDataArr;

@end

@implementation ZYErYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NewPagedFlowView";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStyleDone target:self action:@selector(pushVC)];
    
    for (int index = 0; index < 5; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite0%d.jpg",index]];
        [self.imageArray addObject:image];
    }
    
    [self setupUI];
    
    // tableView数据
    [self.view addSubview:self.tableView];
}

/*=================轮播图数据===================*/
#pragma mark-push控制器
- (void)pushVC {
    
    ShouYeTestViewController *testVC = [[ShouYeTestViewController alloc] init];
    
    [self.navigationController pushViewController:testVC animated:YES];
}

- (void)setupUI {
    
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 8, SCREEN_WIDTH, (SCREEN_WIDTH - 84) * 9 / 16 + 24)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    pageFlowView.minimumPageScale = 0.85;
    
    //提前告诉有多少页
    pageFlowView.orginPageCount = self.imageArray.count;
    
    pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 24 - 8, SCREEN_WIDTH, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [bottomScrollView addSubview:pageFlowView];
    
    [self.view addSubview:bottomScrollView];
    
    
    //添加到主view上
    [self.view addSubview:self.indicateLabel];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(SCREEN_WIDTH - 84, (SCREEN_WIDTH - 84) * 9 / 16);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    xh(@"点击了第%ld张图",(long)subIndex + 1);
    
    self.indicateLabel.text = [NSString stringWithFormat:@"点击了第%ld张图",(long)subIndex + 1];
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
    
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 84, (SCREEN_WIDTH - 84) * 9 / 16)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    xh(@"ViewController 滚动到了第%ld页",pageNumber);
}

#pragma mark-懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UILabel *)indicateLabel {
    
    if (_indicateLabel == nil) {
        _indicateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 16)];
        _indicateLabel.textColor = [UIColor blueColor];
        _indicateLabel.font = [UIFont systemFontOfSize:16.0];
        _indicateLabel.textAlignment = NSTextAlignmentCenter;
        _indicateLabel.text = @"指示Label";
    }
    
    return _indicateLabel;
}

/*=================tableView数据===================*/
#pragma mark tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"erYe_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.allDataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            HMComposeViewController * view = [[HMComposeViewController alloc] init];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            ZhiFuBaoXueXiTVC * view = [[ZhiFuBaoXueXiTVC alloc] init];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 2:
        {
            DuoGongNengVC * view = [[DuoGongNengVC alloc] init];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 懒加载
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH  * 0.7, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_WIDTH  * 0.7 - kNav_HEIGHT - kTab_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)allDataArr {
    if (!_allDataArr) {
        _allDataArr = [NSMutableArray arrayWithObjects:@"发微博，自定义键盘",@"支付宝学习",@"学习刀哥", nil];
    }
    return _allDataArr;
}

//-(NSMutableDictionary *)sectionDataDic {
//    if (!_sectionDataDic) {
//        _sectionDataDic = [NSMutableDictionary dictionary];
//    }
//    return _sectionDataDic;
//}
//
//-(NSMutableArray *)rowDataArr {
//    if (!_rowDataArr) {
//        _rowDataArr = [NSMutableArray array];
//    }
//    return _rowDataArr;
//}
@end
