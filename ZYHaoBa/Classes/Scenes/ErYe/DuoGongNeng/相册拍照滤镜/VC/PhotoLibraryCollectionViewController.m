//
//  PhotoLibraryCollectionViewController.m
//  PhotoPicker
//
//  Created by Johnil .
//  Copyright (c) 2016 Johnil. All rights reserved.
//

#import "PhotoLibraryCollectionViewController.h"
#import "AssetHelper.h"
#import "PhotoCollectionViewCell.h"
#import "UIScreen+Additions.h"
@interface PhotoLibraryCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation PhotoLibraryCollectionViewController {
    UICollectionView *_photosList;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = [[ASSETHELPER.assetGroups objectAtIndex:ASSETHELPER.currentGroupIndex] valueForProperty:ALAssetsGroupPropertyName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, [UIScreen screenWidth], [UIScreen screenHeight]);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 2;
    NSInteger size = [UIScreen screenWidth]/4-1;
    if (size%2!=0) {
        size-=1;
    }
    flowLayout.itemSize = CGSizeMake(size, size);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _photosList = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _photosList.backgroundColor = [UIColor blackColor];
    _photosList.alwaysBounceVertical = YES;
    _photosList.delegate = self;
    _photosList.dataSource = self;
    [self.view addSubview:_photosList];
    [_photosList registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"imagePickerCell"];
    [ASSETHELPER getPhotoListOfGroupByIndex:ASSETHELPER.currentGroupIndex result:^(NSArray *r) {
        [_photosList reloadData];
    }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [ASSETHELPER getPhotoCountOfCurrentGroup];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imagePickerCell" forIndexPath:indexPath];
    cell.imageView.image = [ASSETHELPER getImageAtIndex:indexPath.row type:ASSET_PHOTO_ASPECT_THUMBNAIL];
    cell.indexPath = indexPath;
    return cell;
}

@end
