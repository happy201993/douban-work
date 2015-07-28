//
//  YNews.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/21.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YNews.h"

@implementation YNews


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super initWithDictionary:dict]) {
        [self setValuesForKeysWithDictionary:dict];
        self.type = [dict[@"type"] integerValue];
    }
    return self;
}
+ (instancetype)newsWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

//处理key和model变量不同名的情况  如果有不同名的key 但是没有复写这个方法 那么程序会报出异常   如果复写了这个方法 就算有不同名的key 也不会报异常
//总之 如果在用 setValuesForKeysWithDictionary 时发现有对应不上的key 就会调用这个方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.objectId = [NSString stringWithFormat:@"%li",[value integerValue]];
    }
}
@end
