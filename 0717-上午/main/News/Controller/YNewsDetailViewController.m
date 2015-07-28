//
//  YNewsDetailViewController.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/22.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YNewsDetailViewController.h"
#import "YNewsDetail.h"
#import "DataService.h"
#import "YNewsDetailCell.h"
#import "YImageScanController.h"
#import "BaseNavigationController.h"
#import "YNews.h"
static NSString * const reuseIdentifier = @"Cell";

@interface YNewsDetailViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSArray *detailList;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,copy) NSString *htmlUrl;
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation YNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
    if (self.news.type == 0) {
     [self createWebView];
    }
}

- (void)createWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    [self.webView.scrollView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    //加载网页
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];

    
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}



- (NSArray *)detailList
{
    if (_detailList == nil) {
        _detailList = [self loadData];
    }
    return _detailList;
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置layout
    layout.minimumLineSpacing = YMargin;
    layout.minimumLineSpacing = YMargin;
    layout.itemSize = CGSizeMake((YScreenWidth - 5 * YMargin)/4, 80);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    
//    delegete
    self.collectionView.delegate = self;
    self.collectionView.dataSource =self;
    
    
    //注册cell
    UINib *nib = [UINib nibWithNibName:@"YNewsDetailCell" bundle:nil];
     [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.news.type == 0) {
        return 0;
    }
    return self.detailList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YNewsDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //设置模型
//    cell.backgroundColor = [UIColor redColor];
    cell.detail = self.detailList[indexPath.row];
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(YMargin, YMargin, YMargin, YMargin);
}


-(NSArray *)loadData
{
    NSArray * array = [DataService getDataFromJsonFile:@"image_list.json"];
    NSMutableArray *details = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        YNewsDetail *ditail = [YNewsDetail newsDetailWithDictionary:dict];
        [details addObject:ditail];
    }
    return details;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    YImageScanController *vc = [[YImageScanController alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    for (YNewsDetail *detail in self.detailList) {
        [array addObject:detail.image];
    }
    vc.imageList = array;
    vc.index = indexPath.row;
    BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self.navigationController.tabBarController presentViewController:navi animated:YES completion:nil];
}

@end
