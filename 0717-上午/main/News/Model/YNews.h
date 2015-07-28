//
//  YNews.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/21.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YObject.h"
@interface YNews :YObject

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *summary;

@property (nonatomic,copy) NSString *image;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)newsWithDictionary:(NSDictionary *)dict;

@end
