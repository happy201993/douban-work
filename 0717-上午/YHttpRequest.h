//
//  YHttpRequest.h
//  homework 天气预报
//
//  Created by 杨少伟 on 15/8/12.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "YConstants.h"
typedef void(^FinishBlock)(id data,NSError *error);
@class YHttpRequest;
@protocol YHttpRequestDelegate <NSObject>

@optional
- (void)httpRequest:(YHttpRequest *)request responsedFromServer:(id)obj;
- (void)httpRequest:(YHttpRequest *)request withError:(NSError *)error;

@end

@interface YHttpRequest : NSObject

@property (nonatomic,assign) id<YHttpRequestDelegate> delegate;

- (void)getDataFromServer:(NSString *)host withRelativePath:(NSString *)relativePath withParams:(NSDictionary *)params withBlock:(FinishBlock)block;
- (void)getDataWithRelativePath:(NSString *)relativePath WithParams:(NSDictionary *)params withBlock:(FinishBlock)block;


- (void)postWithUrl:(NSString *)url withParams:(NSDictionary *)params withData:(NSDictionary *)data withFinishBlock:(FinishBlock)block;
@end
