//
//  YDistrict.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/22.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YObject.h"
//{
//    "name" : "东城区",
//    "id" : "1029"
//}
@interface YDistrict : YObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign,getter=isVisible) BOOL visible;

@property (nonatomic,strong) NSMutableArray *cinemas;

+ (instancetype)districtWithDictionary:(NSDictionary *)dict;

@end
