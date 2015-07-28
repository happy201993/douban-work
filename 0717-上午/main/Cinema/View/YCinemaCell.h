//
//  YCinemaCell.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/22.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YCinema;
@interface YCinemaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mark;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIImageView *seatImage;
@property (weak, nonatomic) IBOutlet UIImageView *ticketImage;


@property (nonatomic,strong) YCinema *cinema;

@end
