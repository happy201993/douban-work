//
//  YStarView.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/21.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YStarView.h"


static const NSInteger startCount = 5;
@interface YStarView()

@property (nonatomic,strong) UIView *grayStar;
@property (nonatomic,strong) UIView *yellowStar;

@end

@implementation YStarView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [self createSubViews];
}


- (void)createSubViews
{
    self.grayStar = [[UIView alloc] init];
    [self addSubview:self.grayStar];
   
    UIImage *image = [UIImage imageNamed:@"gray"];
    self.grayStar.backgroundColor = [UIColor colorWithPatternImage:image];
    self.grayStar.frame = CGRectMake(0, 0, image.size.width*startCount, image.size.height);
    
    self.yellowStar = [[UIView alloc] init];
    [self addSubview:self.yellowStar];
    UIImage *yellow = [UIImage imageNamed:@"yellow"];
    self.yellowStar.backgroundColor = [UIColor colorWithPatternImage:yellow];
    self.yellowStar.frame = self.grayStar.frame;
    
    //星星的高度需要填充父视图的高度
    //所以宽高需要等比缩放
    CGFloat scale = self.frame.size.height / self.grayStar.frame.size.height;
    self.grayStar.transform = CGAffineTransformMakeScale(scale, scale);
    self.yellowStar.transform = CGAffineTransformMakeScale(scale, scale);
    CGRect grayFrame = self.grayStar.frame;
    grayFrame.origin = CGPointZero;
    self.grayStar.frame = grayFrame;
    self.yellowStar.frame = self.grayStar.frame;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
     CGRect yellowFrame = self.yellowStar.frame;
    yellowFrame.size.width = self.grayStar.frame.size.width/10 *_grade;
    self.yellowStar.frame = yellowFrame;
    
    
}

- (void)setGrade:(CGFloat)grade
{
    _grade = grade;
    [self setNeedsLayout];
}
@end
