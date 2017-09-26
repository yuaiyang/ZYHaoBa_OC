//
//  LowPerformaceTableViewController.m
//  NavigationBarTranslation
//
//  Created by Johnil on 16/2/16.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "LowPerformanceTableViewController.h"
#import "LowPerformanceTableViewCell.h"

static NSString *cellIdentifier = @"cell";

@interface LowPerformanceTableViewController ()

@end

@implementation LowPerformanceTableViewController {
    NSMutableArray *_datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<500; i++) {
        [_datas addObject:@"㳟喜周星驰導演美人鱼衝破二十亿！向最高纪录進發！也预祝我们澳门風云3和三打白骨精將在本周末齊齊衝破十亿！这是個皆大欢喜，奇妙的春節档！九十年代，我就明白电影圈只有一起好，才是真正的好！真正的红紅火火！譲我们一起為中国电影的黄金年代努力，加柴添火，超越美国成为世界第一大电影市场！"];
    }
    [self.tableView registerClass:[LowPerformanceTableViewCell class] forCellReuseIdentifier:cellIdentifier];
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
    LowPerformanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setContent:_datas[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *temp = _datas[indexPath.row];
    return [LowPerformanceTableViewCell calcHeighWithString:temp];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
