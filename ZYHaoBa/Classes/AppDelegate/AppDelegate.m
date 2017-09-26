//
//  AppDelegate.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/11.
//  Copyright © 2016年 ylcf. All rights reserved.
//

#import "AppDelegate.h"
#import "StartGoInAppView.h"
#import "ZYViewController.h"
#import "ZYTabBarController.h"

/** 3DTouch点击跳转页面  */
#import "XueXiJiLuVC.h"
#import "ZYNavigationController.h"


#import "ZYWindow.h"// 设置一直存在悬浮按钮

// SDWebImg缓存处理
//#import "UIImageView+WebCache.h"

#import "UIViewController+Swizzled.h"


@interface AppDelegate ()

@property (nonatomic, strong)StartGoInAppView * startView;
@property (nonatomic, strong)ZYWindow * zyWindow;

@end

@implementation AppDelegate

/**
 1. 应用程序成为激活状态后，才可以与用户进行交互。
 2. 如果要做保存游戏状态之类操作，应该在注销激活方法中处理，
 因为用户可能会双击home键，打开任务栏，此时应用程序不会退出到后台！
 3. 如果要做恢复游戏状态之类的操作，应该在成为激活方法中处理，
 因为用户可能是从任务栏中返回的。
 4. 如果应用程序运行过程中，内存或其他原因，程序被系统强行退出时，会调用Terminate方法，
 开发者，可以再此记录应用程序被退出前的状态，以便改进系统
 5. 应用程序退出到后台后，未必会是休眠状态，有可能会继续运行，例如：微博、QQ、音乐播放器等软件
 6. 在UIKit开发中，通常不用在delegate中写内存警告方法，直接在ViewController中进行处理即可。而在cocos2d的开发中，必须要在内存警告方法中进行处理，以免出现程序闪退的情况。
 */
#pragma mark 应用程序第一次完成启动，第一个调用的代理方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    SWIZZ_IT;
    
// 用户进入系统后，直接将图标右上角的数字清零
    [application setApplicationIconBadgeNumber:0];
    
//    程序启动 不隐藏状态栏 播放视频需要隐藏
    application.statusBarHidden = NO;
    
//  设置一直存在悬浮窗 注意：需要设置在主window前面，否则控制会出现问题
    [self showFloatWindow];
    
    // 主窗口是320*480全屏的大小，对于每一个应用程序而言，都有一个状态栏
    CGRect rect = [[UIScreen mainScreen]bounds];
    xh(@"当前主屏幕大小：%@", NSStringFromCGRect(rect));
    
    self.window = [[UIWindow alloc] initWithFrame:rect];
    // 设置窗口的背景颜色
    self.window.backgroundColor = [UIColor whiteColor];
    // 让窗口成为关键窗口并可见，在keyWindow中允许用户交互，否则不能接受用户的交互响应了
    [self.window makeKeyAndVisible];
    
    // 设置3DTouch功能
    [self setup3DTouch:application];
    
//    设置四个主页面
    ZYTabBarController * tabBarController = [[ZYTabBarController alloc] init];
// 将视图控制器交给self.window，成为window的根视图控制器
// rootViewController 是可以让window与控制器联动，从而可以根据设备方向进行界面的旋转
// UIView本身并不能处理旋转的事件，设备的旋转是由viewController来控制的
    self.window.rootViewController = tabBarController;
    
//    设置图片缓存大小限制为10兆
    [SDImageCache sharedImageCache].maxCacheSize = 1024 * 1024 * 10;
//    判断是否是第一次登陆
    [self isFirstLogin];
    
    xh(@"目录文件夹是：%@",NSHomeDirectory());
    
    // 获取当前版本
    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//    [[TKAlertCenter defaultCenter] postAlertWithMessage:[@"版本号是：" stringByAppendingString:version]];
    return YES;
}

#pragma mark 注销激活状态
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

#pragma mark 程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 提醒操作系统：当前这个应用程序需要在后台开启一个任务
    // 操作系统会允许这个应用程序在后台保持运行状态（能够持续的时间是不确定）
    UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
        // 后台运行的时间到期了，就会自动调用这个block
        [application endBackgroundTask:taskID];
    }];
}

#pragma mark 应用程序准备进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

#pragma mark 应用程序准备进入前台
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

#pragma mark 将被终止 —— 这个方法是由系统调用的，一般情况下，无法测出来
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 内存告急的时候调用 接收内存警告方法
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 会去通知UIViewController执行相应的内存警告方法，以释放一部分资源，保证应用程序的正常运行 
    // 赶紧清除所有的内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 赶紧停止正在进行的图片下载操作
    [[SDWebImageManager sharedManager] cancelAll];
}

/*==========================================*/

#pragma mark - 设置一直存在悬浮窗
- (void)showFloatWindow {
    self.zyWindow = [[ZYWindow alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-150, 50, 50) mainImageName:@"timg1.png" bgcolor:[UIColor lightGrayColor] animationColor:[UIColor purpleColor]];
    __weak __typeof(self)weakSelf = self;
    
    self.zyWindow.callService = ^{
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拨打羊羊儿电话？" message:@"我爱你！！！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *dissmissAction = [UIAlertAction actionWithTitle:@"隐藏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [strongSelf.zyWindow dissmissWindow];
        }];
        
        UIAlertAction *defintAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIApplication *app = [UIApplication sharedApplication];
            
            NSString *strUrl = [NSString stringWithFormat:@"tel://18703471304"];
            
            NSURL *url = [NSURL URLWithString:strUrl];
            
            [app openURL:url ];
        }];
        
        [alert addAction:dissmissAction];
        [alert addAction:defintAction];
        [alert addAction:cancleAction];
        [strongSelf.window.rootViewController presentViewController:alert animated:YES completion:nil];
    };
}

#pragma mark - 判断是否为第一次登录
- (void)isFirstLogin{
    // 判断是否为第一次登录
    xh(@"isFirstOpen - 1--%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstOpen"]);
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstOpen"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isFirstOpen"];
        xh(@"isFirstOpen - 2--%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstOpen"]);
        //        _startView = [[StartGoInAppView alloc] initWithFrame:self.window.frame];
        //        [self.window addSubview:_startView];
        xh(@"第一次登录!!!");
    } else {
        xh(@"isFirstOpen - 3--%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstOpen"]);
        //        _startView = [[StartGoInAppView alloc] initWithFrame:self.window.frame];
        //        [self.window addSubview:_startView];
        xh(@"不是第一次登录");
    }
}
#pragma mark - 实现3DTouch功能
- (void)setup3DTouch:(UIApplication *)application
{
    /**
     type 该item 唯一标识符
     localizedTitle ：标题
     localizedSubtitle：副标题
     icon：icon图标 可以使用系统类型 也可以使用自定义的图片
     userInfo：用户信息字典 自定义参数，完成具体功能需求
     */
    //    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"标签.png"];
    UIApplicationShortcutIcon *cameraIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    UIApplicationShortcutItem *cameraItem = [[UIApplicationShortcutItem alloc] initWithType:@"ONE" localizedTitle:@"学习" localizedSubtitle:@"3DTouch0" icon:cameraIcon userInfo:nil];
    
    UIApplicationShortcutIcon *shareIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    UIApplicationShortcutItem *shareItem = [[UIApplicationShortcutItem alloc] initWithType:@"TWO" localizedTitle:@"游戏" localizedSubtitle:@"" icon:shareIcon userInfo:nil];
    /** 将items 添加到app图标 */
    application.shortcutItems = @[cameraItem,shareItem];
}

#pragma mark - 实现3DTouch功能代理方法
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    ZYTabBarController *tab = (ZYTabBarController *)self.window.rootViewController;
    ZYNavigationController * nav = (ZYNavigationController *)tab.selectedViewController;
    
    if([shortcutItem.type isEqualToString:@"ONE"]){
        XueXiJiLuVC *view = [[XueXiJiLuVC alloc] init];
        view.txtName = @"XueXiJiLU";
        view.title = @"整套学习记录";
        [nav pushViewController:view animated:YES];
    }else if ([shortcutItem.type isEqualToString:@"TWO"]){
        XueXiJiLuVC *view = [[XueXiJiLuVC alloc] init];
        view.txtName = @"WeiBoZongJie";
        view.title = @"微博学习记录";
        [nav pushViewController:view animated:YES];
    }
}

@end
