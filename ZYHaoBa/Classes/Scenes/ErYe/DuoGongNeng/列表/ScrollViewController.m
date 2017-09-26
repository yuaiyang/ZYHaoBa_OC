//
//  ScrollViewController.m
//  allinone
//
//  Created by Johnil on 16/2/29.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "ScrollViewController.h"

//@interface UIView (BacktoTop)
//
//- (void)becomeUnionResponder;
//- (void)becomeUnionResponderWithViewController:(UIViewController *)vc;
//- (void)becomeUnionResponderWithNavigationViewController:(UINavigationController *)navi;
//
//@end
//
//@implementation UIView (BacktoTop)
//
//- (void)becomeUnionResponderWithViewController:(UIViewController *)vc{
//    if (![self isKindOfClass:[UIScrollView class]]) {
//        return;
//    }
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIView *view = vc.view;
//        [self findAndSetUnoinResponder:view];
//        [(UIScrollView *)self setScrollsToTop:YES];
//        NSLog(@"设置%@的scrollsToTop为YES", self);
//    });
//}
//
//- (void)becomeUnionResponderWithNavigationViewController:(UINavigationController *)navi{
//    [self becomeUnionResponderWithViewController:navi.visibleViewController];
//}
//
//- (void)becomeUnionResponder{
//    [self becomeUnionResponderWithViewController:[UIApplication visibleViewController]];
//}
//
//- (void)findAndSetUnoinResponder:(UIView *)view{
//    for (UIScrollView *tempView in view.subviews) {
//        if ([tempView isKindOfClass:[UIScrollView class]]) {
//            NSLog(@"找到ScrollView:%@，并设置scrollsToTop为NO", tempView);
//            tempView.scrollsToTop = NO;
//        }
//        [self findAndSetUnoinResponder:tempView];
//    }
//}
//
//@end

@interface ScrollViewController () <UIScrollViewDelegate>

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"点击状态栏";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.width+=10;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.width*5, 0);
    [scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.full_popGestureRecognizer];
    [self.view addSubview:scrollView];
    
    for (NSInteger i=0; i<5; i++) {
        UIScrollView *subScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        subScrollView.x = scrollView.width*i;
        subScrollView.tag = i+1;
        subScrollView.contentSize = CGSizeMake(0, 3000);
        [scrollView addSubview:subScrollView];
        
        CAGradientLayer *shadowGradientLayer = [[CAGradientLayer alloc] init];
        shadowGradientLayer.frame = CGRectMake(0, 0, subScrollView.width, subScrollView.contentSize.height);
        shadowGradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor];
        shadowGradientLayer.startPoint = CGPointMake(.5, 0);
        shadowGradientLayer.endPoint = CGPointMake(.5, 1);
        shadowGradientLayer.locations = @[@(0), @(1)];
        [subScrollView.layer addSublayer:shadowGradientLayer];
    }
    
    [[scrollView subviewWithTag:1] becomeUnionResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    self.navigationController.full_popGestureRecognizer.enabled = page==0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    [[scrollView subviewWithTag:page+1] becomeUnionResponder];
}

@end
