//
//  PhotoPickerViewController.m
//  PhotoPicker
//
//  Created by Johnil .
//  Copyright (c) 2016 Johnil. All rights reserved.
//

#import "PhotoPickerViewController.h"
#import <GPUImage/GPUImage.h>
#import "PhotoLibraryCollectionViewController.h"
#import "PhotoLibraryGroupTableViewController.h"
#import "FRDLivelyButton.h"
#import "UIScreen+Additions.h"
#import "ScrollContentView.h"

@interface PhotoPickerViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate, GPUImageVideoCameraDelegate, UITextViewDelegate>

@end

@implementation PhotoPickerViewController {
    GPUImageStillCamera *_videoCamera;
    UIScrollView *__filterscrollView;
    NSInteger _currentPage;
    NSInteger _tempPage;
    NSMutableArray *_filters;
    NSMutableArray *_filterNames;
    
    UIView *_cameraView;
    UINavigationController *_photoBrowser;
    FRDLivelyButton *_libraryBtn;
    FRDLivelyButton *_cancelBtn;
    UIButton *_cameraBtn;
    float _tempY;
    int _flashType;
    UIButton *_flashBtn;
    UIImage *_resultImage;
    BOOL _isFront;
    UIButton *_restoreBtn;
    
    UIView *_overlay;
    UIButton *_changeBtn;
    UIImageView *_resultView;
    NSInteger _randomTag;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _flashType = 0;

    _filterNames = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<24; i++) {
        if (i==0) {
            [_filterNames addObject:@""];
        } else {
            [_filterNames addObject:[NSString stringWithFormat:@"abc%ld.acv", (i-1)]];
        }
    }
    [_filterNames addObject:@""];
    _filters = [[NSMutableArray alloc] init];
    for (NSInteger i=0;i<_filterNames.count;i++) {
        [_filters addObject:[NSNull null]];
    }
    
    _cameraView = [[UIView alloc] initWithFrame:self.view.frame];
    _cameraView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8];
    _cameraView.clipsToBounds = YES;
    
    PhotoLibraryGroupTableViewController *group = [[PhotoLibraryGroupTableViewController alloc] initWithStyle:UITableViewStylePlain];
    _photoBrowser = [[UINavigationController alloc] initWithRootViewController:group];
    _photoBrowser.view.frame = CGRectMake(0, [UIScreen screenHeight]-0, [UIScreen screenWidth], [UIScreen screenHeight]);
    [self.view addSubview:_photoBrowser.view];
    
    __filterscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], [UIScreen screenHeight])];
    __filterscrollView.showsVerticalScrollIndicator = NO;
    __filterscrollView.showsHorizontalScrollIndicator = NO;
    __filterscrollView.backgroundColor = [UIColor blackColor];
    __filterscrollView.delegate = self;
    __filterscrollView.pagingEnabled = YES;
    __filterscrollView.contentSize = CGSizeMake(self.view.width*_filters.count, 0);
    [_cameraView addSubview:__filterscrollView];
    [self.view addSubview:_cameraView];
    _overlay = [[UIView alloc] initWithFrame:__filterscrollView.bounds];
    _overlay.clipsToBounds = YES;
    [_cameraView addSubview:_overlay];
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __filterscrollView.width, __filterscrollView.height/2)];
    top.backgroundColor = [UIColor blackColor];
    [_overlay addSubview:top];
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, __filterscrollView.height/2 , __filterscrollView.width, __filterscrollView.height/2)];
    bottom.backgroundColor = [UIColor blackColor];
    [_overlay addSubview:bottom];
    
    _restoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _restoreBtn.hidden = YES;
    _restoreBtn.frame = CGRectMake(0, 0, 40, 40);
    _restoreBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_restoreBtn setImage:[UIImage imageNamed:@"restore"] forState:UIControlStateNormal];
    _restoreBtn.center = CGPointMake(self.view.width/2, 40);
    [_restoreBtn addTarget:self action:@selector(restore) forControlEvents:UIControlEventTouchUpInside];
    [_cameraView addSubview:_restoreBtn];
    _restoreBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    _restoreBtn.layer.shadowOffset = CGSizeMake(0, .1);
    _restoreBtn.layer.shadowOpacity = .3;
    _restoreBtn.layer.shadowRadius = 1;

    _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _changeBtn.frame = CGRectMake(0, 0, 40, 40);
    [_changeBtn setImage:[UIImage imageNamed:@"camera_toggle_icon"] forState:UIControlStateNormal];
    _changeBtn.center = CGPointMake([UIScreen screenWidth]-40, 40);
    [_changeBtn addTarget:self action:@selector(changeCameraPosition) forControlEvents:UIControlEventTouchUpInside];
    [_cameraView addSubview:_changeBtn];
    
    _changeBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    _changeBtn.layer.shadowOffset = CGSizeMake(0, .1);
    _changeBtn.layer.shadowOpacity = .3;
    _changeBtn.layer.shadowRadius = 1;

    
    _flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _flashBtn.frame = CGRectMake(0, 0, 40, 40);
    _flashBtn.center = CGPointMake(40, 40);
    [_flashBtn setImage:[UIImage imageNamed:@"camera_flash_icon"] forState:UIControlStateNormal];
    [_flashBtn addTarget:self action:@selector(change_flashType) forControlEvents:UIControlEventTouchUpInside];
    [_cameraView addSubview:_flashBtn];
    _flashBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    _flashBtn.layer.shadowOffset = CGSizeMake(0, .1);
    _flashBtn.layer.shadowOpacity = .3;
    _flashBtn.layer.shadowRadius = 1;

    
    _videoCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetPhoto cameraPosition:AVCaptureDevicePositionBack];
    _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _videoCamera.jpegCompressionQuality = 1;

    [self loadPage:0];
    [_videoCamera startCameraCapture];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen screenHeight]-100, [UIScreen screenWidth], 100)];
    [_cameraView addSubview:bottomView];
    float side = [UIScreen screenWidth]/2-40;
    _libraryBtn = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(0,0,40,40)];
    [_libraryBtn setOptions:@{ kFRDLivelyButtonLineWidth: @(2.0f),
                          kFRDLivelyButtonHighlightedColor: UIColorFromRGB(0x46526f),
                          kFRDLivelyButtonColor: [UIColor whiteColor]
                          }];
    [_libraryBtn setStyle:kFRDLivelyButtonStyleHamburger animated:NO];
    [_libraryBtn setImage:[UIImage imageNamed:@"camera_library_icon"] forState:UIControlStateNormal];
    [bottomView addSubview:_libraryBtn];
    _libraryBtn.center = CGPointMake(side/2, bottomView.height/2);
    [_libraryBtn addTarget:self action:@selector(showPhotos) forControlEvents:UIControlEventTouchUpInside];
    _libraryBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    _libraryBtn.layer.shadowOffset = CGSizeMake(0, .1);
    _libraryBtn.layer.shadowOpacity = .3;
    _libraryBtn.layer.shadowRadius = 1;

    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag_cameraView:)];
    pan.delegate = self;
    [_cameraView addGestureRecognizer:pan];
    
    _cancelBtn = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(0,0,40,40)];
    [_cancelBtn setOptions:@{ kFRDLivelyButtonLineWidth: @(2.0f),
                              kFRDLivelyButtonHighlightedColor: UIColorFromRGB(0x46526f),
                              kFRDLivelyButtonColor: [UIColor whiteColor]
                              }];
    [_cancelBtn setStyle:kFRDLivelyButtonStyleClose animated:NO];
    [_cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    _cancelBtn.layer.shadowOffset = CGSizeMake(0, .1);
    _cancelBtn.layer.shadowOpacity = .3;
    _cancelBtn.layer.shadowRadius = 1;
    [bottomView addSubview:_cancelBtn];
    _cancelBtn.center = CGPointMake([UIScreen screenWidth]-side/2, bottomView.height/2);
    
    _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cameraBtn.frame = CGRectMake(0, 0, 80, 80);
    _cameraBtn.center = CGPointMake(bottomView.width/2, bottomView.height/2);
    [_cameraBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [_cameraBtn setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [_cameraBtn setImage:[UIImage imageNamed:@"camera_pressed"] forState:UIControlStateHighlighted];
    [_cameraBtn setImage:[UIImage imageNamed:@"camera_disable"] forState:UIControlStateDisabled];
    
    _cameraBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    _cameraBtn.layer.shadowOffset = CGSizeMake(0, .1);
    _cameraBtn.layer.shadowOpacity = .3;
    _cameraBtn.layer.shadowRadius = 1;

    [bottomView addSubview:_cameraBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollPhoto:) name:@"scrollViewDidScroll" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollDone:) name:@"scrollViewDidEnd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choicePhoto:) name:@"choicePhoto" object:nil];
    
    double delayInSeconds = .5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            top.y = -top.height;
            bottom.y = __filterscrollView.height;
        } completion:^(BOOL finished) {
            [bottom removeFromSuperview];
            [top removeFromSuperview];
            _overlay.hidden = YES;
        }];
    });

}

- (void)clear{
    _restoreBtn.hidden = YES;
    for (NSInteger i=0; i<_filters.count; i++) {
        [self clearPage:i];
    }
    [__filterscrollView setContentOffset:CGPointZero animated:NO];
    _currentPage = 0;
    [self loadPage:0];
}

- (void)restore{
    [self clear];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return _resultImage==nil;
    }
    return NO;
}

- (UIImage *)resultImage{
    return _resultImage;
}

- (void)takePhoto{
    AudioServicesPlaySystemSound(1108);
    
    if (_currentPage<0) {
        return;
    }
    if (_currentPage>_filterNames.count-1) {
        return;
    }
    GPUImageToneCurveFilter *filter = _filters[_currentPage];
    _overlay.hidden = NO;
    [filter useNextFrameForImageCapture];
    _resultImage = [UIImage imageWithCGImage:[filter newCGImageFromCurrentlyProcessedOutput]];
    if (_isFront) {
        UIGraphicsBeginImageContextWithOptions(_resultImage.size, YES, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(context, 0, _resultImage.size.height);
        CGContextScaleCTM(context, 1.0f, -1.0f);
        
        // then flip Y axis
        CGContextTranslateCTM(context, _resultImage.size.width, 0);
        CGContextScaleCTM(context, -1.0f, 1.0f);

        CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(0.,0., _resultImage.size.width, _resultImage.size.height),_resultImage.CGImage);
        _resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    [self addImage:_resultImage];
}

- (void)change_flashType{
    _flashType++;
    if (_flashType>1) {
        _flashType=0;
    }
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    switch (_flashType) {
        case 0:
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOff];
            [device unlockForConfiguration];
            [_flashBtn setImage:[UIImage imageNamed:@"camera_flash_icon"] forState:UIControlStateNormal];
            break;
        case 1:
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOn];
            [device unlockForConfiguration];
            [_flashBtn setImage:[[UIImage imageNamed:@"camera_flash_icon"] tintImageWithColor:UIColorFromRGB(0xFF6347)] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)changeCameraPosition{
    [_videoCamera rotateCamera];
    if (_videoCamera.cameraPosition==AVCaptureDevicePositionBack) {
        _isFront = NO;
        _flashBtn.enabled = YES;
    } else {
        if (_flashType==1) {
            [self change_flashType];
        }
        _isFront = YES;
        _flashBtn.enabled = NO;
    }
    for (NSInteger i=0; i<_filterNames.count; i++) {
        ScrollContentView *view = (ScrollContentView *)[__filterscrollView viewWithTag:i+1];
        if (view) {
             GPUImageView *temp = (GPUImageView *)view.contentView;
            if (_isFront) {
                [temp setInputRotation:kGPUImageFlipHorizonal atIndex:0];
            } else {
                [temp setInputRotation:kGPUImageNoRotation atIndex:0];
            }
        }
    }
}

- (void)choicePhoto:(NSNotification *)notifi{
    UIImage *image = notifi.object;
    [self hideLibrary];
    _overlay.hidden = NO;
    _resultImage = image;
    [self addImage:image];
}

- (void)addImage:(UIImage *)image{
    if (_resultView) {
        [_resultView removeFromSuperview];
        _resultView = nil;
    }
    _cameraBtn.enabled = NO;
    [_libraryBtn setImage:nil forState:UIControlStateNormal];
    [_cancelBtn setImage:nil forState:UIControlStateNormal];

    [_videoCamera stopCameraCapture];
    [self clear];
    _overlay.backgroundColor = [UIColor blackColor];
    _overlay.hidden = NO;
    
    _resultView = [[UIImageView alloc] initWithImage:_resultImage];
    _resultView.contentMode = UIViewContentModeScaleAspectFill;
    _resultView.frame = __filterscrollView.frame;
    [_overlay insertSubview:_resultView atIndex:0];
    
    [_cancelBtn setStyle:kFRDLivelyButtonStyleArrowRight animated:YES];
    [_libraryBtn setStyle:kFRDLivelyButtonStyleArrowLeft animated:YES];
    _changeBtn.hidden = YES;
    _restoreBtn.hidden = YES;
    _flashBtn.hidden = YES;
    
    _cameraBtn.hidden = YES;
}

- (void)cancel{
    if (_resultImage) {
        if (_delegate) {
            [_delegate photoPickerDidFinished:self];
        }
    } else {
        if (_delegate) {
            [_delegate photoPickerDidCancel:self];
        }
    }
}

- (void)scrollDone:(NSNotification *)notifi{
    if (_cameraView.y!=0&&_cameraView.y!=-[UIScreen screenHeight]+0) {
        if (_photoBrowser.view.y>64) {
            [self hideLibrary];
        } else {
            [self showLibrary];
        }
    }
}

- (void)scrollPhoto:(NSNotification *)notifi{
    UIScrollView *scrollView = notifi.object;
    float offset = scrollView.contentOffset.y+scrollView.contentInset.top;
    if (offset<0||(_cameraView.y!=0&&_cameraView.y!=-[UIScreen screenHeight]+0)) {
        float y = _cameraView.y;
        y-=offset;
        if (y>0) {
            y=0;
        }
        if (y<-[UIScreen screenHeight]+0) {
            y=-[UIScreen screenHeight]+0;
        }
        if (_cameraView.y!=y) {
            _cameraView.y = y;
            float py = _cameraView.y+_cameraView.height;
            if (py>[UIScreen screenHeight]-0) {
                py = [UIScreen screenHeight]-0;
            }
            if (_photoBrowser.view.y!=py) {
                _photoBrowser.view.y = py;
            }
        }
        [scrollView setContentOffset:CGPointMake(0, -scrollView.contentInset.top)];
    }
}

- (void)drag_cameraView:(UIPanGestureRecognizer *)pan{
    if (pan.state==UIGestureRecognizerStateBegan) {
        CGPoint location = [pan locationInView:self.view];
        _tempY = location.y;
    } else if (pan.state==UIGestureRecognizerStateChanged) {
        CGPoint location = [pan locationInView:self.view];
        float y = _cameraView.y;
        if (y>-[UIScreen screenHeight]||_tempY<location.y) {
            y -= (_tempY-location.y);
        } else {
            y = -[UIScreen screenHeight];
        }
        if (y>0) {
            y=0;
        }
        if (_cameraView.y!=y) {
            _cameraView.y = y;
            if (_cameraView.y+_cameraView.height<_photoBrowser.view.y||_tempY<location.y) {
                float py = _cameraView.y+_cameraView.height;
                if (py>[UIScreen screenHeight]-0) {
                    py = [UIScreen screenHeight]-0;
                }
                if (_photoBrowser.view.y!=py) {
                    _photoBrowser.view.y = py;
                }
            }
        }
        _tempY = location.y;
    } else if (pan.state==UIGestureRecognizerStateEnded||pan.state==UIGestureRecognizerStateCancelled||pan.state==UIGestureRecognizerStateFailed) {
        CGPoint vel = [pan velocityInView:self.view];
        if (vel.y<-100) {
            [self showLibrary];
        } else if (vel.y>100){
            [self hideLibrary];
        } else {
            if (_cameraView.y<-100) {
                [self showLibrary];
            } else {
                [self hideLibrary];
            }
        }
        [_libraryBtn showUnHighlight];
    }
}

- (void)showLibrary{
    if (_resultImage) {
        _cameraBtn.hidden = NO;

        _changeBtn.hidden = NO;
        _restoreBtn.hidden = _tempPage==0;
        _flashBtn.hidden = NO;

        _resultImage = nil;
        _cameraBtn.enabled = YES;
        [_videoCamera startCameraCapture];
        [self loadPage:_tempPage];
        [__filterscrollView setContentOffset:CGPointMake(__filterscrollView.width*_tempPage, 0) animated:NO];
        [UIView animateWithDuration:.3 animations:^{
            _overlay.y = -_overlay.height;
        } completion:^(BOOL finished) {
            _overlay.y = 0;
            _overlay.hidden = YES;
            _overlay.backgroundColor = [UIColor clearColor];
            [_resultView removeFromSuperview];
            _resultView = nil;
        }];
        [_cancelBtn setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
        [_libraryBtn setImage:[UIImage imageNamed:@"camera_library_icon"] forState:UIControlStateNormal];
        [_cancelBtn setStyle:kFRDLivelyButtonStyleClose animated:YES];
        return;
    }
    [_cameraBtn setEnabled:NO];
    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _cameraView.y = -[UIScreen screenHeight]+0;
        _photoBrowser.view.y = 0;
    } completion:nil];
}

- (void)hideLibrary{
    [_libraryBtn setStyle:kFRDLivelyButtonStyleHamburger animated:YES];
    [_cameraBtn setEnabled:YES];
    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _cameraView.y = 0;
        _photoBrowser.view.y = [UIScreen screenHeight]-0;
    } completion:nil];
}

- (void)showPhotos{
    if (_photoBrowser.view.y==0) {
        [self hideLibrary];
    } else {
        [self showLibrary];
    }
}

- (void)loadPage:(NSInteger)page{
    if (page<0) {
        return;
    }
    if (page>_filterNames.count-1) {
        return;
    }
    ScrollContentView *view = (ScrollContentView *)[__filterscrollView viewWithTag:page+1];
    if (view==nil) {
        CGRect frame = CGRectMake(page*__filterscrollView.width, 0, [UIScreen screenWidth], [UIScreen screenHeight]);
        view = [[ScrollContentView alloc] initWithFrame:frame];
        view.tag = page+1;
        NSString *filterName = _filterNames[page];
        GPUImageView *filterView = [[GPUImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen screenWidth],[UIScreen screenHeight])];
        if (_isFront) {
            [filterView setInputRotation:kGPUImageFlipHorizonal atIndex:0];
        } else {
            [filterView setInputRotation:kGPUImageNoRotation atIndex:0];
        }
        filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
        if (filterName.length>0) {
            NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"abc%ld.acv",page-1] ofType:nil]];
            GPUImageToneCurveFilter *filter = [[GPUImageToneCurveFilter alloc] initWithACVData:data];
            [_videoCamera addTarget:filter];
            [filter addTarget:filterView];
            [__filterscrollView addSubview:view];
            [view addContentView:filterView];
            [_filters replaceObjectAtIndex:page withObject:filter];
        } else {
            GPUImageRGBFilter *filter = [[GPUImageRGBFilter alloc] init];
            [_videoCamera addTarget:filter];
            [filter addTarget:filterView];
            [__filterscrollView addSubview:view];
            [view addContentView:filterView];
            [_filters replaceObjectAtIndex:page withObject:filter];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_cameraViewTapAction:)];
        [filterView addGestureRecognizer:tap];
    }
}

- (void)clearPage:(NSInteger)page{
    if (page<0) {
        return;
    }
    if (page>_filterNames.count-1) {
        return;
    }
    ScrollContentView *view = (ScrollContentView *)[__filterscrollView viewWithTag:page+1];
    if (view!=nil) {
        GPUImageToneCurveFilter *filter = _filters[page];
        if ((NSNull *)filter!=[NSNull null]) {
            [filter removeAllTargets];
            [_videoCamera removeTarget:filter];
            [_filters replaceObjectAtIndex:page withObject:[NSNull null]];
        }
        [view removeFromSuperview];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!scrollView.tracking&&!scrollView.dragging&&!scrollView.decelerating) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _currentPage = page;
    _tempPage = page;
    if (_currentPage>0) {
        if (_restoreBtn.hidden) {
            _restoreBtn.hidden = NO;
        }
    } else {
        if (!_restoreBtn.hidden) {
            _restoreBtn.hidden = YES;
        }
    }
    [self clearPage:page-2];
    [self clearPage:page+2];
    [self loadPage:page-1];
    [self loadPage:page];
    [self loadPage:page+1];
    if (page==_filters.count-2) {
        [self loadPage:0];
    }
    for (ScrollContentView *contentView in __filterscrollView.subviews) {
        [contentView setOffsetX:__filterscrollView.contentOffset.x];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (page==_filters.count-1) {
        [scrollView setContentOffset:CGPointZero];
    }
}

-(void)_cameraViewTapAction:(UITapGestureRecognizer *)tgr {
    if (tgr.state == UIGestureRecognizerStateRecognized) {
        CGPoint location = [tgr locationInView:tgr.view];
        AVCaptureDevice *device = _videoCamera.inputCamera;
        CGPoint pointOfInterest = CGPointMake(.5f, .5f);
        CGSize frameSize = [tgr.view frame].size;
        if ([_videoCamera cameraPosition] == AVCaptureDevicePositionFront) {
            location.x = frameSize.width - location.x;
        }
        pointOfInterest = CGPointMake(location.y / frameSize.height, 1.f - (location.x / frameSize.width));
        if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            NSError *error;
            if ([device lockForConfiguration:&error]) {
                [device setFocusPointOfInterest:pointOfInterest];
                
                [device setFocusMode:AVCaptureFocusModeAutoFocus];
                
                if([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
                    [device setExposurePointOfInterest:pointOfInterest];
                    [device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
                }
                
                [device unlockForConfiguration];
            }
        }
        if (_randomTag!=0) {
            [tgr.view removeSubviewWithTag:_randomTag];
        }
        _randomTag = -(arc4random()%1000+1);
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        circle.tag = _randomTag;
        circle.center = [tgr locationInView:self.view];
        circle.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1];
        circle.layer.borderColor = [UIColor whiteColor].CGColor;
        circle.layer.borderWidth = 3;
        circle.layer.cornerRadius = 40;
        circle.layer.shadowColor = [UIColor blackColor].CGColor;
        circle.layer.shadowOffset = CGSizeMake(0, .1);
        circle.layer.shadowOpacity = .3;
        circle.layer.shadowRadius = 1;
        circle.layer.rasterizationScale = [UIScreen scale];
        circle.layer.shouldRasterize = YES;
        [tgr.view addSubview:circle];
        circle.transform = CGAffineTransformMakeScale(.5, .5);
        [UIView  animateWithDuration:.3 delay:0 usingSpringWithDamping:.6 initialSpringVelocity:.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            circle.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 delay:.3 options:UIViewAnimationOptionCurveLinear animations:^{
                circle.alpha = 0;
            } completion:^(BOOL finished) {
                [circle removeFromSuperview];
            }];
        }];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
