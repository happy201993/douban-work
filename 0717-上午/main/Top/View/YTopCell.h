//
//  YTopCell.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/21.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YStarView;
@class YMovie;
@interface YTopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet YStarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *mark;

@property (nonatomic,strong) YMovie *movie;

@end
