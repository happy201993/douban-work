//
//  YImageScrollView.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/23.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YImageScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>
NSString *const YImageScrollViewSingleTapNotification = @"sdfsd";
@interface YImageScrollView() <UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation YImageScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        self.imageView = imageView;
        imageView.frame = self.bounds;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        self.delegate = self;
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 3.0;
        
        //创建双击手势
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
        //设置点击次数
        doubleTap.numberOfTapsRequired = 2;
        //设置手指个数
        doubleTap.numberOfTouchesRequired =1;
        //为scrollview 添加双击手势
        [self addGestureRecognizer:doubleTap];
        
        //创建单击手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
        //因为默认numberOfTapsRequired和numberOfTouchesRequired都是1 所以不再设置
        
        //添加手势到视图
        [self addGestureRecognizer:singleTap];
        
        //处理手势冲突
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
    }
    return self;
}

- (void)singleTap
{
    NSLog(@"单机");
    //发送通知 告诉控制器隐藏导航栏 这里代理不好  因为有多级的层次关系
    [[NSNotificationCenter defaultCenter] postNotificationName:YImageScrollViewSingleTapNotification object:nil userInfo:nil];
    
    
//    隐藏导航栏
    //UITabBarController * tabBar = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//    tabBar.
}
- (void)doubleTap
{
    if (self.zoomScale == 1.0) {
        [self setZoomScale:3.0 animated:YES];
    }
    else
        [self setZoomScale:1.0 animated:YES];
}


- (void)setImage:(NSString *)image
{
    _image = image;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:image]];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}



@end
