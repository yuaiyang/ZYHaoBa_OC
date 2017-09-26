//
//  YLCFLBTViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/26.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "YLCFLBTViewController.h"
#import "CycleScrollView.h"
#import "NSTimer+Addition.h"

@interface YLCFLBTViewController ()<ClickTapDelegate>
{
    CycleScrollView*topActivityView;
}
@property (nonatomic, strong)UIScrollView * scrollView1;
@property (nonatomic, strong)NSArray * topActivityImgArr;

@end

@implementation YLCFLBTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self MakeTopActivityView:_topActivityImgArr];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 页面即将显示 设置定时器
    if (topActivityView.animationTimer) {
        [topActivityView.animationTimer resumeTimer];
    }
}

// 用于处理单张图片
- (void)ClickSingleTopAD {
    [self ClickScrollViewWithIndex:0];
}

#pragma mark Click Home AD 点击轮播图 代理方法
- (void)ClickScrollViewWithIndex:(int)index {
    
}

#pragma mark- 针对解析出来的数组设置轮播图数据
- (void)MakeTopActivityView:(NSMutableArray *)imgArr {
    //判空处理
    if (imgArr == nil || imgArr.count == 0) {
        return;
    }
    //图片URL数组
    NSMutableArray * imgUrlArr = [[NSMutableArray alloc] initWithCapacity:0];
    //图片链接数组
    NSMutableArray * imgLinkArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary * dic in imgArr) {
        //图片的url
//        NSString * imgUrl = [NSString stringWithFormat:@"%@", [JYProTools getFormatURLFromString:[dic safeObjectForKey:@"bgimg"]]];
//        [imgUrlArr addObject:imgUrl];
//        
//        
//        //* 详情地址(分享链接)
//        NSString * imgLink = [NSString stringWithFormat:@"%@", [dic safeObjectForKey:@"bgimglink"]];
//        //* 分享标题
//        NSString * imgTitle = [NSString stringWithFormat:@"%@", [dic safeObjectForKey:@"sharename"]];
//        //* 分享内容
//        NSString * imgContent = [NSString stringWithFormat:@"%@", [dic safeObjectForKey:@"sharecomment"]];
//        //* 分享icon
//        NSString * imgIcon = [NSString stringWithFormat:@"%@",  [JYProTools getFormatURLFromString:[dic safeObjectForKey:@"sharepic"]]];
//        
//        ShareMsgInfo * shareMsg = [[ShareMsgInfo alloc] init];
//        shareMsg.shareIcon = imgIcon;
//        shareMsg.shareLink = imgLink;
//        shareMsg.shareTitle = imgTitle;
//        shareMsg.shareContent = imgContent;
//        
//        [imgLinkArr addObject:shareMsg];
    }
    
//    topImgLinkArr = [[NSArray alloc] initWithArray:imgLinkArr];
    
    //数据删除
    for (UIView * view in self.scrollView1.subviews) {
        [view removeFromSuperview];
    }
    
    if (imgUrlArr.count == 1) {
        self.scrollView1.scrollEnabled = NO;
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView1.frame))];
        imgView.userInteractionEnabled = YES;
//        [imgView setImageWithURL:[NSURL URLWithString:[imgUrlArr objectAtIndex:0]]
//                placeholderImage:[UIImage imageNamed:@"banner_nopic"]
//                         options:SDWebImageRefreshCached];
        [self.scrollView1 addSubview:imgView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickSingleTopAD)];
        [imgView addGestureRecognizer:tap];
        return;
    }
    
    //AD数组
    NSMutableArray * viewsArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<imgUrlArr.count; i++) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView1.frame))];
//        [imgView setImageWithURL:[NSURL URLWithString:[imgUrlArr objectAtIndex:i]]
//                placeholderImage:[UIImage imageNamed:@"banner_nopic"]
//                         options:SDWebImageRefreshCached];
        [viewsArray addObject:imgView];
    }
    
    if (topActivityView != nil) {
        [topActivityView removeFromSuperview];
        topActivityView = nil;
    }
    
    topActivityView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView1.frame)) animationDuration:4.f pageCount:(int)viewsArray.count];
    topActivityView.backgroundColor = [UIColor clearColor];
    topActivityView.delegate = self;
    topActivityView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex) {
        return viewsArray[pageIndex];
    };
    topActivityView.viewOfSuperIndex = 1;
    topActivityView.totalPagesCount = ^ NSInteger (void) {
        return viewsArray.count;
    };
    
    [self.scrollView1 addSubview:topActivityView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIScrollView *)scrollView1 {
    if (!_scrollView1) {
        if (IS_IPHONE_4) {
            _scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        } else {
            _scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        }
    }
    return _scrollView1;
}

@end
