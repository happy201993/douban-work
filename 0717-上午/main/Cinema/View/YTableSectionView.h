//
//  YTableSectionView.h
//  小项目 微信聊天
//
//  Created by 杨少伟 on 15/7/15.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDistrict;
@class YTableSectionView;
#define YSectionViewHeight 44

@protocol YTableSectionViewDelegate <NSObject>

@optional
- (void)tableSectionView:(YTableSectionView *)sectionView didSelectedAtIndex:(NSInteger)section;
@end
@interface YTableSectionView : UIView
//模型 
@property (nonatomic,strong) YDistrict *group;
@property (nonatomic,assign) NSInteger section;
@property (nonatomic,assign) id<YTableSectionViewDelegate> delegate;

+(instancetype)sectionView;


@end
