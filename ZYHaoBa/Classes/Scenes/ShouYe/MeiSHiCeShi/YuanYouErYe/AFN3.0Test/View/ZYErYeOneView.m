//
//  ZYErYeOneView.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYErYeOneView.h"
#import "DataInfo.h"

@interface ZYErYeOneView()<UITableViewDelegate,UITableViewDataSource>

{
    AFHTTPSessionManager *manager;
}

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation ZYErYeOneView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
    }
    return self;
}

#pragma mark- 在设置urlString中请求数据
-(void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    //    请求数据在这里写
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    [self requestDataForGet];
    
//    [self requestDataForPost];
    
    [self test];
}

- (void)test {
    NSMutableDictionary * dictp = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"930", @"userid",@"1", @"pageIndex", nil];
    [ZYHttpsTool POST:_urlString parameters:dictp success:^(id  _Nullable responseObject) {
        showAlert(@"请求成功");
        NSDictionary * resultDic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [self intersectDataInfo1:resultDic1];
    } failure:^(NSError *error) {
        showAlert(@"请求失败");
    }];
    
}

- (void)requestDataForGet {
    
    [manager GET:_urlString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray * resultDic = responseObject[@"pushhistorylist"];
        [self intersectDataInfo:resultDic];
        //        xh(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        xh(@"Error: %@", error);
    }];
}

- (void)requestDataForPost {
    
    NSMutableDictionary * dictp = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"930", @"userid",@"1", @"pageIndex", nil];
    /*
     //    [manager POST:_urlString parameters:dictp constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
     //
     //    } progress:^(NSProgress * _Nonnull uploadProgress) {
     //
     //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //        NSArray * resultDic = responseObject[@"pushhistorylist"];
     //        [self intersectDataInfo:resultDic];
     //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     //
     //    }];
     */
    [manager POST:_urlString parameters:dictp constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * resultDic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [self intersectDataInfo1:resultDic1];
        //        NSArray * resultDic = responseObject[@"pushhistorylist"];
        //        [self intersectDataInfo:resultDic];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
#warning --这个请求不下来数据
    /*
     //    [manager POST:_urlString parameters:dictp progress:^(NSProgress * _Nonnull uploadProgress) {
     //
     //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //        NSArray * resultDic = responseObject[@"pushhistorylist"];
     //        [self intersectDataInfo:resultDic];
     //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     //
     //    }];
     */
}

#pragma mark- 弃用
- (void)intersectDataInfo:(NSArray *)resultDic {
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary * dic in resultDic) {
        DataInfo * data = [[DataInfo alloc] init];
        [data setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:data];
    }
    [self.tableView reloadData];
}

#pragma mark- 使用
- (void)intersectDataInfo1:(NSDictionary *)resultDic {
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary * dic in resultDic[@"pushhistorylist"]) {
        DataInfo * data = [[DataInfo alloc] init];
        [data setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:data];
    }
    [self.tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"erYeOne_Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
        
    }
    DataInfo * data = _dataArray[indexPath.row];
    cell.textLabel.text = data.message_title;
    //    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",data.message_id];
    cell.detailTextLabel.text = data.message_createTime;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.block(@"第二界面二级页面");
}

-(void)dealloc {
    [manager.operationQueue cancelAllOperations];
}

@end
