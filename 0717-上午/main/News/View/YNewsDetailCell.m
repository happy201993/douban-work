//
//  YNewsDetailCell.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/22.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YNewsDetailCell.h"
#import "YNewsDetail.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation YNewsDetailCell


-(void)awakeFromNib
{
    //减掉边界外的东西
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = 5;
    
}
-(void)setDetail:(YNewsDetail *)detail
{
    _detail = detail;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:detail.image]];
}

@end
