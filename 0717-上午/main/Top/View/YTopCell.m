//
//  YTopCell.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/21.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YTopCell.h"
#import "YMovie.h"
#import "YStarView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation YTopCell



- (void)setMovie:(YMovie *)movie
{
    _movie = movie;
    self.title.text = movie.title;
    self.mark.text = [NSString stringWithFormat:@"%.1f",movie.average];
    //图
    NSString *image = movie.images[@"medium"];
    [self.image sd_setImageWithURL:[NSURL URLWithString:image]];
    self.starView.grade = movie.average;
}
@end
