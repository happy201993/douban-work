//
//  YPosterCell.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/24.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMovie.h"

typedef NS_ENUM(NSUInteger, YPosterCellStyle) {
    YPosterCellStyleSmall,
    YPosterCellStyleLarge,
};

@interface YPosterCell : UICollectionViewCell

@property (nonatomic,copy) YMovie *movie;

@property (nonatomic,assign) YPosterCellStyle style;

- (void)flipCell;
@end
