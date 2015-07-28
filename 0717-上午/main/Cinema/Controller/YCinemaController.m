//
//  FriendListController.m
//  小项目 微信聊天
//
//  Created by 杨少伟 on 15/7/15.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YCinemaController.h"
#import "YDistrict.h"
#import "YTableSectionView.h"
#import "DataService.h"
#import "YCinema.h"
#import "YCinemaCell.h"

#define ID @"cell"
@interface YCinemaController () <YTableSectionViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *groups;
@end

@implementation YCinemaController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
   
    
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"YCinemaCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:ID];
    
}

- (NSArray *)groups
{
    if (_groups == nil) {
        _groups = [self loadData];
    }
    return _groups;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    YDistrict *group = self.groups[section];
    if (group.isVisible) {
        NSArray *friends = group.cinemas;
        return friends.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YCinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSArray *cinemas = [self.groups[section] cinemas];
    YCinema *cinema = cinemas[row];
    cell.cinema = cinema;
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    YDistrict *group = self.groups[section];
    YTableSectionView *sectionView = [YTableSectionView sectionView];
    sectionView.section = section;
    sectionView.delegate = self;
    sectionView.group = group;
    return sectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return YSectionViewHeight;
}



- (void)tableSectionView:(YTableSectionView *)sectionView didSelectedAtIndex:(NSInteger)section
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}

-(NSArray *)loadData
{
    NSDictionary *listDict = [DataService getDataFromJsonFile:@"district_list.json"];
    NSArray *districtList = listDict[@"districtList"];
    NSMutableArray *districts = [NSMutableArray array];
    for (NSDictionary *dict in districtList) {
        YDistrict *district = [YDistrict districtWithDictionary:dict];
        [districts addObject:district];
    }
    
    NSDictionary *cinemaInfo = [DataService getDataFromJsonFile:@"cinema_list.json"];
    NSArray *cinemaList = cinemaInfo[@"cinemaList"];
    for (NSDictionary *dict in cinemaList) {
        YCinema *cinema = [YCinema cinemaWithDictionary:dict];
        for (YDistrict *area in districts) {
            if ([area.objectId isEqualToString:cinema.districtId]) {
                if (area.cinemas == nil) {
                    area.cinemas = [NSMutableArray array];
                }
                [area.cinemas addObject:cinema];
            }
        }
    }
    
    return districts;
}


@end
