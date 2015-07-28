//
//  YButton.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/17.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YButton : UIView

@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) UILabel *label;


- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName withText:(NSString *)title;
@end
