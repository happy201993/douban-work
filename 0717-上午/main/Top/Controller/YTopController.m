//
//  YTopController.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/17.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YTopController.h"
#import "YMovie.h"
#import "DataService.h"
#import "YTopCell.h"
#import "YTopDetailViewController.h"
#define YMargin 10
static NSString *const ID = @"topcell";


@interface YTopController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *movieList;
@end

@implementation YTopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createCollectionView];
}


- (void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"YTopCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:ID];
    self.collectionView.backgroundColor = [UIColor clearColor];
    layout.itemSize = CGSizeMake((YScreenWidth - 4*YMargin)/3, 180);
    layout.minimumLineSpacing = YMargin; //每行间距10
    layout.minimumInteritemSpacing = YMargin; //每项间隔10
    //设置section的内边距
    layout.sectionInset = UIEdgeInsetsMake(YMargin, YMargin, 0, YMargin);

}

- (NSArray *)movieList
{
    if (_movieList == nil) {
        _movieList =  [self loadData];
    }
    return _movieList;
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.movieList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    cell.movie = self.movieList[indexPath.row];
    
    return cell;
}

- (NSArray *)loadData
{
    
     NSMutableArray *movieList = [NSMutableArray array];
    YHttpRequest *request = [[YHttpRequest alloc] init];
    [request getDataWithRelativePath:DBTop250 WithParams:nil withBlock:^(id data, NSError *error) {
        
        if (data != nil) {
            NSDictionary * dict = data;
            self.title = dict[@"title"];
            NSArray *array = dict[@"subjects"];
            NSInteger i = 0;
            for (NSDictionary *movieInfo in array) {
                i++;
                NSString *objectId = movieInfo[@"id"];
                NSString *movieTitle = movieInfo[@"title"];
                NSString *year = movieInfo[@"year"];
                NSDictionary *rating = movieInfo[@"rating"];
                NSNumber *average = rating[@"average"];
                NSDictionary *images = movieInfo[@"images"];
                NSDictionary *movie = @{@"objectId":objectId,
                                        @"title":movieTitle,
                                        @"year":year,
                                        @"average":average,
                                        @"images":images
                                        };
                YMovie *mMovie = [YMovie moveWithDictionary:movie];
                [movieList addObject:mMovie];
            }
            _movieList = movieList;
            [self.collectionView reloadData];
            
        }
    }];
   
    return movieList;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YTopDetailViewController *vc = [[YTopDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
