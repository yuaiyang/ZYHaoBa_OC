//
//  PhotosFrameworkViewController.m
//  allinone
//
//  Created by Johnil on 16/2/29.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "PhotosFrameworkViewController.h"
#import <PhotosUI/PhotosUI.h>
#import "PhotosFrameworkCollectionViewFlowLayout.h"
#import "PhotosFrameworkCollectionViewCell.h"

@implementation NSIndexSet (Convenience)
- (NSArray *)aapl_indexPathsFromIndexesWithSection:(NSUInteger)section {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:section]];
    }];
    return indexPaths;
}
@end

@implementation UICollectionView (Convenience)
- (NSArray *)aapl_indexPathsForElementsInRect:(CGRect)rect {
    NSArray *allLayoutAttributes = [self.collectionViewLayout layoutAttributesForElementsInRect:rect];
    if (allLayoutAttributes.count == 0) { return nil; }
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:allLayoutAttributes.count];
    for (UICollectionViewLayoutAttributes *layoutAttributes in allLayoutAttributes) {
        NSIndexPath *indexPath = layoutAttributes.indexPath;
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}
@end

static NSString *CellIdentifier = @"PhotoCell";

@interface PhotosFrameworkViewController () <UICollectionViewDelegate, UICollectionViewDataSource, PHLivePhotoViewDelegate>

@property (strong) PHCachingImageManager *imageManager;
@property CGRect previousPreheatRect;

@end

@implementation PhotosFrameworkViewController {
    UICollectionView *_collectionView;
    PHImageRequestOptions *_univesalOptions;
    PHFetchResult *_assetsFetchResult;
    CGSize _assetGridThumbnailSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _univesalOptions = [[PHImageRequestOptions alloc] init];
    _univesalOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    NSInteger size = ceil(([UIScreen screenWidth]-2)/3-.5);
    if (size%2!=0) {
        size-=1;
    }
    _assetGridThumbnailSize = CGSizeMake(size*[UIScreen scale], size*[UIScreen scale]);
    self.imageManager = [[PHCachingImageManager alloc] init];
    PhotosFrameworkCollectionViewFlowLayout *flowlayout = [[PhotosFrameworkCollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[PhotosFrameworkCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    {
        //all
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        _assetsFetchResult = [PHAsset fetchAssetsWithOptions:options];

        //screenshot
//        PHFetchOptions *options = [[PHFetchOptions alloc] init];
//        NSInteger scale = [UIScreen mainScreen].scale;
//        NSInteger width = [UIScreen mainScreen].bounds.size.width;
//        NSInteger height = [UIScreen mainScreen].bounds.size.height;
//        options.predicate = [NSPredicate predicateWithFormat:@"(pixelHeight == %ld AND pixelWidth == %ld)",
//                             height*scale, width*scale];
//        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
//        _assetsFetchResult = [PHAsset fetchAssetsWithOptions:options];

        //livephoto
//        PHFetchOptions *options = [[PHFetchOptions alloc] init];
//        options.predicate = [NSPredicate predicateWithFormat:@"(mediaSubtype == %ld)", PHAssetMediaSubtypePhotoLive];
//        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
//        _assetsFetchResult = [PHAsset fetchAssetsWithOptions:options];
    }
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    dispatch_async(dispatch_get_main_queue(), ^{
        PHFetchResultChangeDetails *collectionChanges = [changeInstance changeDetailsForFetchResult:_assetsFetchResult];
        if (collectionChanges) {
            _assetsFetchResult = [collectionChanges fetchResultAfterChanges];
            if (![collectionChanges hasIncrementalChanges] || [collectionChanges hasMoves]) {
                [_collectionView reloadData];
            } else {
                NSIndexSet *insertedIndexes = [collectionChanges insertedIndexes];
                NSIndexSet *changedIndexes = [collectionChanges changedIndexes];
                NSIndexSet *removeIndexes = [collectionChanges removedIndexes];
                if (removeIndexes.count||changedIndexes.count) {
                    [_collectionView reloadData];
                } else {
                    [_collectionView performBatchUpdates:^{
                        if ([insertedIndexes count]) {
                            NSArray *arr = [insertedIndexes aapl_indexPathsFromIndexesWithSection:0];
                            [_collectionView insertItemsAtIndexPaths:arr];
                            [_collectionView.collectionViewLayout prepareLayout];
                        }
                    } completion:NULL];
                }
            }
        }
    });
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _assetsFetchResult.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotosFrameworkCollectionViewCell *cell = [collectionView1 dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.thumbView.image = nil;
    cell.tag = indexPath.item;
    cell.hidden = NO;
    cell.alpha = 1;
    PHAsset *asset = [_assetsFetchResult objectAtIndex:indexPath.item];
    cell.assetId = [self.imageManager requestImageForAsset:asset targetSize:_assetGridThumbnailSize contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (cell.tag==indexPath.item) {
            cell.liveMode = asset.mediaSubtypes==PHAssetMediaSubtypePhotoLive;
            cell.asset = asset;
            cell.thumbView.image = result;
        }
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(PhotosFrameworkCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.imageManager cancelImageRequest:cell.assetId];
}

@end
