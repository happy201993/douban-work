//
//  NSString+Extension.m
//  再次实现QQ聊天界面
//
//  Created by 杨少伟 on 15/7/4.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font WithMaxSize:(CGSize)maxSize
{
    NSDictionary *attr = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}
@end
