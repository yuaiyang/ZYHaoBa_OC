//
//  HighPerformanceTableViewController.m
//  NavigationBarTranslation
//
//  Created by Johnil on 16/2/19.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "HighPerformanceTableViewController.h"
#import "HighPerformanceTableViewCell.h"
#import "HighPerformanceModel.h"

static NSString *cellIdentifier = @"cell";

@interface HighPerformanceTableViewController ()

@end

@implementation HighPerformanceTableViewController {
    NSMutableArray *_datas;
    NSMutableArray *_needLoadArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = [[NSMutableArray alloc] init];
    _needLoadArr = [[NSMutableArray alloc] init];
    
    NSString *temp = @"㳟喜周星驰導演美人鱼衝破二十亿！向最高纪录進發！也预祝我们澳门風云3和三打白骨精將在本周末齊齊衝破十亿！这是個皆大欢喜，奇妙的春節档！九十年代，我就明白电影圈只有一起好，才是真正的好！真正的红紅火火！譲我们一起為中国电影的黄金年代努力，加柴添火，超越美国成为世界第一大电影市场！";
    
    [ZYHttpsTool GET:@"https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN" parameters:nil success:^(id responseObject) {
        NSArray *images = responseObject[@"images"];
        if (images&&images.count>0) {
            NSDictionary *imageDic = [images firstObject];
            NSString *url = [NSString stringWithFormat:@"https://www.bing.com/%@", imageDic[@"url"]];
            NSDictionary *dict = @{@"text": temp,
                                   @"avatarUrl": url};
            for (NSInteger i=0; i<500; i++) {
                [_datas addObject:[[HighPerformanceModel alloc] initWithDict:dict]];
                [self.tableView reloadData];
            }
        }
    } failure:^(NSError *error) {

    }];

    [self.tableView registerClass:[HighPerformanceTableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HighPerformanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (_needLoadArr.count>0&&![_needLoadArr containsObject:indexPath]) {
        return cell;
    }
    cell.model = _datas[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [(HighPerformanceModel *)_datas[indexPath.row] height];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSIndexPath *ip = [self.tableView indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
    NSIndexPath *cip = [[self.tableView indexPathsForVisibleRows] firstObject];
    NSInteger skipCount = 8;
    if (labs(cip.row-ip.row)>skipCount) {
        NSArray *temp = [self.tableView indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, self.view.width, self.view.height)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
        if (velocity.y<0) {
            NSIndexPath *indexPath = [temp lastObject];
            if (indexPath.row+3<_datas.count) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+3 inSection:0]];
            }
        } else {
            NSIndexPath *indexPath = [temp firstObject];
            if (indexPath.row>3) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-3 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
            }
        }
        [_needLoadArr addObjectsFromArray:arr];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_needLoadArr removeAllObjects];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_needLoadArr removeAllObjects];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_needLoadArr removeAllObjects];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [_needLoadArr removeAllObjects];
}


@end
