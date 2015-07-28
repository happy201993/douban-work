//
//  YHearView.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/21.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YHearView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define YLabelH 30
#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height
@interface YHearView ()
@property (nonatomic,strong) UIView *labelView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,assign) CGFloat headerViewH;
@end

@implementation YHearView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.headerViewH = frame.size.height;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, YScreenWidth, self.headerViewH)];
    [self addSubview:self.imageView];
    
    UIView *headerLabel = [[UIView alloc] init];
    headerLabel.alpha = 0.9;
    headerLabel.backgroundColor = [UIColor grayColor];
    [self.imageView addSubview:headerLabel];
    self.labelView = headerLabel;
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    
    [headerLabel addSubview:label];
    self.label = label;

}

-(void)setImage:(NSString *)image
{
    _image = image;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:image]];
    [self setNeedsLayout];
}
- (void)setTitle:(NSString *)title
{
    self.label.text = title;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imageViewSize = self.imageView.bounds.size;
    CGSize headerViewSize = self.bounds.size;
//    label始终在ImageView底部
    CGFloat labelW = headerViewSize.width;
    CGFloat labelH =YLabelH;
    CGFloat labelY = imageViewSize.height - labelH;
    CGFloat labelX = (imageViewSize.width - headerViewSize.width)/2 ;
    self.labelView.frame = CGRectMake(labelX, labelY, labelW, labelH);
    //设置label
    self.label.frame = self.labelView.bounds;
   
}
@end
