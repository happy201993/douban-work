//
//  YHttpRequest.m
//  homework 天气预报
//
//  Created by 杨少伟 on 15/8/12.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YHttpRequest.h"

@interface YHttpRequest() <NSURLConnectionDataDelegate>
@property (nonatomic,strong) NSURLConnection *mConnection;

@end
@implementation YHttpRequest


- (void)getDataFromServer:(NSString *)host withRelativePath:(NSString *)relativePath withParams:(NSDictionary *)params withBlock:(FinishBlock)block
{
    NSString *fullUrl = [host stringByAppendingString:relativePath];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:fullUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"get success ");
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        block(dict,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"get fail");
        block(nil,error);
    }];
    
}

- (void)getDataWithRelativePath:(NSString *)relativePath WithParams:(NSDictionary *)params withBlock:(FinishBlock)block
{
    return [self getDataFromServer:YHostDomain withRelativePath:relativePath withParams:params withBlock:block];
}



#pragma mark - AFNetWorking
- (void)postWithUrl:(NSString *)url withParams:(NSDictionary *)params withData:(NSDictionary *)data withFinishBlock:(FinishBlock)block
{
    NSString *fullUrl = [YHostDomain stringByAppendingString:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation * op = [manager POST:fullUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSString *key in data) {
            NSData *file = data[key];
            [formData appendPartWithFileData:file name:key fileName:@"1.png" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        block(dict,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
        block(nil,error);
    }];
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"uploading");
    }];
}
@end
