//
//  PhotoCollectionViewCell.m
//  PhotoPicker
//
//  Created by Johnil .
//  Copyright (c) 2016 Johnil. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "AssetHelper.h"

@implementation PhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UIImage *image = [ASSETHELPER getImageAtIndex:_indexPath.row type:ASSET_PHOTO_SCREEN_SIZE];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"choicePhoto" object:image];
}

@end
