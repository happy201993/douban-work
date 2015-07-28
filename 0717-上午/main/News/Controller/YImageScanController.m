//
//  YImageScanController.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/22.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YImageScanController.h"
#import "YImageScanView.h"
#import "YImageScanCell.h"
#import "YImageScrollView.h"
#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString *const reuseIdentifier = @"dslkfj";
@interface YImageScanController ()<YImageScanViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation YImageScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    YImageScanView *imageScanView = [[YImageScanView alloc] initWithFrame:self.view.bounds style:YImageScanViewStyleDefault];
//    [self.view addSubview:imageScanView];
//    //设置数据
//    imageScanView.imageList = self.imageList;
//    imageScanView.currentPageIndex = self.index;
//    imageScanView.delegate = self;
//    imageScanView.label.hidden = YES;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem  = item;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.title = imageScanView.label.text;
    [self createCollectionView];
    
    //注册监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singleTap:) name:YImageScrollViewSingleTapNotification object:nil];
}

//接收到单机通知后触发的方法
- (void)singleTap:(NSNotification *)notification
{
    
    BOOL isHidden = self.navigationController.navigationBar.isHidden;
    [self.navigationController setNavigationBarHidden:!isHidden animated:YES];
}

- (void)dealloc
{
    //对象销毁后把自己从通知中心移除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    行间距
    layout.minimumLineSpacing = 10;
//    相邻项的间距
    layout.minimumInteritemSpacing = 10;
//    设置每个item的大小
    layout.itemSize = CGSizeMake(YScreenWidth, YScreenHeight);
//    设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置frame page根据这里设置的宽度来
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, YScreenWidth + 10, YScreenHeight) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
//    设置代理
    self.collectionView.delegate = self;
//    设置数据源
    self.collectionView.dataSource = self;
    //设置分页
    self.collectionView.pagingEnabled = YES;
//    注册cell
    [self.collectionView registerClass:[YImageScanCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    
}
- (void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YImageScanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.image = self.imageList[indexPath.row];
    return cell;
}

- (void)imageScanView:(YImageScanView *)imageScanView currentIndex:(NSInteger)index
{
    self.title = [NSString stringWithFormat:@"%li/%li",index+1,self.imageList.count];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //当移除掉一个cell的时候 让他的缩放大小设置为1
    YImageScanCell *photoCell = (YImageScanCell *)cell;
    UIScrollView *scrollView = (UIScrollView *)[photoCell.contentView viewWithTag:100];
    [scrollView setZoomScale:1.0];
}


@end
