//
//  BaseViewController.h
//  0717-上午
//
//  Created by 杨少伟 on 15/7/17.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#define YTopBarH 64
#define YBottomBarH 49
#define YMargin 10
#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height
#define YBgColor [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]]

#define YViewWidth self.view.bounds.size.width
#define YViewHeight self.view.bounds.size.height

@interface BaseViewController : UIViewController

- (NSArray *)loadData;
@end
