//
//  PhotoPickerViewController.h
//  PhotoPicker
//
//  Created by Johnil .
//  Copyright (c) 2016 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoPickerViewController : UIViewController

@property (nonatomic, weak) id delegate;
- (UIImage *)resultImage;

@end


@protocol PhotoPickerDelegate <NSObject>

- (void)photoPickerDidFinished:(PhotoPickerViewController *)picker;
- (void)photoPickerDidCancel:(PhotoPickerViewController *)picker;

@end