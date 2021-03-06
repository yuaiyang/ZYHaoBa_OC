//
//  TableHeaderAndNaviBarViewController.m
//  NavigationBarTranslation
//
//  Created by Johnil on 16/2/16.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "TableHeaderAndNaviBarViewController.h"


static NSString *cellIdentifier = @"cell";
static float kHeaderHeightMe = 200.0f;
static float kLineSize;

@interface TableHeaderAndNaviBarViewController () <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation TableHeaderAndNaviBarViewController {
    UITableView *_listView;
    UIImageView *_headerImageView;
    UIView *_headerContainerView;
    CAGradientLayer *_shadowGradientLayer;
    UIView *_headerView;
    UIStatusBarStyle _barStyle;
    UIView *_lineView;
}

- (UIStatusBarStyle)preferredStatus_barStyle{
    return _barStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationFade;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    kLineSize = (1.0/[UIScreen mainScreen].scale);
    _barStyle = UIStatusBarStyleLightContent;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    _listView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _listView.delegate = self;
    _listView.dataSource = self;
    [self.view addSubview:_listView];
    [_listView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self setupHeader];
}

- (void)setupHeader{
    // 这才是会显示的导航栏
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeaderHeightMe)];
    _headerView.backgroundColor = [UIColor whiteColor];
    
    _headerContainerView = [[UIView alloc] initWithFrame:_headerView.bounds];
    _headerContainerView.clipsToBounds = YES;
    _headerContainerView.backgroundColor = [UIColor lightGrayColor];
    _headerImageView = [[UIImageView alloc] initWithFrame:_headerContainerView.bounds];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerContainerView addSubview:_headerImageView];
    [_headerView addSubview:_headerContainerView];
    
    [self.view addSubview:_headerView];
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _headerView.height-kLineSize, _headerView.width, kLineSize)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:_lineView];
    _shadowGradientLayer = [[CAGradientLayer alloc] init];
    _shadowGradientLayer.frame = CGRectMake(0, 0, _headerContainerView.width, 25);
    _shadowGradientLayer.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent:.3].CGColor, (__bridge id)[UIColor clearColor].CGColor];
    _shadowGradientLayer.startPoint = CGPointMake(.5, 0);
    _shadowGradientLayer.endPoint = CGPointMake(.5, 1);
    _shadowGradientLayer.locations = @[@(0), @(1)];
    [self.view.layer addSublayer:_shadowGradientLayer];
    
    [self loadHeader];
    
    _listView.contentInset = UIEdgeInsetsMake(_headerView.height, 0, 0, 0);
    _listView.scrollIndicatorInsets = _listView.contentInset;
}

- (void)loadHeader{
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.center = CGPointMake(_headerImageView.frame.size.width/2, _headerImageView.frame.size.height/2);
    [_headerImageView addSubview:activity];
    [activity startAnimating];
    
    [ZYHttpsTool GET:@"https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN" parameters:nil success:^(id responseObject) {
        NSArray *images = responseObject[@"images"];
        if (images&&images.count>0) {
            NSDictionary *imageDic = [images firstObject];
            NSString *url = [NSString stringWithFormat:@"https://www.bing.com/%@", imageDic[@"url"]];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                UIImage *image = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    _headerImageView.image = image;
                });
            });
        }
        [activity stopAnimating];
        [activity removeFromSuperview];
    } failure:^(NSError *error) {
        [activity stopAnimating];
        [activity removeFromSuperview];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y+scrollView.contentInset.top<=0) {
        _headerContainerView.alpha = 1;
        _shadowGradientLayer.opacity = 1;
        _headerView.y = 0;
        _headerContainerView.height = kHeaderHeightMe-(scrollView.contentOffset.y+scrollView.contentInset.top);
        _headerImageView.height = _headerContainerView.height;
        _lineView.y = _headerContainerView.height-.5;
    } else {
        if (_headerContainerView.height!=kHeaderHeightMe) {
            _headerContainerView.height = kHeaderHeightMe;
            _headerImageView.height = _headerContainerView.height;
            _lineView.y = _headerContainerView.height-.5;
        }
        float min = _headerView.height-64;
        float offset = (scrollView.contentOffset.y+scrollView.contentInset.top);
        offset = MIN(min, offset);
        if (_headerView.y!=-offset) {
            float progress = offset/min;
            if (progress>.5) {
                if (_barStyle==UIStatusBarStyleLightContent) {
                    _barStyle = UIStatusBarStyleDefault;
                    [self setNeedsStatusBarAppearanceUpdate];
                }
            } else {
                if (_barStyle==UIStatusBarStyleDefault) {
                    _barStyle = UIStatusBarStyleLightContent;
                    [self setNeedsStatusBarAppearanceUpdate];
                }
            }
            _shadowGradientLayer.opacity = 1-progress;
            _headerContainerView.alpha = 1-progress;
            _headerView.y = -offset;
            // 设置是否显示导航栏 如果需要在导航栏放东西 那么设置其透明度 注意 在导航栏范围内透明度
//            if (progress == 1) {
//                [self.navigationController setNavigationBarHidden:NO animated:YES];
//            } else {
//                [self.navigationController setNavigationBarHidden:YES animated:YES];
//            }
        }
    }
}

@end
