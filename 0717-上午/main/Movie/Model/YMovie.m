//
//  Movie.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/20.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YMovie.h"

@implementation YMovie


+ (instancetype)moveWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super initWithDictionary:dict]) {
        [self setValuesForKeysWithDictionary:dict];
        self.average = [dict[@"average"] floatValue];
    }
    return self;
}
@end
