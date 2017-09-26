//
//  ShuZhuangCellVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/19.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ShuZhuangCellVC.h"

@interface ShuZhuangCellVC ()

@end

@implementation ShuZhuangCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XPQTreeNodeData *node00 = [[XPQTreeNodeData alloc] initWithTitle:@"节点0-0"];
    
    XPQTreeNodeData *node10 = [[XPQTreeNodeData alloc] initWithTitle:@"节点1-0"];
    XPQTreeNodeData *node11 = [[XPQTreeNodeData alloc] initWithTitle:@"节点1-1"];
    XPQTreeNodeData *node12 = [[XPQTreeNodeData alloc] initWithTitle:@"节点1-2"];
    
    XPQTreeNodeData *node20 = [[XPQTreeNodeData alloc] initWithTitle:@"节点2-0"];
    XPQTreeNodeData *node21 = [[XPQTreeNodeData alloc] initWithTitle:@"节点2-1"];
    
    [node00 insertChild:node10];
    [node00 insertChild:node11];
    [node00 insertChild:node12];
    
    [node10 insertChild:node20];
    [node10 insertChild:node21];
    
    self.testTree.nodeData = node00;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(XPQTree *)testTree {
    if (!_testTree) {
        _testTree = [[XPQTree alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_testTree];
    }
    return _testTree;
}
@end
