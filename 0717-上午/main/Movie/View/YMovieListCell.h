//
//  YMovieListCell.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/20.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMovie;
@interface YMovieListCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView;

//模型
@property (nonatomic,strong) YMovie *movie;
@end
