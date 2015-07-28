//
//  YButton.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/17.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YButton.h"
#define YImageW 20
#define YImageH 20
@implementation YButton

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName withText:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        _image = [[UIImageView alloc] init];
        [self addSubview:_image];
        _image.contentMode = UIViewContentModeScaleAspectFit;
        _image.image = [UIImage imageNamed:imageName];
        
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = title;
        _label.font = [UIFont systemFontOfSize:11];
        _label.textColor = [UIColor whiteColor];
        [self addSubview:_label];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    //image
    CGFloat imageX = (width - YImageW)/2;
    CGFloat imageY = 5;
    CGFloat imageW = YImageW;
    CGFloat imageH = YImageH;
    self.image.frame = CGRectMake(imageX, imageY, imageW, imageH);
    //label
    CGFloat labelX = 0;
    CGFloat labelY = CGRectGetMaxY(self.image.frame);
    CGFloat labelW = width;
    CGFloat labelH = height - 5 * 2 - imageH;
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

@end
