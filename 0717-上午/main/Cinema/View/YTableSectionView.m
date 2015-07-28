//
//  YTableSectionView.m
//  小项目 微信聊天
//
//  Created by 杨少伟 on 15/7/15.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YTableSectionView.h"
#import "YDistrict.h"
#import "UIImage+Extension.h"

#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height


@interface YTableSectionView()
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UILabel *onLineLabel;

@end

@implementation YTableSectionView

+(instancetype)sectionView
{
    YTableSectionView *sectionView = [[YTableSectionView alloc] initWithFrame:CGRectMake(0, 0, YScreenWidth, YSectionViewHeight)];
    return sectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *newImageName = [UIImage resizeImageWithName:@"btnbg_blue"];
    [self.backButton setBackgroundImage:newImageName forState:UIControlStateNormal];
//    [self.backButton setBackgroundColor:[UIColor colorWithRed:58/255.0 green:66/255.0 blue:74/255.0 alpha:1]];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
    [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
    [self.backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    self.backButton.imageView.contentMode = UIViewContentModeCenter;
    self.backButton.imageView.clipsToBounds = NO;
    [self addSubview:self.backButton];
    
    
    self.onLineLabel = [[UILabel alloc] init];
    [self addSubview:self.onLineLabel];
}

- (void)clickAction
{
    
  
    self.group.visible = !self.group.isVisible;
    [self.delegate tableSectionView:self didSelectedAtIndex:self.section];
   
        
}
-(void)layoutSubviews
{
    [super layoutSubviews];
//    NSLog(@"frame = %@",NSStringFromCGRect(self.bounds));
//    !!!!!! 这在tableview中绝对位置
    //这里改变了frame 
    self.backButton.frame = self.bounds;
    
    CGFloat onLineY = 0;
    CGFloat onLineW = 100;
    CGFloat onLineH = YSectionViewHeight;
    CGFloat onLineX = YScreenWidth - onLineW - 10;
    self.onLineLabel.frame = CGRectMake(onLineX, onLineY, onLineW, onLineH);
}

-(void)setGroup:(YDistrict *)group
{
    _group = group;
    [self.backButton setTitle:group.name forState:UIControlStateNormal];
    
    CGFloat angle = 0;
    if (self.group.isVisible)
        //改变图片transform
        angle = M_PI_2;
    self.backButton.imageView.transform = CGAffineTransformRotate(self.backButton.imageView.transform, angle);
  
}





@end
