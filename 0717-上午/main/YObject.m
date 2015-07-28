//
//  YObject.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/20.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YObject.h"

@implementation YObject


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self= [super init]) {
        
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            self.objectId = [NSString stringWithFormat:@"%li",[value integerValue]];
        }
        else
            self.objectId = value;
    }
}
@end
