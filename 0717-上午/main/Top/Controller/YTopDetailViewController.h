//
//  YTopDetailViewController.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/27.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "BaseViewController.h"
@class YMovieDetail;

@interface YTopDetailViewController : BaseViewController
@property (nonatomic,strong) YMovieDetail *detail;
@property (nonatomic,strong) NSArray *comments;
@end
