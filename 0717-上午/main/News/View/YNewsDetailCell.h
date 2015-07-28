//
//  YNewsDetailCell.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/22.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YNewsDetail;

@interface YNewsDetailCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (nonatomic,strong) YNewsDetail *detail;
@end
