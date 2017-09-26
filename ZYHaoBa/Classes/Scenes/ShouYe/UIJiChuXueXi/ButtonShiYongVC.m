//
//  ButtonShiYongVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/26.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ButtonShiYongVC.h"

// 枚举类型本质上就是整数，定义的时候，如果只指定了第一个数值，后续的数值会依次递增
// 枚举类型是解决魔法数字比较常用的手段
typedef enum {
    kMovingDirTop = 111,
    kMovingDirleft,
    kMovingDirBottom,
    kMovingDirRight
} kMovingDir;

#define KMovingDistance 20

@interface ButtonShiYongVC ()
/**
 IBAction本质上就是void，只不过能够允许连线而已
 */

// "私有扩展"，Xcode 4.6开始，苹果建议不开放的属性和方法定义在私有扩展中
// 可以保证.h中只定义对外开放的属性和方法

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@end

@implementation ButtonShiYongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didClickBtn:(UIButton *)sender {
//    // 取出frame
//    CGRect frame = self.iconBtn.frame;
//    switch (sender.tag) {
//        case kMovingDirTop:
//            frame.origin.y -= KMovingDistance;
//            break;
//        case kMovingDirleft:
//            frame.origin.x -= KMovingDistance;
//            break;
//        case kMovingDirBottom:
//            frame.origin.y += KMovingDistance;
//            break;
//        case kMovingDirRight:
//            frame.origin.x += KMovingDistance;
//            break;
//        default:
//            break;
//    }
//    // 重新为对象的结构体属性赋值
//    self.iconBtn.frame = frame;
#pragma mark - 更好的方法 加上旋转
    CGFloat dx = 0,dy = 0;
    if (sender.tag == kMovingDirTop || sender.tag == kMovingDirBottom) {
//        三目运算的使用
        dy = (sender.tag == kMovingDirTop) ? -KMovingDistance : KMovingDistance;
    } else if (sender.tag == kMovingDirleft || sender.tag == kMovingDirRight) {
        dx = (sender.tag == kMovingDirleft) ? -KMovingDistance : KMovingDistance;
        }
    else {
//            CGFloat angle = (sender.tag) ? -M_PI_4 : M_PI_4;
//            [UIView beginAnimations:nil context:nil];
//            self.iconBtn.transform = CGAffineTransformRotate(self.iconBtn.transform, angle);
//            [UIView commitAnimations];
        
        [UIView animateWithDuration:1.0f animations:^{
            CGFloat angle = (sender.tag) ? -M_PI_4 : M_PI_4;
            self.iconBtn.transform = CGAffineTransformRotate(self.iconBtn.transform, angle);
        } completion:^(BOOL finished) {
        }];
            return;
        }
    self.iconBtn.transform = CGAffineTransformTranslate(self.iconBtn.transform, dx, dy);
}


@end
