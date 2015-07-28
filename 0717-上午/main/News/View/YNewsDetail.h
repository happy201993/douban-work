//
//  YNewsDetail.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/22.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YObject.h"
//"id": 2238621,
//"image": "http://img31.mtime.cn/pi/2013/02/04/093444.29353753_1280X720.jpg",
//"type": 6

@interface YNewsDetail : YObject

@property (nonatomic,copy) NSString *image;
@property (nonatomic,assign) NSInteger type;

+ (instancetype)newsDetailWithDictionary:(NSDictionary *)dict;
@end
