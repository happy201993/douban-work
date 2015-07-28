//
//  YFirstViewController.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/27.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YFirstViewController.h"
#import "YLaunchViewController.h"
#define YScreenWidth [UIScreen mainScreen].bounds.size.width
#define YScreenHeight [UIScreen mainScreen].bounds.size.height
@interface YFirstViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic)  UIButton *finishButton;

@end

@implementation YFirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(5*YScreenWidth, YScreenHeight);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    for (NSInteger i = 0; i < 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"guide%li",i+1];
        NSString *dotName = [NSString stringWithFormat:@"guideProgress%li",i+1];
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imageView];
        CGFloat imageViewX = YScreenWidth * i;
        CGFloat imageViewY = 0;
        CGFloat imageViewW = YScreenWidth;
        CGFloat imageViewH = YScreenHeight;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        imageView.image = [UIImage imageNamed:imageName];
        
        UIImageView *dotImage = [[UIImageView alloc] init];
        [imageView addSubview:dotImage];
        CGFloat dotImageW = 173/2;
        CGFloat dotImageH = 13;
        CGFloat dotImageX = (YScreenWidth - dotImageW)/2;
        CGFloat dotImageY = YScreenHeight - 10 - dotImageH;
        dotImage.frame = CGRectMake(dotImageX, dotImageY, dotImageW, dotImageH);
        dotImage.image = [UIImage imageNamed:dotName];
        //添加按钮
        if (i == 4) {
            self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.scrollView addSubview:self.finishButton];
            CGFloat finishButtonW = 200;
            CGFloat finishButtonH = 50;
            CGFloat finishButtonX = imageViewX + (YScreenWidth - finishButtonW)/2;
            CGFloat finishButtonY = YScreenHeight - finishButtonH - 80;
            
            self.finishButton.frame = CGRectMake(finishButtonX, finishButtonY, finishButtonW, finishButtonH);
            [self.finishButton setTitle:@"点击进入" forState:UIControlStateNormal];
            [self.finishButton setTitleColor:[UIColor colorWithRed:146/255.0 green:55/255.0 blue:58/255.0 alpha:1] forState:UIControlStateNormal];
            self.finishButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
            [self.finishButton addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger currentPage = offsetX/YScreenWidth;
    if (currentPage == 3) {
        self.finishButton.alpha = (offsetX - 3 * YScreenWidth)/YScreenWidth;
       
    }
}

- (void)finishAction:(id)sender {
    YLaunchViewController *vc = [[YLaunchViewController alloc] init];
     [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    vc.view.transform =  CGAffineTransformMakeScale(.2, .2);
    [UIView animateWithDuration:0.5 animations:^{
        vc.view.transform = CGAffineTransformIdentity;
    }];
   
}

@end
