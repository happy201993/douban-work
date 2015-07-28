//
//  YTarBar.h
//  自定义Tabbar
//
//  Created by 杨少伟 on 15/7/11.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTabBarView;
@protocol YTabBarDelegate <NSObject>

@optional
- (void)tabBar:(YTabBarView *)tabBarView didSelectAtIndex:(NSInteger)index;

@end
@interface YTabBarView : UIView

//条目数
@property (nonatomic,assign) NSUInteger  itemCount;

@property (nonatomic,strong) NSArray     *items;

@property(nonatomic,assign) NSInteger selectedItemIndex;

@property (nonatomic,assign) id<YTabBarDelegate> delegate;

@property(nonatomic,strong) UIImage *selectedIndicatorImage;


+ (instancetype)tabBarView;

- (void)setBackgroundImage:(UIImage *)image;
@end
