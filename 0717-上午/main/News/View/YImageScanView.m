//
//  YImageScanView.m
//  用ScrollView实现图片浏览器
//
//  Created by 杨少伟 on 15/7/13.
//  Copyright (c) 2015年 yang. All rights reserved.
//

#import "YImageScanView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height

#define YImageWidth self.bounds.size.width
#define YImageHeight self.bounds.size.height



#define YScrollViewWidth (self.bounds.size.width+10)
#define YScrollViewHeight self.bounds.size.height

#define YImageTag 100



@interface YImageScanView()


@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currPage;

@property (nonatomic,strong) NSTimer *timer;
@end

@implementation YImageScanView


- (instancetype)initWithFrame:(CGRect)frame style:(YImageScanViewStyle)style
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        switch (style) {
            case YImageScanViewStyleDefault:
                self.zoomEnabled = YES;
                self.autoPlaying = NO;
                _style = YImageScanViewStyleDefault;
                break;
            case YImageScanViewStyleAutoPlaying:
                self.zoomEnabled = NO;
                self.autoPlaying = YES;
                _style = YImageScanViewStyleAutoPlaying;
                break;
            default:
                break;
        }
        
       
    }
    return self;
}

- (void)setImageList:(NSArray *)imageList
{
    _imageList = imageList;
    if (self.scrollView == nil) {
        [self setMScrollView];
        [self initImageWithCurrentIndex:0];
        if (_style == YImageScanViewStyleAutoPlaying) {
            [self addBottomView];
        }
        
    }
    //重读数据
    [self reloadData];
}

- (void)reloadData
{
    self.scrollView.contentSize = CGSizeMake(YScrollViewWidth * self.imageList.count, YScrollViewHeight);
    if (!self.isAutoPlaying) {
        [self addTopView];
    }
    
}

- (void)setCurrentPageIndex:(NSInteger)currentPageIndex
{
    if (currentPageIndex >= self.imageList.count) {
        return;
    }
    _currentPageIndex = currentPageIndex;
    _currPage = currentPageIndex;
    [self setViews];
    if (currentPageIndex != 0 && currentPageIndex != self.imageList.count - 1) {
        //移除已有的imageView
        [self removeImageViewFromScrollView];
        //增加imageVIew
        [self initImageWithCurrentIndex:currentPageIndex - 1];

    }
    else if(currentPageIndex == self.imageList.count - 1){
        //移除已有的imageView
        [self removeImageViewFromScrollView];
        //增加imageVIew
        [self initImageWithCurrentIndex:currentPageIndex - 2];
    }
    //设置偏移
    self.scrollView.contentOffset = CGPointMake(currentPageIndex * YScrollViewWidth, 0);
}

#warning 有待实现
#if  0
- (NSArray *)findImageViewFromScrollView
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *view in self.scrollView.subviews) {
        if ([view isMemberOfClass:[UIScrollView class]]) {
            [array addObject:view];
        }
    }
    return array;
}
#endif

-(void)setAutoPlaying:(BOOL)autoPlaying
{
    _autoPlaying = autoPlaying;
    if (self.isAutoPlaying) {
        //add timer
        [self addTimer];
        //隐藏label
        self.label.hidden = YES;
    }
    else{
        //remove timer
        [self removeTimer];
        self.label.hidden = NO;
    }
        
}

- (void)addTimer
{
    if (self.timer != nil) {
        [self.timer invalidate];
    }
    self.imageDuration = 2;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.imageDuration target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    if (self.timer != nil) {
        [self.timer invalidate];
    }
    self.timer = nil;
}

- (void)timerAction:(NSTimer *)timer
{
    
    NSLog(@"timerAction");
    NSInteger currentPage = self.currPage + 1;
    if (currentPage == self.imageList.count) {
        currentPage = 0;
        [self removeImageViewFromScrollView];
        [self initImageWithCurrentIndex:0];
    }
    self.currPage = currentPage;
    [self.scrollView setContentOffset:CGPointMake(currentPage * YScrollViewWidth, 0) animated:YES];
   
    
    
}
- (void)removeImageViewFromScrollView
{
    for (UIView *view in self.scrollView.subviews) {
        NSLog(@"view.tag  = %li class = %@",view.tag,view.class);
        if (view.tag != 0 && [view isMemberOfClass:[UIScrollView class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)setMScrollView
{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, YScrollViewWidth ,YScrollViewHeight)];
    [self addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //delegate
    self.scrollView.delegate = self;
    
}

- (void)initImageWithCurrentIndex:(NSInteger)index
{
//    NSArray *scrollViews = [self findImageViewFromScrollView];
        for (NSInteger i = 0; i < 3; i++) {
            UIScrollView *sc = [[UIScrollView alloc] init];
            CGFloat scX = (i + index) * YScrollViewWidth;
            CGFloat scY = 0;
            CGFloat scW = YImageWidth;
            CGFloat scH = YImageHeight;
            sc.frame = CGRectMake(scX, scY, scW, scH);
            [self.scrollView addSubview:sc];
            sc.tag = index + 1 + i;
            sc.showsHorizontalScrollIndicator = NO;
            sc.showsVerticalScrollIndicator = NO;
            //设置缩放
            if (self.isZoomEnabled) {
                sc.delegate = self;
                sc.minimumZoomScale = 1.0;
                sc.maximumZoomScale = 2.0;
            }
            
            //add image to sc
            UIImageView *imageView = [[UIImageView alloc] init];
            [sc addSubview:imageView];
            imageView.frame = sc.bounds;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
//            imageView.image = [UIImage imageNamed:self.imageList[index + i]];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageList[index + i]]];
            imageView.tag = YImageTag;
            
            if (self.style == YImageScanViewStyleAutoPlaying) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [sc addSubview:button];
                button.frame = imageView.frame;
                button.tag = sc.tag;
                [button addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
            }

    }
}

- (void)addTopView
{
    _label = [[UILabel alloc] init];
    [self addSubview:_label];
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = 100;
    CGFloat labelH = 50;
    _label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    _label.center = CGPointMake(YScreenWidth/2, labelH);
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = [NSString stringWithFormat:@"1/%li",self.imageList.count];
    _label.font = [UIFont boldSystemFontOfSize:20];
    _label.textColor = [UIColor whiteColor];
}

- (void)addBottomView
{
    _pageControl = [[UIPageControl alloc] init];
    [self addSubview:_pageControl];
    CGFloat pageControlX = 0;
    CGFloat pageControlY = 0;
    CGFloat pageControlW = 100;
    CGFloat pageControlH = 30;
    _pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    _pageControl.numberOfPages = self.imageList.count;
    _pageControl.currentPageIndicatorTintColor = self.currentDotColor? self.currentDotColor:[UIColor redColor];
    _pageControl.pageIndicatorTintColor = self.dotColor ? self.currentDotColor:[UIColor yellowColor];
    _pageControl.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - pageControlH/2 - 10);
    
}


#pragma mark - 实现代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   if(self.zoomEnabled && scrollView.tag != 0)
   {
       return;
   }
    self.currPage = (scrollView.contentOffset.x + YScrollViewWidth/2)/ YScrollViewWidth;
    if (self.currPage != 0 && self.currPage != self.imageList.count - 1) {
        UIScrollView *mScrollView = [self findImageViewOutofRangeWithCurrentTag:self.currPage + 1];
        NSLog(@"currpage = %li",self.currPage);
        if(mScrollView != nil)
        {
            mScrollView.frame = CGRectMake(YScrollViewWidth * (mScrollView.tag - 1), 0, YImageWidth,YImageHeight);
            //获取ImageView
            UIImageView *imageView = (UIImageView *)[self getViewFromScrollView:mScrollView withTag:YImageTag];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageList[mScrollView.tag - 1]]];
//            [imageView setImage:[UIImage imageNamed:self.imageList[mScrollView.tag - 1]]];
        }
    }
    NSMutableString *str = [NSMutableString string];
    for (UIView *view in self.scrollView.subviews) {
        [str appendFormat:@"%li ",view.tag];
    }
    NSLog(@"%@",str);
    [self setViews];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(imageScanView:currentIndex:)]) {
        [self.delegate imageScanView:self currentIndex:self.currPage];
    }
}

- (UIView *)getViewFromScrollView:(UIScrollView *)scrollView withTag:(NSInteger)tag
{
    for (UIView *view in scrollView.subviews) {
        if ( view.tag == tag) {
            return view;
        }
    }
    return nil;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //去除定时器
    if (self.isAutoPlaying) {
        [self removeTimer];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //添加定时器
    if (self.isAutoPlaying) {
        [self addTimer];
    }
}

- (void)setViews
{
    self.pageControl.currentPage = self.currPage;
    self.label.text = [NSString stringWithFormat:@"%li/%li",self.currPage+1,self.imageList.count];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView.tag == 0) {
        return nil;
    }
    UIImageView *imageView = (UIImageView *)[self getViewFromScrollView:scrollView withTag:YImageTag];
    return imageView;
}

- (UIScrollView *)findImageViewOutofRangeWithCurrentTag:(NSInteger)tag
{
    for (UIScrollView *view in self.scrollView.subviews) {
        if ([view isMemberOfClass:[UIScrollView class]] && view.tag != 0) {
            if (view.tag - tag == 2) {
                if (self.style == YImageScanViewStyleAutoPlaying) {
                    UIButton *button = (UIButton *)[self getViewFromScrollView:view withTag:view.tag];
                    button.tag = tag - 1;
                }
                view.tag = tag - 1;
                return view;
            }
            else if(view.tag - tag == -2)
            {
                if (self.style == YImageScanViewStyleAutoPlaying) {
                    UIButton *button = (UIButton *)[self getViewFromScrollView:view withTag:view.tag];
                    button.tag = tag + 1;
                }
                view.tag = tag + 1;
                return view;
            }
        }
    }
    return nil;
}

- (void)imageClicked:(UIButton *)button
{
    NSInteger index = button.tag - 1;
    NSLog(@"tag == %li",index);
    if ([self.delegate respondsToSelector:@selector(imaegScanView:didSelectedImageAtIndex:)]) {
        [self.delegate imaegScanView:self didSelectedImageAtIndex:index];
    }
}



@end
