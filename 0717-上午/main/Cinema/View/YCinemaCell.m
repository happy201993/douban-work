//
//  YCinemaCell.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/22.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YCinemaCell.h"
#import "YCinema.h"
@implementation YCinemaCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCinema:(YCinema *)cinema
{
    _cinema = cinema;
    self.name.text = cinema.name;
    self.mark.text = cinema.grade;
    self.position.text = cinema.address;
    if (cinema.lowPrice != nil) {
        self.price.text = [NSString stringWithFormat:@"￥%@",cinema.lowPrice];
    }
    self.seatImage.hidden = !cinema.isSeatSupport;
    self.ticketImage.hidden = !cinema.isCouponSupport;
    self.distance.text = cinema.distance;
}

@end
