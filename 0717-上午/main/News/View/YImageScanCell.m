//
//  YImageScanCell.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/23.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YImageScanCell.h"
#import "YImageScrollView.h"

@interface YImageScanCell()
@property (nonatomic,strong) YImageScrollView *scrollView;
@end

@implementation YImageScanCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.scrollView = [[YImageScrollView alloc] initWithFrame:self.contentView.bounds];
        self.scrollView.tag = 100;
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}

-(void)setImage:(NSString *)image
{
    _image = image;
    self.scrollView.image = image;
}



@end
