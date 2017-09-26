//
//  AlbumsCameraViewController.m
//  allinone
//
//  Created by Johnil on 16/2/24.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "AlbumsCameraViewController.h"
#import "PhotoPickerViewController.h"

@interface AlbumsCameraViewController() <PhotoPickerDelegate>

@end

@implementation AlbumsCameraViewController{
    UIImageView *_imageView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPhoto)];
    self.navigationItem.rightBarButtonItem = addBtn;
}

- (void)addPhoto{
    PhotoPickerViewController *picker = [[PhotoPickerViewController alloc] init];
    picker.delegate = self;
    [[UIApplication presentedViewController] presentViewController:picker animated:YES completion:nil];
}

- (void)photoPickerDidFinished:(PhotoPickerViewController *)picker {
    _imageView.image = picker.resultImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)photoPickerDidCancel:(PhotoPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
