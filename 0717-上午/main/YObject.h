//
//  YObject.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/20.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YObject : NSObject

@property (nonatomic,copy) NSString *objectId;


- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
