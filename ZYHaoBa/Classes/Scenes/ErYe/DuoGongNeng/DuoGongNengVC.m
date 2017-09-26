//
//  DuoGongNengVC.m
//  ZYHaoBa
//
//  Created by ylcf on 17/3/28.
//  Copyright © 2017年 正羽. All rights reserved.
//

#import "DuoGongNengVC.h"
#import "ConfigTableViewController.h"

static NSString *cellIdentifier = @"reuseIdentifier";

@interface DuoGongNengVC () {
    NSString *test;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DuoGongNengVC {
    NSArray *_sections;
    NSArray *_classNames;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:nil];
    [self.navigationController.navigationBar setTintColor:nil];
    [self.navigationController.navigationBar setBarTintColor:nil];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:nil];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    self.navigationItem.title = @"功能列表";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sections = @[@"导航条", @"列表", @"相册", @"电商类", @"网络", @"其他"];
    _classNames = @[
                    @[@[@"错误示范", @"WrongTrans1ViewController"],
                      @[@"顶部图片", @"TableHeaderViewController"],
                      @[@"顶部图片+导航条切换", @"TableHeaderAndNaviBarViewController"]],
                    @[@[@"卡顿列表", @"LowPerformanceTableViewController"],
                      @[@"流畅列表", @"HighPerformanceTableViewController"],
                      @[@"列表返回顶部", @"ScrollViewController"]],
                    @[@[@"相册选取", @"AlbumsCameraViewController"],
                      @[@"相册-iOS8", @"PhotosFrameworkViewController"]],
                    @[@[@"淘宝", @"TaobaoViewController"],
                      @[@"京东", @"JDViewController"]],
                    @[@[@"网络延迟", @"NetworkDelayViewController"],],
                    @[@[@"像素线", @"PixelViewController"],
                      @[@"pop", @"AnimationsListViewController"]],
                    ];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    UIBarButtonItem *config = [[UIBarButtonItem alloc] initWithTitle:@"配置" style:UIBarButtonItemStylePlain target:self action:@selector(config)];
    self.navigationItem.rightBarButtonItem = config;
}

- (void)config{
    ConfigTableViewController *config = [[ConfigTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:config animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_classNames[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _sections[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _classNames[indexPath.section][indexPath.row][0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[NSClassFromString(_classNames[indexPath.section][indexPath.row][1]) alloc] init];
    if (vc == nil) {
        return;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
@end
