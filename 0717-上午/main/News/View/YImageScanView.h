//
//  YImageScanView.h
//  用ScrollView实现图片浏览器
//
//  Created by 杨少伟 on 15/7/13.
//  Copyright (c) 2015年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YImageScanView;
@protocol YImageScanViewDelegate<NSObject>
@optional
- (void)imaegScanView:(YImageScanView *)imageScanView didSelectedImageAtIndex:(NSInteger)index;

- (void)imageScanView:(YImageScanView *)imageScanView currentIndex:(NSInteger)index;
@end

typedef NS_ENUM(NSUInteger,  YImageScanViewStyle) {
    YImageScanViewStyleDefault,
    YImageScanViewStyleAutoPlaying,
};


@interface YImageScanView : UIView <UIScrollViewDelegate>

@property (nonatomic,strong) UILabel *label;

@property (nonatomic,strong) NSArray *imageList;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,weak) id<YImageScanViewDelegate> delegate;

@property (nonatomic,assign) YImageScanViewStyle style;

#pragma  mark - init
- (instancetype)initWithFrame:(CGRect)frame style:(YImageScanViewStyle)style;
//点的颜色
@property (nonatomic,strong) UIColor *currentDotColor;
@property (nonatomic,strong) UIColor *dotColor;

//设置当前显示图片
@property (nonatomic,assign) NSInteger currentPageIndex;

@property (nonatomic,assign,getter=isAutoPlaying) BOOL autoPlaying;
@property (nonatomic,assign) NSTimeInterval imageDuration;

//设置是否支持缩放
@property (nonatomic,assign,getter=isZoomEnabled) BOOL zoomEnabled;  //default is yes


@end
