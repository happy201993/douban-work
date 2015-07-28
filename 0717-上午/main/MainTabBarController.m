//
//  MainTabBarController.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/17.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "MainTabBarController.h"
#import "YMovieController.h"
#import "YNewsController.h"
#import "YTopController.h"
#import "YCinemaController.h"
#import "YMoreController.h"
#import "YTabBarView.h"
#import "YButton.h"
#import "BaseNavigationController.h"
#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height
#define YBottomBarH 49
@interface MainTabBarController () <YTabBarDelegate>
@property (nonatomic,strong) NSArray  *titles;
@property (nonatomic,strong) NSArray *images;
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titles = @[@"电影",@"新闻",@"Top250",@"影院",@"更多"];
    self.images = @[@"movie_cinema",@"msg_new",@"start_top250",@"icon_cinema",@"more_setting"];
    [self setmViewControllers];
    [self setmTarBar];
    
}

- (void)setmViewControllers
{
    YMovieController *vc1 = [[YMovieController alloc] init];
    YNewsController *vc2 = [[YNewsController alloc] init];
    YTopController *vc3 = [[YTopController alloc] init];
    YCinemaController *vc4 = [[YCinemaController alloc] init];
    YMoreController *vc5 = [[YMoreController alloc] init];
    NSArray *viewControllers = @[vc1,vc2,vc3,vc4,vc5];
    
    NSMutableArray *navis = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:viewControllers[i]];
        [viewControllers[i] setTitle:self.titles[i]];
        [navis addObject:navi];
        
//        [self addChildViewController:navi];  这是viewcontroller的方法
    }
    [self setViewControllers:navis animated:YES];
    
}

- (void)setmTarBar
{
    //01 移除原有button
    Class cls = NSClassFromString(@"UITabBarButton");
   // NSLog(@"count = %li",self.tabBar.subviews.count);
    for (UIView *view in self.tabBar.subviews) {
     //   NSLog(@"%@",view);
        if ([view isMemberOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    //02 设置背景
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg_all"]];
    //设置为透明 使scrollview 增加默认偏移
    self.tabBar.translucent = YES;
    //02 设置item
    YTabBarView *tabBarView = [YTabBarView tabBarView];
    [self.tabBar addSubview:tabBarView];
    tabBarView.delegate = self;
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        YButton *button = [[YButton alloc] initWithFrame:CGRectZero imageName:self.images[i] withText:self.titles[i]];
        [items addObject:button];
    }
    tabBarView.items = items;
    [tabBarView setSelectedIndicatorImage:[UIImage imageNamed:@"selectTabbar_bg_all1"]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(YTabBarView *)tabBarView didSelectAtIndex:(NSInteger)index
{
    self.selectedIndex = index;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
