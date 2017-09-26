//
//  main.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/11.
//  Copyright © 2016年 ylcf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        /*
         argc 和 argv是c语言的标准参数，iOS开发中，可以不用理会
         
         第三个:UIAppliaction的类名，创建一个UIApplication对象，每一个应用程序都有且仅有一个UIApplication对象（单例），所谓单例表示该对象，在内存中只有一个对象，可以被共享使用。
         第四个:UIApplicationDelegate的类名，改delegate必须遵守UIApplicationDelegate协议
         */
        /*
        注意：以下nil可以替换为NSStringFromClass([UIApplication class])，一般用于较为复杂程序，需要使用AppDelegate子类的时候才会使用到，正常情况nil就可以
         */
        return UIApplicationMain(argc, argv, NSStringFromClass([UIApplication class]), NSStringFromClass([AppDelegate class]));
        
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
