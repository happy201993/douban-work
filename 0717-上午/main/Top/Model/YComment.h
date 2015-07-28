//
//  YComment.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/27.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YObject.h"
/*
"userImage" : "http://img2.mtime.com/images/default/head.gif",
"nickname" : "yangna988",
"rating" : "9.0",
"content" : "儿子很喜欢 一直期盼上映"
 */

@interface YComment : YObject
@property (nonatomic,copy) NSString *userImage;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *rating;
@property (nonatomic,copy) NSString *content;

+ (instancetype)commentWithDictionary:(NSDictionary *)dict;
@end
