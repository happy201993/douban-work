//
//  YCommentCell.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/27.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YComment;
@interface YCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (nonatomic,strong) YComment *comment;


+ (CGFloat)cellHeightWithComment:(YComment *)comment;
@end
