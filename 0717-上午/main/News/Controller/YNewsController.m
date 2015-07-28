//
//  YNewsController.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/17.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YNewsController.h"
#import "YNews.h"
#import "YNewsCell.h"
#import "DataService.h"
#import "YHearView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YNewsDetailViewController.h"
#define YOriginOffset -64
#define YHeaderViewH 168

@interface YNewsController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *newsList;

@property (nonatomic,strong) YHearView *headerView;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIView *headerLabel;

@property (nonatomic,strong) YNews *topNews;



@end

@implementation YNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self createTableView];
}

- (NSArray *)newsList
{
    if (_newsList == nil) {
        _newsList =  [self loadData];
    }
    return _newsList;
}

- (YNews *)topNews
{
    if (_newsList == nil) {
        _newsList =  [self loadData];
    }
    return _topNews;
}

#pragma mark - tableView
- (void)createTableView
{
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    
    self.tableView.frame = self.view.bounds;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UINib *nib = [UINib nibWithNibName:@"YNewsCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"news"];
    
    

    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, YHeaderViewH)];
//    headerView.backgroundColor = [UIColor clearColor];
//    self.tableView.tableHeaderView = headerView;
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, YScreenWidth, YHeaderViewH)];
//    [self.view addSubview:self.imageView];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topNews.image]];
//    CGFloat labelY = YHeaderViewH - 30;
//    UIView *headerLabel = [[UIView alloc] initWithFrame:CGRectMake(0, labelY, 375, 30)];
//    headerLabel.alpha = 0.8;
//    headerLabel.backgroundColor = [UIColor grayColor];
//    [self.imageView addSubview:headerLabel];
//    UILabel *label = [[UILabel alloc] initWithFrame:headerLabel.bounds];
//    label.textColor = [UIColor whiteColor];
//    label.text = self.topNews.title;
//    [headerLabel addSubview:label];
//    self.headerLabel = headerLabel;
    
    self.headerView = [[YHearView alloc] initWithFrame:CGRectMake(0, 0, 0, YHeaderViewH)];
    self.tableView.tableHeaderView = self.headerView;
    self.headerView.image = self.topNews.image;
    self.headerView.title = self.topNews.title;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"news" forIndexPath:indexPath];
    cell.news = self.newsList[indexPath.row];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
//    CGRect frame = self.imageView.frame;
//    CGRect headerLabelFrame = self.headerLabel.frame;
//    if (offsetY <= YOriginOffset) {
////        往下移动
////        图片高度变化
//        CGFloat newHeight = YHeaderViewH + YOriginOffset - offsetY;
//        CGFloat newWidth = newHeight * 375/YHeaderViewH;
//        frame.size = CGSizeMake(newWidth, newHeight);
//        frame.origin.x = (375 - newWidth)/2;
//        frame.origin.y = 64;
//        headerLabelFrame.origin.x = -frame.origin.x;
//    }
//    else
//    {
//        //往上移动
//        frame.origin.y = - offsetY;
//    }
//    headerLabelFrame.origin.y = frame.size.height - 30;
//    self.imageView.frame = frame;
//    self.headerLabel.frame = headerLabelFrame;
    
    if (offsetY < YOriginOffset) {
       
        CGFloat newY = offsetY - YOriginOffset;
        CGFloat newH = YHeaderViewH + YOriginOffset - offsetY;
        CGFloat newW = YScreenWidth * newH/YHeaderViewH;
        CGFloat newX = (YScreenWidth - newW)/2;
        self.headerView.imageView.frame = CGRectMake(newX, newY, newW, newH);
    };
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //取消选中
   NSIndexPath *indexPath =  [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}




#pragma mark - 加载数据
-(NSArray *)loadData
{
    NSArray *list =  [DataService getDataFromJsonFile:@"news_list.json"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in list) {
        NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:dict];
        YNews *news = [YNews newsWithDictionary:mDict];
        [array addObject:news];
    }
    _topNews = array[0];
    [array removeObjectAtIndex:0];
    return array;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YNews *news = self.newsList[indexPath.row];
  
    YNewsDetailViewController *vc = [[YNewsDetailViewController alloc] init];
    vc.news = news;
    [self.navigationController pushViewController:vc animated:YES];
}







@end
