//
//  JDViewController.m
//  allinone
//
//  Created by Johnil on 16/2/25.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "JDViewController.h"
#import "MultiCellStyleTableViewController.h"
@interface JDViewController() <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation JDViewController {
    UIView *_titleView;
    UIView *_currentLine;
    UIScrollView *_contentView;
    MultiCellStyleTableViewController *_multiCellTableViewController;
    UIViewController *_detailViewController;
    NSInteger _currentTab;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView beginAnimations:@"tintColor" context:nil];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [UIView commitAnimations];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIView beginAnimations:@"tintColor" context:nil];
    self.navigationController.navigationBar.tintColor = nil;
    [UIView commitAnimations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.navigationController.navigationBar.topItem.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, self.navigationController.navigationBar.height)];
    self.navigationItem.titleView = _titleView;
    
    NSArray *titles = @[@"商品", @"详情"];
    float width = _titleView.width/titles.count;
    for (NSInteger i=0; i<titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*width, 0, width, _titleView.height);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i==0) {
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
        } else {
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        btn.tag = i+1;
        [btn addTarget:self action:@selector(choiceTab:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btn];
    }
    _currentLine = [[UIView alloc] initWithFrame:CGRectMake(0, _titleView.height-2, width*.8, 2)];
    _currentLine.backgroundColor = [UIColor blackColor];
    [_titleView addSubview:_currentLine];
    _currentLine.center = CGPointMake([_titleView subviewWithTag:1].center.x, _currentLine.center.y);
    
    _contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _contentView.delegate = self;
    _contentView.bounces = NO;
    _contentView.y = 44;
    _contentView.height -= 44;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.contentSize = CGSizeMake(self.view.width*2, 0);
    _contentView.pagingEnabled = YES;
    [self.view addSubview:_contentView];
    
    [_contentView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.full_popGestureRecognizer];
    [self loadPage:0];
}

- (void)loadPage:(NSInteger)page{
    if (page==0) {
        self.navigationController.full_popGestureRecognizer.enabled = YES;
        if (_multiCellTableViewController==nil) {
            _multiCellTableViewController = [[MultiCellStyleTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            _multiCellTableViewController.view.height = self.view.height-64;
            [_contentView addSubview:_multiCellTableViewController.view];
        }
        [_multiCellTableViewController.tableView becomeUnionResponder];
    } else if (page==1) {
        self.navigationController.full_popGestureRecognizer.enabled = NO;
        if (_detailViewController==nil) {
            _detailViewController = [[UIViewController alloc] init];
            _detailViewController.view.x = self.view.width;
            UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
            web.y = 20;
            web.height = self.view.height-64;
            [_detailViewController.view addSubview:web];
            [_contentView addSubview:_detailViewController.view];
            [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://item.m.jd.com/detail/1217524.html?resourceType=search&resourceValue=iPhone%206%20Plus&sid=391307ce85838b0193221a9209a11911"]]];
        }

    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    [self loadPage:page];
    if (page!=_currentTab-1) {
        [self choiceTab:(UIButton *)[_titleView subviewWithTag:page+1]];
    }
}

- (void)choiceTab:(UIButton *)btn{
    for (UIButton *tempBtn in _titleView.subviews) {
        if ([tempBtn isKindOfClass:[UIButton class]]) {
            _currentTab = btn.tag;
            if (tempBtn==btn) {
                tempBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            } else {
                tempBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            }
        }
    }
    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_contentView setContentOffset:CGPointMake((btn.tag-1)*self.view.width, 0) animated:NO];
        _currentLine.center = CGPointMake(btn.center.x, _currentLine.center.y);
    } completion:nil];
}

@end
