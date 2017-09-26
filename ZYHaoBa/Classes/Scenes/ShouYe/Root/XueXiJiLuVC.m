//
//  XueXiJiLuVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/26.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "XueXiJiLuVC.h"

@interface XueXiJiLuVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation XueXiJiLuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.txtName ofType:@"txt"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.textView.text = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
