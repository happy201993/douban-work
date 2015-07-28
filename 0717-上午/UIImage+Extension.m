//
//  UIImage+Extension.m
//  再次实现QQ聊天界面
//
//  Created by 杨少伟 on 15/7/4.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (instancetype)resizeImageWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat topCap = image.size.height*0.6;
    CGFloat leftCap = image.size.width*0.6;
    CGFloat bottomCap = image.size.height - topCap -1;
    CGFloat rightCap = image.size.width - leftCap - 1;
    UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, leftCap, bottomCap, rightCap) resizingMode:UIImageResizingModeStretch];
//    UIImage *newImage = [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
    
    return newImage;
}
@end
