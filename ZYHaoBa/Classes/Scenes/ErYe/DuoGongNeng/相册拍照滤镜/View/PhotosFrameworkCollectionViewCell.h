//
//  PhotosFrameworkCollectionViewCell.h
//  allinone
//
//  Created by Johnil on 16/2/29.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface PhotosFrameworkCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *thumbView;
@property (nonatomic) PHImageRequestID assetId;
@property (nonatomic) PHAsset *asset;
@property (nonatomic) BOOL liveMode;

@end
