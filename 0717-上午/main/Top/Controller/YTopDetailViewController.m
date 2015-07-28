//
//  YTopDetailViewController.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/27.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YTopDetailViewController.h"
#import "YMovieDetail.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DataService.h"
#import "YMovieDetail.h"
#import "YComment.h"
#import "YCommentCell.h"
#define YHeaderViewH 250
#define YMargin 10
#define YNameH 30
#define YImageW 100
#define YImageH 150
#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height
#define YLabelW (YScreenWidth - 3*YMargin - YImageW)
#define YLabelH 21
#define YLableMargin ((YImageH - YNameH - 4*YLabelH)/4)
#define YLableTextSize 14
@interface YTopDetailViewController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UICollectionView *collectionView;

@end
static NSString *const reuseCollectionViewIdentifier = @"sdlkfjsdlf";
static NSString *const reuseTableViewIdentifier = @"lkjlk";

@implementation YTopDetailViewController

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"电影详情";
    [self createTopView];
    [self createTableView];
}

#pragma mark - 创建视图
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerView;
    UINib *nib = [UINib nibWithNibName:@"YCommentCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseTableViewIdentifier];
}


- (void)createTopView
{
    YMovieDetail *detail = self.detail;
    //imageVIew
    UIImageView *poster = [[UIImageView alloc] init];
    [self.headerView addSubview:poster];
    CGFloat posterX = YMargin;
    CGFloat posterY = YMargin;
    CGFloat posterW = YImageW;
    CGFloat posterH = YImageH;
    poster.frame = CGRectMake(posterX, posterY, posterW, posterH);
    
    
    [poster sd_setImageWithURL:[NSURL URLWithString:detail.image]];
    
    //name
    UILabel *name = [[UILabel alloc] init];
    [self.headerView addSubview:name];
    CGFloat nameX = CGRectGetMaxX(poster.frame) + YMargin;
    CGFloat nameY = posterY;
    CGFloat nameW = YLabelW;
    CGFloat nameH = YNameH;
    name.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    name.textColor = [UIColor orangeColor];
    name.font = [UIFont systemFontOfSize:20];
    name.text = detail.titleCn;
    
    //导演
    UILabel *director = [[UILabel alloc] init];
    [self.headerView addSubview:director];
    CGFloat directorX = nameX;
    CGFloat directorY = CGRectGetMaxY(name.frame) + YLableMargin;
    CGFloat directorW = nameW;
    CGFloat directorH = YLabelH;
    director.frame = CGRectMake(directorX, directorY, directorW, directorH);
    
    director.textColor = [UIColor whiteColor];
    director.font = [UIFont systemFontOfSize:YLableTextSize];
    
    director.text = [NSString stringWithFormat:@"导演:%@",[self getStringFromArray:detail.directors]];

   
    //主演
    UILabel *actor = [[UILabel alloc] init];
    [self.headerView addSubview:actor];
    CGFloat actorX = directorX;
    CGFloat actorY = CGRectGetMaxY(director.frame) + YLableMargin;
    CGFloat actorW = directorW;
    CGFloat actorH = directorH;
    actor.frame = CGRectMake(actorX, actorY, actorW, actorH);
   
    actor.textColor = [UIColor whiteColor];
    actor.font = [UIFont systemFontOfSize:YLableTextSize];
    actor.text = [NSString stringWithFormat:@"主演:%@",[self getStringFromArray:detail.actors]];

    
    //类型
    UILabel *type = [[UILabel alloc] init];
    [self.headerView addSubview:type];
    CGFloat typeX = actorX;
    CGFloat typeY = CGRectGetMaxY(actor.frame) + YLableMargin;
    CGFloat typeW = actorW;
    CGFloat typeH = actorH;
    type.frame = CGRectMake(typeX, typeY, typeW, typeH);
  
    type.textColor = [UIColor whiteColor];
    type.font = [UIFont systemFontOfSize:YLableTextSize];
    type.text = [NSString stringWithFormat:@"类型:%@",[self getStringFromArray:detail.type]];

    
    //中国 2012-7-5
    UILabel *info = [[UILabel alloc] init];
    [self.headerView addSubview:info];
    CGFloat infoX = actorX;
    CGFloat infoY = CGRectGetMaxY(type.frame) + YLableMargin;
    CGFloat infoW = actorW;
    CGFloat infoH = actorH;
    info.frame = CGRectMake(infoX, infoY, infoW, infoH);
    
    info.textColor = [UIColor whiteColor];
    info.font = [UIFont systemFontOfSize:YLableTextSize];
    info.text = [NSString stringWithFormat:@"%@ %@",detail.info[@"location"],detail.info[@"date"]];
    
    [self createImageListView];
}

- (void)createImageListView
{
    CGFloat collectionViewX = YMargin;
    CGFloat collectionViewY = YMargin*2 + YImageH;
    CGFloat collectionViewW = YScreenWidth - 2*YMargin;
    CGFloat collectionViewH = YHeaderViewH - collectionViewY;
    CGFloat imageW = collectionViewH - YMargin;
    CGFloat padding = (collectionViewW - 4 * imageW)/5;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing =  padding;
    layout.sectionInset = UIEdgeInsetsMake(0, padding, 0, padding);
    layout.itemSize = CGSizeMake(imageW, imageW);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH)collectionViewLayout:layout];
    [self.headerView addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseCollectionViewIdentifier];
    
    //设置样式
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.layer.borderWidth = 1;
    self.collectionView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.collectionView.layer.cornerRadius = 5;
    
    
}


- (NSString *)getStringFromArray:(NSArray *)array
{
    NSMutableString *string = [NSMutableString string];
    for (NSString *str in array) {
        [string appendString:str];
        if (![str isEqualToString:[array lastObject]]) {
            [string appendString:@"、"];
        }
        
    }
    return string;
}
- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, YHeaderViewH)];
    }
    return _headerView;
}


#pragma mark - collection数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.detail.images.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCollectionViewIdentifier forIndexPath:indexPath];
    UIImageView *imageView;
    
    if (cell.contentView.subviews.count == 0) {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        [cell.contentView addSubview:imageView];
        imageView.layer.cornerRadius = 10;
        
    }
    NSString *url = self.detail.images[indexPath.row];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    cell.backgroundView = imageView;
    
    return cell;
}


#pragma mark - tableview 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseTableViewIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.comment = self.comments[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YCommentCell cellHeightWithComment:self.comments[indexPath.row]];
}


#pragma mark - 加载数据
-(YMovieDetail *)detail
{
    if (_detail == nil) {
        NSDictionary *info = [DataService getDataFromJsonFile:@"movie_detail.json"];
        YMovieDetail *detail = [YMovieDetail movieDetailWithDictionary:info];
        _detail = detail;
    }
    return _detail;
}

- (NSArray *)comments
{
    if (_comments == nil) {
        NSDictionary *info = [DataService getDataFromJsonFile:@"movie_comment.json"];
        NSArray *lists = info[@"list"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in lists) {
            YComment *comment = [YComment commentWithDictionary:dict];
            [array addObject:comment];
        }
        _comments = array;
    }
    return _comments;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *vodies = self.detail.videos;
//    {
//        "url" : "http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4",
//        "image" : "http://img21.mtime.cn/mg/2012/04/23/212649.32521220.jpg"
//    }
    NSDictionary *vodie = vodies[indexPath.row];
    NSString *url = vodie[@"url"];
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:url]];
    [self presentMoviePlayerViewControllerAnimated:vc];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
