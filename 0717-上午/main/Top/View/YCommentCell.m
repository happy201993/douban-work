//
//  YCommentCell.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/27.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YCommentCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YComment.h"
#import "NSString+Extension.h"
#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation YCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setComment:(YComment *)comment
{
    _comment = comment;
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:comment.userImage]];
    self.nickname.text = comment.nickname;
    self.rating.text = comment.rating;
    self.content.text = comment.content;
}

+ (CGFloat)cellHeightWithComment:(YComment *)comment
{
    CGFloat imageMaxY = 55;
    CGFloat imageW = 50;
    CGFloat margin = 10;
    CGSize maxSize = CGSizeMake(YScreenWidth - imageW - margin*2.5, MAXFLOAT);
    CGSize textSize = [comment.content sizeWithFont:[UIFont systemFontOfSize:12] WithMaxSize:maxSize];
    CGFloat textHeight = margin+21+textSize.height;
    if (textHeight >= imageMaxY) {
        return textHeight+5;
    }
    return imageMaxY +5;
    
}

@end
