//
//  YNewsCell.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/21.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YNews;

typedef NS_ENUM(NSUInteger, YNewCellType) {
    YNewCellTypeDefault,
    YNewCellTypeImage,
    YNewCellTypeOther,
};

@interface YNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (nonatomic,assign) YNewCellType type;

@property (nonatomic,strong) YNews *news;

@end
