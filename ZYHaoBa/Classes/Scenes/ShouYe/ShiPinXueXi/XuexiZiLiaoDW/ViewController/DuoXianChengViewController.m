//
//  DuoXianChengViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/29.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "DuoXianChengViewController.h"
#import <pthread.h>

//GCDQiTaYongFa 宏定义
#define global_queue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define main_queue dispatch_get_main_queue()

@interface DuoXianChengViewController ()
//NSThreadXianChengZhuangTai
@property (nonatomic, strong) NSThread *thread;
//NSThreadXianChengTongBu
/** 剩余票数 */
@property (nonatomic, assign) int leftTicketsCount;
@property (nonatomic, strong) NSThread *thread0;
@property (nonatomic, strong) NSThread *thread1;
@property (nonatomic, strong) NSThread *thread2;
//NSThreadXianChengTongXin (imgView1)
//GCDXiaZaiTuPian (imgView2)
//GCDQiTaYongFa (imgView1,imgView2,imgView3)
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;
@end

@implementation DuoXianChengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSThreadXianChengZhuangTai
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(NSThreadXianChengZhuangTaiTest) object:nil];
    self.thread.name = @"线程A";
    //NSThreadXianChengTongBu
    // 默认有100张
    self.leftTicketsCount = 100;
    
    // 开启多条线程同时卖票
    self.thread0 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread0.name = @"售票员 A";
    //    self.thread0.threadPriority = 0.0;
    
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread1.name = @"售票员 B";
    //    self.thread1.threadPriority = 1.0;
    
    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread2.name = @"售票员 C";
    //    self.thread2.threadPriority = 0.0;
}

#pragma mark - zuSeZhuXianCheng
- (IBAction)zuSeZhuXianCheng:(UIButton *)sender {
    // 1.获得当前的线程
    NSThread *current = [NSThread currentThread];
    
    // 2.执行一些耗时操作
    for (int i = 0; i<10000; i++) {
        // 3.输出线程
        xh(@"%@", current);
    }
//    总结：阻塞主线程 那么视图在此期间无法操作
}
#pragma mark pThread
- (IBAction)pThread:(UIButton *)sender {
    // 1.获得当前的线程
    NSThread *current = [NSThread currentThread];
    xh(@"btnClick---%@", current);
    
    // 2.执行一些耗时操作 : 创建一条子线程
    pthread_t threadId;
    pthread_create(&threadId, NULL, run, NULL);
//    总结 ：需要导入#import <pthread.h> 否则无法使用 这是纯C语言的
}
//C语言方法
void *run(void *data) {
    
    NSThread *current = [NSThread currentThread];
    
    for (int i = 0; i<20000; i++) {
        xh(@"run---%@", current);
    }
    
    return NULL;
}
#pragma mark NSThread
- (IBAction)NSThread:(UIButton *)sender {
    // 1.获得当前的线程
    NSThread *current = [NSThread currentThread];
    xh(@"btnClick---%@", current);
    
    //    NSThread *main = [NSThread mainThread];
    //    xh(@"btnClick---%@", main);
    
    // 2.执行一些耗时操作 : 创建一条子线程
//    [self threadCreate2];
//    [self threadCreate3];
    [self threadCreate];
}
- (void)run:(NSString *)param
{
    NSThread *current = [NSThread currentThread];
    
    //for (int i = 0; i<10000; i++) {
    xh(@"%@----run---%@", current, param);
    //}
}

/**
 * NSThread的创建方式
 * 隐式创建线程, 并且直接(自动)启动
 */
- (void)threadCreate3
{
    // 在后台线程中执行 === 在子线程中执行
    [self performSelectorInBackground:@selector(run:) withObject:@"abc参数"];
}

/**
 * NSThread的创建方式
 * 创建完线程直接(自动)启动
 */
- (void)threadCreate2
{
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"我是参数"];
}

/**
 * NSThread的创建方式
 * 1> 先创建初始化线程
 * 2> start开启线程
 */
- (void)threadCreate
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"哈哈"];
    thread.name = @"线程A";
    // 开启线程
    [thread start];
    
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"哈哈"];
    thread2.name = @"线程B";
    // 开启线程
    [thread2 start];
}
#pragma mark NSThreadXianChengZhuangTai
- (IBAction)NSThreadXianChengZhuangTai:(UIButton *)sender {
    // 开启线程
    [self.thread start];
}
- (void)NSThreadXianChengZhuangTaiTest
{
    xh(@"test - 开始 - %@", [NSThread currentThread].name);
    
    [NSThread sleepForTimeInterval:5]; // 阻塞状态
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:5.0];
    [NSThread sleepUntilDate:date];
    
    for (int i = 0; i<1000; i++) {
        xh(@"test - %d - %@", i, [NSThread currentThread].name);
        
        if (i == 50) {
            [NSThread exit];
        }
    }
    
    xh(@"test - 结束 - %@", [NSThread currentThread].name);
}
#pragma mark NSThreadXianChengTongBu
- (IBAction)NSThreadXianChengTongBu:(UIButton *)sender {
    [self.thread0 start];
    [self.thread1 start];
    [self.thread2 start];
}
/**
 * 卖票
 */
- (void)saleTicket
{
    while (1) {
        @synchronized(self) { // 加锁(只能用一把锁)
            // 1.先检查票数
            int count = self.leftTicketsCount;
            if (count > 0) {
                // 暂停
                //                [NSThread sleepForTimeInterval:0.0002];
                
                // 2.票数 - 1
                self.leftTicketsCount = count - 1;
                
                NSThread *current = [NSThread currentThread];
                xh(@"%@ 卖了一张票, 剩余%d张票", current.name, self.leftTicketsCount);
            } else {
                // 退出线程
                [NSThread exit];
            }
        } // 解锁
    }
}

#pragma mark NSThreadXianChengTongXin
- (IBAction)NSThreadXianChengTongXin:(UIButton *)sender {
    // 在子线程中调用download方法下载图片
    [self performSelectorInBackground:@selector(NSThreadXianChengTongXinDownload) withObject:nil];
}
/**
 * 下载图片 : 子线程
 */
- (void)NSThreadXianChengTongXinDownload
{
    // 1.根据URL下载图片
    NSURL *url = [NSURL URLWithString:KIMGURL1];
    xh(@"-------begin");
    NSData *data = [NSData dataWithContentsOfURL:url]; // 这行会比较耗时
    xh(@"-------end");
    UIImage *image = [UIImage imageWithData:data];
    
    // 2.回到主线程显示图片
    //    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
    // setImage: 1s
    [self.imgView1 performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    //    [self performSelectorOnMainThread:@selector(settingImage:) withObject:image waitUntilDone:NO];
}

/**
 * 设置(显示)图片: 主线程
 */
//- (void)settingImage:(UIImage *)image
//{
//    self.imgView1.image = image
//}
#pragma mark GCDJiBenShiYong
- (IBAction)GCDJiBenShiYong:(UIButton *)sender {
    [self performSelectorInBackground:@selector(GCDJiBenShiYongTest) withObject:nil];
    
//    [self syncMainQueue];
//    [self asyncMainQueue];
//    [self syncSerialQueue];
//    [self asyncSerialQueue];
//    [self syncGlobalQueue];
//    [self asyncGlobalQueue];
    
}
- (void)GCDJiBenShiYongTest
{
    xh(@"test --- %@", [NSThread currentThread]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        xh(@"任务 --- %@", [NSThread currentThread]);
    });
}

/**
 * 使用dispatch_async异步函数, 在主线程中往主队列中添加任务
 */
- (void)asyncMainQueue
{
    // 1.获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.添加任务到队列中 执行
    dispatch_async(queue, ^{
        xh(@"----下载图片1-----%@", [NSThread currentThread]);
    });
}

/**
 * 使用dispatch_sync同步函数, 在主线程中往主队列中添加任务 : 任务无法往下执行
 */
- (void)syncMainQueue
{
    // 1.获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.添加任务到队列中 执行
    dispatch_sync(queue, ^{
        xh(@"----下载图片1-----%@", [NSThread currentThread]);
    });
    //    dispatch_sync(queue, ^{
    //        xh(@"----下载图片2-----%@", [NSThread currentThread]);
    //    });
    //    dispatch_sync(queue, ^{
    //        xh(@"----下载图片3-----%@", [NSThread currentThread]);
    //    });
    
    // 不会开启新的线程, 所有任务在主线程中执行
}

// 凡是函数名种带有create\copy\new\retain等字眼, 都需要在不需要使用这个数据的时候进行release
// GCD的数据类型在ARC环境下不需要再做release
// CF(Core Foundation)的数据类型在ARC环境下还是需要再做release

/**
 * 用dispatch_sync同步函数往串行列中添加任务
 */
- (void)syncSerialQueue
{
    // 1.创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", NULL);
    
    // 2.添加任务到队列中 执行
    dispatch_sync(queue, ^{
        xh(@"----下载图片1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        xh(@"----下载图片2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        xh(@"----下载图片3-----%@", [NSThread currentThread]);
    });
    
    // 3.释放资源
    //    dispatch_release(queue);   // MRC(非ARC)
    
    // 总结: 不会开启新的线程
}

/**
 * 用dispatch_sync同步函数往并发队列中添加任务
 */
- (void)syncGlobalQueue
{
    // 1.获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.添加任务到队列中 执行
    dispatch_sync(queue, ^{
        xh(@"----下载图片1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        xh(@"----下载图片2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        xh(@"----下载图片3-----%@", [NSThread currentThread]);
    });
    
    // 总结: 不会开启新的线程, 并发队列失去了并发的功能
}

/**
 * 用dispatch_async异步函数往串行队列中添加任务
 */
- (void)asyncSerialQueue
{
    // 1.创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.itheima.queue", NULL);
    
    // 2.添加任务到队列中 执行
    dispatch_async(queue, ^{
        xh(@"----下载图片1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        xh(@"----下载图片2-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        xh(@"----下载图片3-----%@", [NSThread currentThread]);
    });
    
    // 总结: 只开1个线程执行任务
}

/**
 * 用dispatch_async异步函数往并发队列中添加任务
 */
- (void)asyncGlobalQueue
{
    // 1.获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.添加任务到队列中 执行
    dispatch_async(queue, ^{
        xh(@"----下载图片1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        xh(@"----下载图片2-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        xh(@"----下载图片3-----%@", [NSThread currentThread]);
    });
    
    // 总结: 同时开启了3个线程
}
#pragma mark GCDXiaZaiTuPian
- (IBAction)GCDXiaZaiTuPian:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        xh(@"--download--%@", [NSThread currentThread]);
        // 下载图片
        NSURL *url = [NSURL URLWithString:KIMGURL1];
        NSData *data = [NSData dataWithContentsOfURL:url]; // 这行会比较耗时
        UIImage *image = [UIImage imageWithData:data];
        
        // 回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            xh(@"--imageView--%@", [NSThread currentThread]);
            self.imgView2.image = image;
        });
    });
}
#pragma mark GCDQiTaYongFa
- (IBAction)GCDQiTaYongFa:(UIButton *)sender {
    /**
     1.下载图片1和图片2
     
     2.将图片1和图片2合并成一张图片后显示到imageView上
     
     思考:
     * 下载图片 : 子线程
     * 等2张图片都下载完毕后, 才回到主线程
     */
    // 创建一个组
    dispatch_group_t group = dispatch_group_create();
    
    // 开启一个任务下载图片1
    __block UIImage *image1 = nil;
    dispatch_group_async(group, global_queue, ^{
        image1 = [self imageWithURL:KIMGURL1];
    });
    
    // 开启一个任务下载图片2
    __block UIImage *image2 = nil;
    dispatch_group_async(group, global_queue, ^{
        image2 = [self imageWithURL:KIMGURL2];
    });
    
    // 同时执行下载图片1\下载图片2操作
    
    // 等group中的所有任务都执行完毕, 再回到主线程执行其他操作
    dispatch_group_notify(group, main_queue, ^{
        self.imgView1.image = image1;
        self.imgView2.image = image2;
        
        // 合并
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), NO, 0.0);
        [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
        [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
        self.imgView3.image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
    });
    //    if (self.log == NO) {
    //        xh(@"-------touchesBegan");
    //        self.log = YES;
    //    }
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        xh(@"-------touchesBegan");
    //    });

}
- (void)downlaod2image
{
    dispatch_async(global_queue, ^{
        xh(@"下载图片---%@", [NSThread currentThread]);
        
        // 下载图片1
        UIImage *image1 = [self imageWithURL:KIMGURL1];
        xh(@"下载完图片1---%@", [NSThread currentThread]);
        // 下载图片2
        UIImage *image2 = [self imageWithURL:KIMGURL2];
        xh(@"下载完图片2---%@", [NSThread currentThread]);
        
        dispatch_async(main_queue, ^{
            xh(@"显示图片---%@", [NSThread currentThread]);
            
            self.imgView1.image = image1;
            self.imgView2.image = image2;
            
            // 合并
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), NO, 0.0);
            [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
            [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
            self.imgView3.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
        });
    });
}

- (UIImage *)imageWithURL:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url]; // 这行会比较耗时
    return [UIImage imageWithData:data];
}

- (void)delay
{
    //    xh(@"----touchesBegan----%@", [NSThread currentThread]);
    
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    //    });
    // 1.全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.计算任务执行的时间
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC));
    
    // 3.会在when这个时间点, 执行queue中的任务
    dispatch_after(when, queue, ^{
        xh(@"----run----%@", [NSThread currentThread]);
    });
}
//- (void)run
//{
//    xh(@"----run----%@", [NSThread currentThread]);
//}


@end
