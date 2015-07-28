//
//  YLaunchViewController.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/27.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YLaunchViewController.h"

#import "MainTabBarController.h"


#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height

typedef struct xx
{
    int lineNumber;
    int index;
}YCoordinate;

@interface YLaunchViewController ()
@property (nonatomic,strong) NSMutableArray *imageList;
@property (nonatomic,assign) CGFloat imageW;
@property (nonatomic,assign) CGFloat imageH;
@property (nonatomic,assign) YCoordinate mCoordinate;

@end



@implementation YLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mCoordinate  = (YCoordinate){0,-1};
    self.imageList = [NSMutableArray array];
    NSInteger width = 4;
    NSInteger height = 7;
    self.imageW = YScreenWidth/width;
    self.imageH = YScreenHeight/height;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"Default"];
    
    for (NSInteger line = 0; line < height; line++) {
        for (NSInteger i = 0; i < width; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%li",line * width + i +1];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.imageW, line*self.imageH, self.imageW, self.imageH)];
            [self.view addSubview:imageView];
            imageView.tag = line * width + i + 1;
            imageView.image = [UIImage imageNamed:imageName];
            imageView.alpha = 0;
        }
    }
    
    [self transmiteImageView:width withHeight:height];
    [self showImageView];
    
}

- (void)transmiteImageView:(NSInteger)width withHeight:(NSInteger)height
{
    
    for (NSInteger i = 0; i < width; i++) {
        _mCoordinate.index++;
        
        [self.imageList addObject:[NSNumber numberWithInteger:_mCoordinate.index + _mCoordinate.lineNumber*4 ]];
    }
    for (NSInteger i = 1; i < height; i++) {
        _mCoordinate.lineNumber++;
        [self.imageList addObject:[NSNumber numberWithInteger:_mCoordinate.index + _mCoordinate.lineNumber*4 ]];
    }
    for (NSInteger i = 0; i< width - 1; i++) {
        _mCoordinate.index--;
        [self.imageList addObject:[NSNumber numberWithInteger:_mCoordinate.index + _mCoordinate.lineNumber*4 ]];
    }
    for (NSInteger i = 0; i < height-2; i++) {
        _mCoordinate.lineNumber--;
        [self.imageList addObject:[NSNumber numberWithInteger:_mCoordinate.index + _mCoordinate.lineNumber*4]];
    }
    if (_mCoordinate.index != width/2) {
        [self transmiteImageView:width-2 withHeight:height-2];
    }
    
}

- (void)showImageView
{
    static NSInteger index = 0;
    if (index == self.imageList.count) {
            MainTabBarController *tabBarController = [[MainTabBarController alloc] init];
        
        

        [[UIApplication sharedApplication].keyWindow setRootViewController:tabBarController];
        tabBarController.view.alpha = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:self.view];
        [UIView animateWithDuration:.5 animations:^{
            self.view.alpha = 0;
            tabBarController.view.alpha = 1;
        } completion:^(BOOL finished) {
             NSMutableArray *views = (NSMutableArray *)[[UIApplication sharedApplication].keyWindow subviews];
            [views removeObject:self.view];
        }] ;
        return;
    }
    
    NSInteger tag = [self.imageList[index] integerValue];
    UIView *view = [self findViewWithTag:tag+1];
    [UIView animateWithDuration:.2 animations:^{
        view.alpha = 1;
    }];
    index++;
    
    [self performSelector:@selector(showImageView) withObject:nil afterDelay:.05];
}

- (UIView *)findViewWithTag:(NSInteger)tag
{
    for (UIView *view in self.view.subviews) {
        if (view.tag == tag) {
            return view;
        }
    }
    return nil;
}


@end
