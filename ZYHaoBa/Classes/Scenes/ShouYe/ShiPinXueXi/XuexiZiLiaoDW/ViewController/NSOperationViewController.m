//
//  NSOperationViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/29.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "NSOperationViewController.h"
#import "HMApp.h"
#import "HMDownloadOperation.h"

@interface NSOperationViewController ()<HMDownloadOperationDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *apps;
@property (nonatomic, strong) NSOperationQueue *queue;
/** key:url value:operation对象 */
@property (nonatomic, strong) NSMutableDictionary *operations;

/** key:url value:image对象*/
@property (nonatomic, strong) NSMutableDictionary *images;
@property (nonatomic, strong)UITableView * tableView;

@end

@implementation NSOperationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    执行NSOperation基本操作
    [self operationQueue2];
    //    [self opeationListen];
    //    [self operationQueue];
    //    [self blockOperation];
    //    [self invocationOperation];

}

- (void)operationQueue2
{
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        xh(@"NSBlockOperation------下载图片1---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        xh(@"NSBlockOperation------下载图片2---%@", [NSThread currentThread]);
    }];
    [operation2 addExecutionBlock:^{
        xh(@"NSBlockOperation------下载图片22---%@", [NSThread currentThread]);
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2;
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    
    [queue addOperationWithBlock:^{
        xh(@"NSBlockOperation------下载图片3---%@", [NSThread currentThread]);
    }];
}

- (void)opeationListen
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<10; i++) {
            xh(@"NSBlockOperation------下载图片---%@", [NSThread currentThread]);
        }
    }];
    operation.completionBlock = ^{
        // ...下载完图片后想做事情
        xh(@"NSBlockOperation------下载图片完毕---%@", [NSThread currentThread]);
    };
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (void)operationQueue
{
    // 1.封装操作
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    //    operation1.queuePriority = NSOperationQueuePriorityHigh
    
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<10; i++) {
            xh(@"NSBlockOperation------下载图片---%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:0.1];
        }
    }];
    //    [operation3 addExecutionBlock:^{
    //        for (int i = 0; i<10; i++) {
    //            xh(@"NSBlockOperation------下载图片2---%@", [NSThread currentThread]);
    //            [NSThread sleepForTimeInterval:0.1];
    //        }
    //    }];
    
    // 2.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2; // 2 ~ 3为宜
    
    // 设置依赖
    [operation2 addDependency:operation3];
    [operation3 addDependency:operation1];
    
    // 3.添加操作到队列中(自动执行操作, 自动开启线程)
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    
    //    [queue setSuspended:YES];
}

- (void)blockOperation
{
    // 1.封装操作
    //    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
    //        xh(@"NSBlockOperation------下载图片1---%@", [NSThread currentThread]);
    //    }];
    
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    
    [operation addExecutionBlock:^{
        xh(@"NSBlockOperation------下载图片1---%@", [NSThread currentThread]);
    }];
    
    [operation addExecutionBlock:^{
        xh(@"NSBlockOperation------下载图片2---%@", [NSThread currentThread]);
    }];
    
    [operation addExecutionBlock:^{
        xh(@"NSBlockOperation------下载图片3---%@", [NSThread currentThread]);
    }];
    
    // 2.执行操作
    [operation start];
}


- (void)invocationOperation
{
    // 1.创建操作对象, 封装要执行的任务
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download) object:nil];
    
    // 2.执行操作(默认情况下, 如果操作没有放到队列queue中, 都是同步执行)
    [operation start];
}

- (void)download
{
    for (int i = 0; i<10; i++) {
        xh(@"------download---%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.1];
    }
}

- (void)run
{
    for (int i = 0; i<10; i++) {
        xh(@"------run---%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.1];
    }
}

#pragma mark 点击屏幕执行自定义Operation操作
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -kNav_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark 自定义Operation
- (NSArray *)apps
{
    if (!_apps) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
        
        NSMutableArray *appArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            HMApp *app = [HMApp appWithDict:dict];
            [appArray addObject:app];
        }
        _apps = appArray;
    }
    return _apps;
}

- (NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 3; // 最大并发数 == 3
    }
    return _queue;
}

- (NSMutableDictionary *)operations
{
    if (!_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}

- (NSMutableDictionary *)images
{
    if (!_images) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}

#pragma mark 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"operation_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    HMApp *app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    
    // 显示图片
    // 保证一个url对应一个HMDownloadOperation
    // 保证一个url对应UIImage对象
    
    UIImage *image = self.images[app.icon];
    if (image) { // 缓存中有图片
        cell.imageView.image = image;
    } else { // 缓存中没有图片, 得下载
        cell.imageView.image = [UIImage imageNamed:@"57437179_42489b0"];
        
        HMDownloadOperation *operation = self.operations[app.icon];
        if (operation) { // 正在下载
            // ... 暂时不需要做其他事
            
        } else { // 没有正在下载
            // 创建操作
            operation = [[HMDownloadOperation alloc] init];
            operation.url = app.icon;
            operation.delegate = self;
            operation.indexPath = indexPath;
            [self.queue addOperation:operation]; // 异步下载
            
            self.operations[app.icon] = operation;
        }
    }
    
    // SDWebImage : 专门用来下载图片
    return cell;
}

#pragma mark HMDownloadOperationDelegate
- (void)downloadOperation:(HMDownloadOperation *)operation didFinishDownload:(UIImage *)image
{
    // 1.移除执行完毕的操作
    [self.operations removeObjectForKey:operation.url];
    
    if (image) {
        // 2.将图片放到缓存中(images)
        self.images[operation.url] = image;
        
        // 3.刷新表格
        [self.tableView reloadRowsAtIndexPaths:@[operation.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        // 3.将图片写入沙盒
        //        NSData *data = UIImagePNGRepresentation(image);
        //        [data writeToFile:@"" atomically:<#(BOOL)#>];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 开始拖拽
    // 暂停队列
    [self.queue setSuspended:YES];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self.queue setSuspended:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
