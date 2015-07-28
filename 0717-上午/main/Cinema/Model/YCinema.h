//
//  YCinema.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/21.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YObject.h"
/*
 "lowPrice" : "40.00",
 "grade" : "8.8",
 "coord" : "116.36047,40.01433",
 "distance" : null,
 "address" : "北京市海淀区学清路甲8号，圣熙8号购物中心五层西侧。",
 "name" : "嘉华国际影城",
 "id" : "1396",
 "msg" : null,
 "districtId" : "1015",
 "tel" : "010-82732228",
 "isSeatSupport" : "1",
 "isCouponSupport" : "1",
 "isImaxSupport" : "0",
 "isGroupBuySupport" : "0",
 "circleName" : "五道口"
 */

@interface YCinema :YObject

@property (nonatomic,copy) NSString *lowPrice;
@property (nonatomic,copy) NSString *grade;
@property (nonatomic,copy) NSString *coord;
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *districtId;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,assign) BOOL isSeatSupport;
@property (nonatomic,assign) BOOL isCouponSupport;
@property (nonatomic,assign) BOOL isImaxSupport;
@property (nonatomic,assign) BOOL isGroupBuySupport;
@property (nonatomic,copy) NSString *circleName;

+ (instancetype)cinemaWithDictionary:(NSDictionary *)dict;


@end
