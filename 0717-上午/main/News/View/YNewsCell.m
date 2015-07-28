//
//  YNewsCell.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/21.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YNewsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YNews.h"
@implementation YNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNews:(YNews *)news
{
    _news = news;
    [self.image sd_setImageWithURL:[NSURL URLWithString:news.image]];
    self.title.text = news.title;
    self.summary.text = news.summary;
    self.type = news.type;
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    switch (_type) {
        case YNewCellTypeDefault:
            self.icon.hidden = YES;
            break;
        case YNewCellTypeImage:
            self.icon.hidden = NO;
            self.icon.image = [UIImage imageNamed:@"sctpxw"];
            break;
        case YNewCellTypeOther:
            self.icon.image = [UIImage imageNamed:@"scspxw"];
            self.icon.hidden = NO;
            break;
        
    }
}

@end
