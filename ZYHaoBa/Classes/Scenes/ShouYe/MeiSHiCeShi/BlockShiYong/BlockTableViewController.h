//
//  BlockTableViewController.h
//  Block
//
//  Created by ylcf on 16/10/19.
//  Copyright © 2016年 sgx. All rights reserved.
//

#import <UIKit/UIKit.h>
/************************delegate***************************/
@protocol BlockTableViewControllerDelegate <NSObject>

- (void)getValue:(NSString *)value;
- (void)testDlegate;

@end

/************************block***************************/
// 声明block
typedef void (^OneBlock)();
typedef void(^TwoBlock)(NSString *string);
// 传递多个参数依次后面添加就好啦
typedef void(^ThreeBlock)(NSString *string,NSArray *array);


@interface BlockTableViewController : UITableViewController

// 代理属性
@property(nonatomic, assign) id<BlockTableViewControllerDelegate > delegate;

// block属性
@property (nonatomic, copy)OneBlock oneBlock;

@property (nonatomic, copy)TwoBlock twoBlock;

@property (nonatomic, copy)ThreeBlock threeBlock;

// 声明和属性 一步到位
@property (nonatomic, copy) void (^fourBlock)(NSString* string);

@end
