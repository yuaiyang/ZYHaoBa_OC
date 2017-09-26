//
//  SecondViewController.m
//  NavigationBarTranslation
//
//  Created by Johnil on 16/2/16.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "TableHeaderViewController.h"

static NSString *cellIdentifier = @"cell";
static float kHeaderHeightMe = 200.0f;

@interface TableHeaderViewController () <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation TableHeaderViewController {
    UITableView *_listView;
    UIImageView *_headerImageView;
    UIView *_headerContainerView;
    CAGradientLayer *_shadowGradientLayer;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];

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
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeaderHeightMe)];
    _headerContainerView = [[UIView alloc] initWithFrame:header.bounds];
    _headerContainerView.clipsToBounds = YES;
    _headerContainerView.backgroundColor = [UIColor lightGrayColor];
    _headerImageView = [[UIImageView alloc] initWithFrame:_headerContainerView.bounds];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerContainerView addSubview:_headerImageView];
    [header addSubview:_headerContainerView];
    _listView.tableHeaderView = header;
    
    _shadowGradientLayer = [[CAGradientLayer alloc] init];
    _shadowGradientLayer.frame = CGRectMake(0, 0, _headerContainerView.width, 25);
    _shadowGradientLayer.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent:.3].CGColor, (__bridge id)[UIColor clearColor].CGColor];
    _shadowGradientLayer.startPoint = CGPointMake(.5, 0);
    _shadowGradientLayer.endPoint = CGPointMake(.5, 1);
    _shadowGradientLayer.locations = @[@(0), @(1)];
    [self.view.layer addSublayer:_shadowGradientLayer];
    
    [self loadHeader];
}

- (void)loadHeader{
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.center = CGPointMake(_headerImageView.frame.size.width/2, _headerImageView.frame.size.height/2);
    [_headerImageView addSubview:activity];
    [activity startAnimating];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:@"https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN"
//      parameters:nil
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             NSArray *images = responseObject[@"images"];
//             if (images&&images.count>0) {
//                 NSDictionary *imageDic = [images firstObject];
//                 NSString *url = [NSString stringWithFormat:@"https://www.bing.com/%@", imageDic[@"url"]];
//                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                     NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//                     UIImage *image = [UIImage imageWithData:data];
//                     dispatch_async(dispatch_get_main_queue(), ^{
//                         _headerImageView.image = image;
//                     });
//                 });
//             }
//             [activity stopAnimating];
//             [activity removeFromSuperview];
//         }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             [activity stopAnimating];
//             [activity removeFromSuperview];
//         }];
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
        _headerContainerView.y = scrollView.contentOffset.y;
        _headerContainerView.height = kHeaderHeightMe-_headerContainerView.y;
        _headerImageView.height = _headerContainerView.height;
    }
}

@end
