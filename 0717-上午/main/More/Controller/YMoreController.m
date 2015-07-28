//
//  YMoreController.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/17.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YMoreController.h"
#import <SDWebImage/SDImageCache.h>
@interface YMoreController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSArray *details;
@property (nonatomic,strong)  SDImageCache *cache ;
@end

@implementation YMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"清除缓存",@"给个评价",@"检查新版本",@"商务合作",@"欢迎页",@"关于"];
    self.images = @[@"more_set",@"more_set",@"more_set",@"more_set",@"more_set",@"more_set"];
    self.details = @[@"8.0M",@"",@"",@"",@"",@""];
    [self createTableView];
    
    self.cache =[[SDImageCache sharedImageCache] init];
  
    NSString *path =  [self.cache defaultCachePathForKey:@"http://img31.mtime.cn/mg/2012/06/28/110832.94975548.jpg"];
    NSLog(@"path = %@",path);
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)createTableView
{
    CGFloat tableX = 0;
    CGFloat tableY = 0;
    CGFloat tableW = YViewWidth;
    CGFloat tableH = YViewHeight - YTopBarH - YBottomBarH;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 创建cell
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSString *image = self.images[indexPath.row];
    NSString *title = self.titles[indexPath.row];
    NSString *detail = self.details[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:image];
    cell.textLabel.text = title;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = detail;
    
    if (indexPath.row == 0) {
        NSUInteger size = self.cache.getSize;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",size/1000000.0];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您确定要清楚缓存吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
   
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [self.cache clearDiskOnCompletion:^{
            [self.tableView reloadData];
        }];
        
    }
}

@end
