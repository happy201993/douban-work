//
//  YMovieDetail.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/27.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YMovieDetail.h"

@implementation YMovieDetail


-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super initWithDictionary:dict]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)movieDetailWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"release"]) {
        self.info = value;
    }
}

@end
