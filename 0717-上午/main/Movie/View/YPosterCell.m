//
//  YPosterCell.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/24.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YPosterCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YPosterDetailView.h"
@interface YPosterCell()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) YPosterDetailView *detailView;
@end

@implementation YPosterCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageView];
       
    }
    return self;
}

- (void)addDetailView
{
    
    self.detailView = [[YPosterDetailView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.detailView];
    
    //设置默认隐藏
    self.detailView.hidden = YES;
}

-(void)setMovie:(YMovie *)movie
{
    _movie = movie;
    NSString *imageUrl = movie.images[@"large"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    //为detailview设置数据
    self.detailView.movie = self.movie;
}

- (void)setStyle:(YPosterCellStyle)style
{
    _style = style;
    switch (_style) {
        case YPosterCellStyleSmall:
            
            break;
            
        case YPosterCellStyleLarge:
            if (self.detailView == nil) {
                [self addDetailView];
            }
            break;
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_style == YPosterCellStyleLarge) {
        if (self.movie.isDetailViewShow) {
            self.detailView.hidden = NO;
            self.imageView.hidden = YES;
        }
        else
        {
            self.detailView.hidden = YES;
            self.imageView.hidden = NO;
        }
    }
   }

- (void)flipCell
{
    UIViewAnimationOptions option;
    if (self.imageView.hidden) {
        //图片将要显示 详情将隐藏
        option = UIViewAnimationOptionTransitionFlipFromLeft;
        self.movie.detailViewShow = NO;
    }
    else
    {
        option = UIViewAnimationOptionTransitionFlipFromRight;
        self.movie.detailViewShow = YES;
    }
     [UIView transitionWithView:self.contentView duration:.3 options:option animations:nil completion:nil];
    self.imageView.hidden = !self.imageView.hidden;
    self.detailView.hidden = !self.detailView.hidden;
}

@end
