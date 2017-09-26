//
//  PhotoLibraryGroupTableViewController.m
//  PhotoPicker
//
//  Created by Johnil .
//  Copyright (c) 2016 Johnil. All rights reserved.
//

#import "PhotoLibraryGroupTableViewController.h"
#import "AssetHelper.h"
#import "PhotoLibraryCollectionViewController.h"
@interface PhotoLibraryGroupTableViewController ()

@end

@implementation PhotoLibraryGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, [UIScreen screenWidth], [UIScreen screenHeight]);
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    ASSETHELPER.bReverse = YES;
    [ASSETHELPER getGroupList:^(NSArray *a) {
        [self.tableView reloadData];
        ASSETHELPER.currentGroupIndex = 0;
        PhotoLibraryCollectionViewController *picker = [[PhotoLibraryCollectionViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:picker animated:NO];
    }];
    UIView *view = [[UIView alloc] init];
    self.tableView.tableFooterView = view;
    self.tableView.separatorColor = [UIColor darkGrayColor];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"相册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[AssetHelper sharedAssetHelper] getGroupCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuseIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIImageView *thumb = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 60, 60)];
        thumb.tag = 1;

        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, cell.width-90*2, 80)];
        title.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:title];
    }
    ALAssetsGroup *group = [ASSETHELPER getGroupAtIndex:indexPath.row];
    cell.detailTextLabel.font = FONT(13);
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)[group numberOfAssets]];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.x = 90;
    UIImageView *thumb = (UIImageView *)[cell.contentView viewWithTag:1];
    thumb.image = [UIImage imageWithCGImage:[group posterImage]];
    [cell.contentView addSubview:thumb];
    
    UILabel *title = (UILabel *)[cell.contentView viewWithTag:2];
    title.font = FONT(16);
    title.text = [group valueForProperty:ALAssetsGroupPropertyName];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!scrollView.tracking&&!scrollView.dragging&&!scrollView.decelerating) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewDidScroll" object:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewDidEnd" object:nil];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewDidEnd" object:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ASSETHELPER.currentGroupIndex = indexPath.row;
    PhotoLibraryCollectionViewController *picker = [[PhotoLibraryCollectionViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:picker animated:YES];
}

@end
