//
//  CycleScrollView.m
//  PagedScrollView
//
//  Created by 陈政 on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"
//引入对应的pageControl视图，进行对应的页面显示控制处理
//#import "SMPageControl.h"

//定义宏，进行对应的pagecontrol的默认显示图片和选中显示图片的对应保存显示处理
#define PAGECONTROL_IMAGE_NORMAL [UIImage imageNamed:@"slides_current"]
#define PAGECONTROL_IMAGE_CURRENTPAGE [UIImage imageNamed:@"slides_dot"]


@interface CycleScrollView () <UIScrollViewDelegate> {
    UIView * temp1;
    UIView * temp2;
}

@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , assign) NSTimeInterval animationDuration;

//@property (nonatomic , strong) SMPageControl * SMpageController;
@property (nonatomic, strong) UIPageControl * pageController;

@end

@implementation CycleScrollView

@synthesize delegate;

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        [self configContentViews];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration pageCount:(int)pageCount
{
    self = [self initWithFrame:frame];
    
    /*自定义pageControl*/
//    self.pageController = [[SMPageControl alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 10)];
//    self.pageController.indicatorMargin = 3.0f;
//    self.pageController.verticalAlignment = SMPageControlVerticalAlignmentBottom;
//    self.pageController.alignment = SMPageControlAlignmentRight;
    //数目
//    self.pageController.numberOfPages = pageCount;
//    self.pageController.currentPage = 0;
//    [self.pageController setPageIndicatorImage:PAGECONTROL_IMAGE_CURRENTPAGE];
//    [self.pageController setCurrentPageIndicatorImage:PAGECONTROL_IMAGE_NORMAL];
//    [self addSubview:self.pageController];
//    self.pageController.center = CGPointMake(SCREEN_WIDTH/2+20.f, 125);
    
    self.pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-15, SCREEN_WIDTH, 10)];
    self.pageController.numberOfPages = pageCount;
    self.pageController.currentPage = 0;
    CGSize pointSize = [self.pageController sizeForNumberOfPages:pageCount];
    CGFloat page_x = -(self.pageController.bounds.size.width - pointSize.width) / 2 ;
    [self.pageController setBounds:CGRectMake(page_x + 10, self.pageController.bounds.origin.y, self.pageController.bounds.size.width, self.pageController.bounds.size.height)];
    [self addSubview:self.pageController];

    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration pageCountRed:(int)pageCountRed {
    self = [self initWithFrame:frame];
    
    self.pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30, SCREEN_WIDTH, 10)];
    self.pageController.numberOfPages = pageCountRed;
    self.pageController.pageIndicatorTintColor = [UIColor grayColor];
    self.pageController.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:self.pageController];
    
    
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration pageCountRed:(int)pageCountRed pageControllerHeight:(int)height {
    self = [self initWithFrame:frame];
    
    self.pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-height, SCREEN_WIDTH, 10)];
    self.pageController.numberOfPages = pageCountRed;
    self.pageController.pageIndicatorTintColor = [UIColor grayColor];
    self.pageController.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:self.pageController];
    
    
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
    }
    return self;
}

#pragma mark
#pragma mark 私有函数

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {        
        //(3)
        if (self.totalPageCount>=3) {
            [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
            [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
            [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
        }
        else {
            //(2)
            if (previousPageIndex == rearPageIndex) {
                [self.contentViews addObject:[self duplicate:self.fetchContentViewAtIndex(previousPageIndex)]];
            }
            else {
                [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
            }
            [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
            [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
        }
    }
}

- (UIView *)duplicate:(UIView *)view {
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark
#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
//        xh(@"next，当前页:%d",self.currentPageIndex);
        self.pageController.currentPage = self.currentPageIndex;
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
//        xh(@"previous，当前页:%d",self.currentPageIndex);
        self.pageController.currentPage = self.currentPageIndex;
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    int point = self.scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.frame);
    float contentOffX = CGRectGetWidth(self.scrollView.frame) * point;
    CGPoint newOffset = CGPointMake(contentOffX + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
    
    if ([delegate respondsToSelector:@selector(ClickScrollViewWithIndex:)]) {
        [delegate ClickScrollViewWithIndex:(int)self.currentPageIndex];
    }
    if ([delegate respondsToSelector:@selector(ClickScrollViewWithIndex:superViewIndex:p2pId:p2pName:)]) {
        [delegate ClickScrollViewWithIndex:(int)self.currentPageIndex superViewIndex:self.viewOfSuperIndex p2pId:self.p2pId p2pName:self.p2pName];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
