//
//  CycleScrollView.h
//  PagedScrollView
//
//  Created by 陈政 on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickTapDelegate <NSObject>

@optional
- (void)ClickScrollViewWithIndex:(int)index;

- (void)ClickScrollViewWithIndex:(int)index superViewIndex:(int)superViewIndex p2pId:(NSInteger )p2pId p2pName:(NSString *)p2pName;

@end

@interface CycleScrollView : UIView

@property (nonatomic , assign)int viewOfSuperIndex;
@property (nonatomic, assign)NSInteger p2pId;
@property (nonatomic, strong)NSString * p2pName;

@property (nonatomic , strong) NSTimer *animationTimer;

@property (nonatomic , readonly) UIScrollView *scrollView;
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration pageCount:(int)pageCount;

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration pageCountRed:(int)pageCountRed;

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration pageCountRed:(int)pageCountRed pageControllerHeight:(int)height;


/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

/**
 点击的时候，执行的block获取父视图
 **/
//@property (nonatomic , copy) UIView * (^DidClickSuperViewBlock)(UIView *superView);


@property (nonatomic, assign) id <ClickTapDelegate> delegate;

@end