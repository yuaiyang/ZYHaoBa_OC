//
//  YuanYouErYeVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/21.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "YuanYouErYeVC.h"
#import "TabView.h"

#import "ZYLayerView.h"
#import "ZYDatePickerView.h"
#import "ZYErYeOneView.h"
#import "ZYERYeOneXiaViewController.h"
#import "ZYExpressionView.h"
#import "ZYErWebView.h"

@interface YuanYouErYeVC ()<UIScrollViewDelegate>
{
    ZYLayerView * layerView;
    ZYErWebView *webView5;
}
@property (nonatomic, retain) TabView *tabView; //标签导航栏视图
@property (nonatomic, strong) UIScrollView *scrollView; //滑动视图控制器
@property (nonatomic, strong)ZYErYeOneView * erYeOneView;

@end

@implementation YuanYouErYeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"混乱";
    
    //加载所有视图
    [self loadAllView];
    
    //添加标签导航栏视图
    [self.view addSubview:self.tabView];
    
    //标签导航栏视图回调block实现
    
    __block YuanYouErYeVC *Self = self;
    
    _tabView.returnIndex = ^(NSInteger selectIndex){
        
        //根据标签导航下标切换不同视图显示
        
        [Self switchViewBySelectIndex:selectIndex];
    };
    
    //设置默认标签页
    
    _tabView.selectIndex = 0;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    重新布局
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark--懒加载标签导航栏视图
-(TabView *)tabView{
    
    if (_tabView == nil) {
        
        NSArray * tabArray = @[@"CALayer",@"DatePicker",@"AFN3测试",@"表情串",@"加载网页"];
        
        _tabView = [[TabView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, kHeaderHeight)];
        
        _tabView.dataArray = tabArray;
    }
    
    return _tabView;
    
}

#pragma mark--根据标签导航下标切换不同视图显示
- (void)switchViewBySelectIndex:(NSInteger)selectIndex{
    //获取选中的下标 并设置内容视图相应的页面显示
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame) * selectIndex, 0);
}

#pragma mark--UIScrollViewDelegate
//滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //设置相应的标签导航视图的选中下标
    
    self.tabView.selectIndex = page;
}

#pragma mark---加载所有视图
- (void)loadAllView {
    //初始化滑动视图
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0 , kHeaderHeight +2, SCREEN_WIDTH , SCREEN_HEIGHT-kNav_HEIGHT - kHeaderHeight - 2)];
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * 5 , CGRectGetHeight(_scrollView.frame));
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * 5 , 0);
    
    _scrollView.pagingEnabled=YES;
    
    _scrollView.directionalLockEnabled=YES;
    
    _scrollView.showsHorizontalScrollIndicator=NO;
    
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    
    //加载资讯表视图
    
    [self loadAllTabelViews];
}

- (void)loadAllTabelViews {
    //    第一页 CALAyer
    layerView = [[ZYLayerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
    [_scrollView addSubview:layerView];
    
    ////    第二页
    ZYDatePickerView * view2 = [[ZYDatePickerView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
    
    [_scrollView addSubview:view2];
    
    //    第三页 AFN3.0测试请求数据
    //    设计要跳转下级页面block内执行block
    __block typeof(self)Self = self;
    __block ZYERYeOneXiaViewController * detailView = [[ZYERYeOneXiaViewController alloc] init];
    _erYeOneView = [[ZYErYeOneView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame)*2, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
    //  链接需要更换
    _erYeOneView.urlString = KURLSTRING;
    _erYeOneView.block = ^(NSString *string) {
        detailView.urlString = string;
        [Self.navigationController pushViewController:detailView animated:YES];
    };
    [_scrollView addSubview:_erYeOneView];
    
    //    第四页
    ZYExpressionView *View4 = [[ZYExpressionView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame)*3, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
    [_scrollView addSubview:View4];
    
    //    第五页
    webView5 = [[ZYErWebView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame)*4, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
    webView5.urlString = KWEBVIEWURL;
    [_scrollView addSubview:webView5];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
