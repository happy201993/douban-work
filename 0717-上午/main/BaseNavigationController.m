//
//  BaseNavigationController.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/17.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_all-64"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    //一种改变子控制器状态栏颜色的方法
    //return [self.topViewController preferredStatusBarStyle];
    
    //状态栏文字颜色为白色
    return UIStatusBarStyleLightContent;
}


//重写该方法是为了让childViewController的preferredStatusBarStyle方法生效 (当前viewController的preferredStatusBarStyle就不会被调用了)
//- (UIViewController *)childViewControllerForStatusBarStyle
//{
//    return self.topViewController;
//}

@end
