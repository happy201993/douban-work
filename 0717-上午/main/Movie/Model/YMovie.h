//
//  Movie.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/20.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YObject.h"

@interface YMovie : YObject

//电影名称
@property (nonatomic,copy) NSString *title;

//评分
@property (nonatomic,assign) float average;

//highlight
@property (nonatomic,copy) NSString *highlight;

//images
@property (nonatomic,strong) NSDictionary *images;

//year
@property (nonatomic,copy) NSString *year;

@property (nonatomic,assign,getter=isDetailViewShow) BOOL detailViewShow;


+ (instancetype)moveWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
