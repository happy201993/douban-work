//
//  YDistrict.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/22.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YDistrict.h"

@implementation YDistrict
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super initWithDictionary:dict]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)districtWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
@end
