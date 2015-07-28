//
//  YCinema.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/21.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YCinema.h"

@implementation YCinema


-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super initWithDictionary:dict]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)cinemaWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}


@end
