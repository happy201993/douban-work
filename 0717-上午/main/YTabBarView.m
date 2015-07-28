//
//  YTarBar.m
//  自定义Tabbar
//
//  Created by 杨少伟 on 15/7/11.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YTabBarView.h"
#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height
#define YMargin 5
#define YTabBarHeight 49

@interface YTabBarView()
//背景
@property (nonatomic,strong) UIImageView *backgroundView;
@property (nonatomic,strong) UIImageView *IndicatorView;

@end

@implementation YTabBarView




+ (instancetype)tabBarView
{
    YTabBarView *view = [[self alloc] init];
    return view;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundView = [[UIImageView alloc] init];
        self.IndicatorView = [[UIImageView alloc] init];
        [self addSubview:self.backgroundView];
        [self addSubview:self.IndicatorView];
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    self.itemCount = items.count;
    for (NSInteger i = 0; i < self.itemCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        
        
        CGFloat buttonY = 0;
        CGFloat buttonW = (YScreenWidth - (YMargin * (self.itemCount + 1)))/self.itemCount;
        CGFloat buttonH  = YTabBarHeight;
        CGFloat buttonX = (i+1)*YMargin + i*buttonW ;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        if (i == 0) {
            //设置选中项背景
            self.IndicatorView.frame = button.frame;
        }
        
        UIView *view = items[i];
        view.frame = button.frame;
        [self addSubview:view];
        [self addSubview:button];
        //监听事件
        button.tag = i;
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        button.backgroundColor = [UIColor blueColor];
    }
}

- (void)btnAction:(UIButton *)button
{
    NSInteger index = button.tag;
//    UIView *selectedView = self.items[index];

    self.selectedItemIndex = index;
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectAtIndex:)]) {
        [self.delegate tabBar:self didSelectAtIndex:index];
    }
    if (self.IndicatorView.image == nil) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.IndicatorView.center = button.center;
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, YScreenWidth, YTabBarHeight);
    self.backgroundView.frame = self.bounds;
    
}

- (void)setBackgroundImage:(UIImage *)image
{
    self.backgroundView.image = image;
}

- (void)setSelectedIndicatorImage:(UIImage *)selectedIndicatorImage
{
    self.IndicatorView.image = selectedIndicatorImage;
}





@end
