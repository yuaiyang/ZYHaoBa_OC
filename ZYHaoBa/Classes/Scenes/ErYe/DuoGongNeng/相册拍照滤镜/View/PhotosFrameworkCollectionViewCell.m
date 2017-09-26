//
//  PhotosFrameworkCollectionViewCell.m
//  allinone
//
//  Created by Johnil on 16/2/29.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "PhotosFrameworkCollectionViewCell.h"
#import <PhotosUI/PhotosUI.h>

@interface PhotosFrameworkCollectionViewCell() <PHLivePhotoViewDelegate>

@end

@implementation PhotosFrameworkCollectionViewCell {
    UIImageView *_screen_shotView;
    UIVisualEffectView *_blurView;
    UIImageView *_shotView;
    UIView *_livePhotoView;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _thumbView = [[UIImageView alloc] initWithFrame:self.bounds];
        _thumbView.backgroundColor = [UIColor whiteColor];
        _thumbView.contentMode = UIViewContentModeScaleAspectFill;
        _thumbView.clipsToBounds = YES;
        [self.contentView addSubview:_thumbView];
    }
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if ([[UIDevice currentDevice] systemVersion].floatValue>=9 && touch.force>=1) {
        float progress = (touch.force-1)/4;
        if (_screen_shotView==nil) {
            UIImage *shotImage = [[[UIApplication rootViewController] view] toRetinaImage];
            _screen_shotView = [[UIImageView alloc] initWithFrame:[[UIApplication rootViewController] view].bounds];
            _screen_shotView.image = shotImage;
            [[UIApplication appDelegate].window addSubview:_screen_shotView];
            UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            _blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            _blurView.frame = _screen_shotView.bounds;
            [[UIApplication appDelegate].window addSubview:_blurView];
            _shotView = [[UIImageView alloc] initWithFrame:[self.superview convertRect:self.frame toView:self.window]];
            _shotView.image = [self toRetinaImage];
            [[UIApplication appDelegate].window addSubview:_shotView];
        }
        if (!_livePhotoView) {
            _blurView.alpha = progress*1.5;
            _screen_shotView.transform = CGAffineTransformMakeScale(1-.02*progress, 1-.02*progress);
            _shotView.transform = CGAffineTransformMakeScale(1+.1*progress, 1+.1*progress);
        }
        if (touch.force>=5) {
            if (_livePhotoView==nil) {
                _livePhotoView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, [UIScreen screenWidth]-20, [UIScreen screenHeight]*.7)];
                _livePhotoView.clipsToBounds = YES;
                _livePhotoView.layer.cornerRadius = 15;
                [[UIApplication appDelegate].window addSubview:_livePhotoView];
                
                if (_liveMode) {
                    PHLivePhotoView *livePhoto = [[PHLivePhotoView alloc] initWithFrame:_livePhotoView.bounds];
                    livePhoto.delegate = self;
                    livePhoto.contentMode = UIViewContentModeScaleAspectFill;
                    [_livePhotoView addSubview:livePhoto];
                    
                    [[PHImageManager defaultManager] requestLivePhotoForAsset:_asset targetSize:_livePhotoView.bounds.size contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(PHLivePhoto * _Nullable livePhoto1, NSDictionary * _Nullable info) {
                        livePhoto.livePhoto = livePhoto1;
                        [livePhoto startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleHint];
                    }];
                    
                    _livePhotoView.transform = CGAffineTransformMakeScale(_shotView.width/_livePhotoView.width, _shotView.height/_livePhotoView.height);
                    _livePhotoView.center = [self.superview convertPoint:self.center toView:self.window];
                    _shotView.alpha = 0;
                    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        _livePhotoView.transform = CGAffineTransformIdentity;
                        _livePhotoView.center = CGPointMake([UIScreen screenWidth]/2, [UIScreen screenHeight]/2);
                    } completion:^(BOOL finished) {
                        
                    }];
                } else {
                    UIImageView *livePhoto = [[UIImageView alloc] initWithFrame:_livePhotoView.bounds];
                    livePhoto.backgroundColor = [UIColor whiteColor];
                    livePhoto.contentMode = UIViewContentModeScaleAspectFill;
                    [_livePhotoView addSubview:livePhoto];
                    
                    [[PHImageManager defaultManager] requestImageForAsset:_asset targetSize:CGSizeMake(livePhoto.width, livePhoto.height) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                        livePhoto.image = result;
                    }];
                    _livePhotoView.transform = CGAffineTransformMakeScale(_shotView.width/_livePhotoView.width, _shotView.height/_livePhotoView.height);
                    _livePhotoView.center = [self.superview convertPoint:self.center toView:self.window];
                    _shotView.alpha = 0;
                    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        _livePhotoView.transform = CGAffineTransformIdentity;
                        _livePhotoView.center = CGPointMake([UIScreen screenWidth]/2, [UIScreen screenHeight]/2);
                    } completion:^(BOOL finished) {
                        
                    }];
                }
            }
        }
    }
}

- (void)livePhotoView:(PHLivePhotoView *)livePhotoView1 didEndPlaybackWithStyle:(PHLivePhotoViewPlaybackStyle)playbackStyle{
    [livePhotoView1 startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleHint];
}

- (void)removeBlur{
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect = [self.superview convertRect:self.frame toView:self.window];
        _livePhotoView.transform = CGAffineTransformMakeScale(rect.size.width/_livePhotoView.width, rect.size.height/_livePhotoView.height);
        _livePhotoView.center = [self.superview convertPoint:self.center toView:self.window];
        _livePhotoView.alpha = 0;
        _screen_shotView.alpha = 0;
        _screen_shotView.transform = CGAffineTransformIdentity;
        _shotView.alpha = 0;
        _shotView.transform = CGAffineTransformIdentity;
        _blurView.alpha = 0;
    } completion:^(BOOL finished) {
        [_livePhotoView removeFromSuperview];
        _livePhotoView = nil;
        [_screen_shotView removeFromSuperview];
        _screen_shotView = nil;
        [_shotView removeFromSuperview];
        _shotView = nil;
        [_blurView removeFromSuperview];
        _blurView = nil;
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_screen_shotView) {
        [self removeBlur];
        return;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_screen_shotView) {
        [self removeBlur];
        return;
    }
}

@end
