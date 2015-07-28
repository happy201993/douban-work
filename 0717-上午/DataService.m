//
//  DataService.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/21.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "DataService.h"

@implementation DataService


+ (id)getDataFromJsonFile:(NSString *)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}
@end
