
//
//  BlockTableViewController.m
//  Block
//
//  Created by ylcf on 16/10/19.
//  Copyright © 2016年 sgx. All rights reserved.
//

#import "BlockTableViewController.h"
#import "KVOModel.h"

@interface BlockTableViewController ()
@property (nonatomic, strong)NSMutableArray * dataArr;
@property (nonatomic, strong)KVOModel *model;
@end

@implementation BlockTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // KVO
    _model = [[KVOModel alloc] init];
    _model.name = @"正羽";
    [_model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"hello"];
}

#pragma mark - 实现KVO方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (![change[@"new"] isEqualToString:change[@"old"]]) {
        self.tableView.backgroundColor = [UIColor colorWithRed:arc4random() %256/255.0 green:arc4random() %256/255.0 blue:arc4random() %256/255.0 alpha:1.0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"black_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     *0-3 测试block
     *4-5 测试代理
     *6 测试通知
     */
    switch (indexPath.row) {
        case 0:
        {
#warning - block调用
            self.oneBlock();
        }
            break;
        case 1:
        {
#warning - block调用传递一个参数
            self.twoBlock(@"twoBlock传递一个参数");
        }
            break;
        case 2:
        {
#warning - block调用传递两个参数
            NSArray *array = @[@"threeBlock参数1",@"threeBlock参数1"];
            self.threeBlock(@"传递两个参数",array);
        }
            break;
        case 3:
        {
#warning - 简易一步到位block调用传递一个参数
            self.fourBlock(@"fourBlock传递一个参数");
        }
            break;
            // 代理
        case 4:
        {
            if ([self.delegate respondsToSelector:@selector(getValue:)]) {
                [self.delegate getValue:@"点击第五行，代理传值"];
            }
        }
            break;
        case 5:
        {
            if ([self.delegate respondsToSelector:@selector(testDlegate)]) {
                [self.delegate testDlegate];
            }
        }
            break;
            // 测试通知
        case 6:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"testNot" object:nil userInfo:@{@"name":@"testNot"}];
        }
            break;
            // KVO
        case 7:
        {
            _model.name = [NSString stringWithFormat:@"小羊：%d",arc4random()%100];
//            _model.name = @"小羊";
        }
            break;
            
        default:
            break;
    }
}

#warning 必须移除键值观察者
-(void)dealloc {
//    移除键值观察者
    [_model removeObserver:self forKeyPath:@"name" context:@"hello"];
}

-(NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithObjects:@"block1",@"block2",@"block3", @"block4", @"代理1", @"代理2", @"通知", @"KVC",nil];
    }
    return _dataArr;
}

@end
