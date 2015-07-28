//
//  YPosterDetailView.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/25.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YPosterDetailView.h"
#import "YMovie.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YStarView.h"
@implementation YPosterDetailView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"YPosterDetailView" owner:self options:nil];
        self = [views lastObject];
        self.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
    return self;
}

- (void)setMovie:(YMovie *)movie
{
    _movie = movie;
    //图
    [self.image sd_setImageWithURL:[NSURL URLWithString:movie.images[@"medium"]]];
    self.title.text = movie.title;
    self.year.text = movie.year;
    self.mark.text = [NSString stringWithFormat:@"%.1f",movie.average];
    self.starView.grade = movie.average;
}

@end
