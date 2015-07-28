//
//  YPosterView.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/24.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YPosterView.h"
#import "YPosterCell.h"
#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height

#define YHeaderViewH 136
#define YHeaderViewOriginY -36
#define YBottomViewH 35
#define YTabBarH 49
#define YNavigationBarH 64
#define YCollectionViewOriginY (YHeaderViewH + YHeaderViewOriginY)
#define YCollectionViewH (YScreenHeight - YCollectionViewOriginY - YTabBarH - YBottomViewH)
#define YSmallPosterViewH 100
#define YMargin 10
#define YAlphaViewColor 80/255.0
#define YSmallItemW 80
#define YLargeItemW (YScreenWidth*3/4)


static NSString *const reuseIdentifierTop = @"cellfk";
static NSString *const reuseIdentifierPoster = @"hahah";
static NSInteger const smallCollectionViewTag = 10086;
static NSInteger const largeCollectionViewTag = 10010;
#define YPullDownButtonTag 100
@interface YPosterView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIView *headerView;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UILabel *bottomView;

@property (nonatomic,strong) UIControl *alphaView;

@property (nonatomic,assign) NSInteger currentPageIndex;



@end

@implementation YPosterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createPosterView];
        [self createBottomView];
        
        [self createAlphaView];
        [self createHeaderView];
        
        [self createGesture];
    }
    return self;
}


- (void)createPosterView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置layout
    CGFloat itemW = YLargeItemW;
    CGFloat itemH = YCollectionViewH * 0.9;
    layout.itemSize = CGSizeMake(itemW,itemH);
    
    CGFloat padding = (YScreenWidth - itemW)/2;
//    layout.minimumInteritemSpacing = padding;
    layout.minimumLineSpacing = YMargin;
    layout.sectionInset = UIEdgeInsetsMake(0, padding, 0, padding);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, YCollectionViewOriginY, YScreenWidth, YCollectionViewH) collectionViewLayout:layout];
    [self addSubview:self.collectionView];
    self.collectionView.tag = largeCollectionViewTag;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell
    [self.collectionView registerClass:[YPosterCell class] forCellWithReuseIdentifier:reuseIdentifierPoster];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
}


- (void)createAlphaView
{
    self.alphaView = [[UIControl alloc] initWithFrame:self.bounds];
   
    [self addSubview:self.alphaView];
    
    //颜色
    self.alphaView.backgroundColor = [UIColor colorWithRed:YAlphaViewColor green:YAlphaViewColor blue:YAlphaViewColor alpha:0.8];
    [self.alphaView addTarget:self action:@selector(alphaViewClicked) forControlEvents:UIControlEventTouchUpInside];
    self.alphaView.hidden = YES;
}



- (void)createHeaderView
{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, YHeaderViewOriginY, YScreenWidth, YHeaderViewH)];
    [self addSubview:self.headerView];
    
 
    //背景图片
    UIImageView *backGroundView = [[UIImageView alloc] initWithFrame:self.headerView.bounds];
    [self.headerView addSubview:backGroundView];
    UIImage *originImage = [UIImage imageNamed:@"indexBG_home"];
    UIImage *newImage = [originImage stretchableImageWithLeftCapWidth:originImage.size.width/2 topCapHeight:1];
    [backGroundView setImage:newImage];
    
    
    //小海报
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(YSmallItemW, YSmallPosterViewH);
    layout.minimumLineSpacing = YMargin;
    CGFloat padding = (YScreenWidth - YSmallItemW)/2;
    layout.sectionInset = UIEdgeInsetsMake(0, padding, 0, padding);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *mSmallPosterView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, YScreenWidth, YSmallPosterViewH) collectionViewLayout:layout];
    [self.headerView addSubview:mSmallPosterView];
    mSmallPosterView.showsHorizontalScrollIndicator = NO;
    mSmallPosterView.backgroundColor = [UIColor clearColor];
    mSmallPosterView.tag = smallCollectionViewTag;
    
    //代理
    mSmallPosterView.delegate = self;
    mSmallPosterView.dataSource = self;
    //注册cell
    [mSmallPosterView registerClass:[YPosterCell class] forCellWithReuseIdentifier:reuseIdentifierTop];
    
    //下拉按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headerView addSubview:button];
    CGFloat buttonW = 20;
    CGFloat buttonH = 20;
    CGFloat buttonX = (YScreenWidth - buttonW)/2;
    CGFloat buttonY = YHeaderViewH - buttonH - 5;
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    button.tag = YPullDownButtonTag;
    [button addTarget:self action:@selector(pullButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];
    
    // 添加灯光
    UIImageView *light1 = [[UIImageView alloc] initWithFrame:CGRectMake(YScreenWidth/2 - YSmallItemW - YSmallItemW/2- YMargin, 0, YSmallItemW, YSmallPosterViewH)];
    light1.image = [UIImage imageNamed:@"light"];
    [self.headerView addSubview:light1];
    
    
    UIImageView *light2 = [[UIImageView alloc] initWithFrame:CGRectMake(YScreenWidth/2 + YSmallItemW/2 + YMargin, 0, YSmallItemW, YSmallPosterViewH)];
    light2.image = [UIImage imageNamed:@"light"];
    [self.headerView addSubview:light2];
    
    
}


- (void)createGesture
{
    UISwipeGestureRecognizer *downGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(pullDownGesture)];
    downGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:downGesture];
}

- (void)pullDownGesture
{
    
    UIButton *button = (UIButton *)[self.headerView viewWithTag:YPullDownButtonTag];
    if (!button.isSelected) {
        [self pullButtonClicked:button];
    }
    
}
- (void)alphaViewClicked
{
    UIButton *button = (UIButton *)[self.headerView viewWithTag:YPullDownButtonTag];
    [self pullButtonClicked:button];
}

- (void)pullButtonClicked:(UIButton *)button
{
    CGRect f = self.headerView.frame;
    if (!button.selected) {
        //显示
        f.origin.y = YNavigationBarH;
        self.alphaView.hidden = NO;
    }
    else
    {
        //隐藏
        f.origin.y = YHeaderViewOriginY;
        self.alphaView.hidden = YES;
    }
    [UIView animateWithDuration:0.2 animations:^{
        button.selected = !button.selected;
        self.headerView.frame = f;
    }];
 
}

- (void)createBottomView
{
    self.bottomView = [[UILabel alloc] init];
    [self addSubview:self.bottomView];
    CGFloat bottomViewX = 0;
    CGFloat bottomViewH = YBottomViewH;
    CGFloat bottomViewY = YScreenHeight - YTabBarH - bottomViewH;
    CGFloat bottomViewW = YScreenWidth;
    self.bottomView.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    self.bottomView.textColor = [UIColor whiteColor];
    self.bottomView.textAlignment = NSTextAlignmentCenter;
  
}


-(void)setMoveList:(NSArray *)moveList
{
    _moveList = moveList;
    self.bottomView.text = [moveList[0] title];
}

#pragma mark - 数据源方法
-  (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.moveList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YPosterCell *cell;
    NSString *reuseIdentifier;
    YPosterCellStyle style;
    if (collectionView.tag == smallCollectionViewTag){
        //小图
        reuseIdentifier = reuseIdentifierTop;
        style = YPosterCellStyleSmall;
    }
    else{
        //大图
        reuseIdentifier = reuseIdentifierPoster;
        style = YPosterCellStyleLarge;
    }
   
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    YMovie *movie = self.moveList[indexPath.row];
    cell.style = style;
    cell.movie = movie;
    return cell;
}


/**
 *  @param velocity            速度
 *  @param targetContentOffset 最终要偏移的位置
 */

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{

    CGFloat itemW = YSmallItemW;
    CGFloat otherItemW = YLargeItemW;
    UIScrollView *anotherView = self.collectionView;
    if(scrollView.tag == largeCollectionViewTag)
    {
        itemW = YLargeItemW;
        otherItemW = YSmallItemW;
        anotherView = (UIScrollView *)[self.headerView viewWithTag:smallCollectionViewTag];
    }
    CGFloat offsetX = targetContentOffset->x;
    
    
    NSInteger index = (offsetX + (0.5*itemW+YMargin/2))/(itemW+YMargin);
    CGPoint offset = CGPointMake(index*(itemW+YMargin), 0);
    (*targetContentOffset) = offset;
    //改变另一个图的偏移
    
    [anotherView setContentOffset:CGPointMake(index*(otherItemW + YMargin), 0) animated:YES];
    //记录当前页
    self.currentPageIndex = index;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.tag == largeCollectionViewTag)
    {
        CGFloat offsetX = scrollView.contentOffset.x;
        CGFloat itemW = YScreenWidth*3/4;
        NSInteger index = (offsetX + (0.5*itemW+YMargin/2))/(itemW+YMargin);
        YMovie *movie = self.moveList[index];
        self.bottomView.text = movie.title;
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    YPosterCell *cell;
    CGFloat itemW = YLargeItemW;
    CGFloat otherItemW = YSmallItemW;
    UIScrollView *anotherView = (UIScrollView *)[self.headerView viewWithTag:smallCollectionViewTag];
    if (collectionView.tag == largeCollectionViewTag) {
       
        if(indexPath.row == self.currentPageIndex)
        {
            cell = (YPosterCell*)[collectionView cellForItemAtIndexPath:indexPath];
            [cell flipCell];
        }
        else
        {
            [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            self.currentPageIndex = indexPath.row;
            //改变另一个小图的位置
            [anotherView setContentOffset:CGPointMake(self.currentPageIndex*(otherItemW + YMargin), 0) animated:YES];
        }
    }
    
    else if (collectionView.tag == smallCollectionViewTag)
    {
        itemW = YSmallItemW;
        otherItemW = YLargeItemW;
        anotherView = self.collectionView;
        if (indexPath.row != self.currentPageIndex) {
            [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            self.currentPageIndex = indexPath.row;
            [anotherView setContentOffset:CGPointMake(self.currentPageIndex*(otherItemW + YMargin), 0) animated:YES];
        }
    }
}




@end
