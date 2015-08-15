//
//  YMovieController.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/17.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YMovieController.h"
#import "YMovie.h"
#import "YMovieListCell.h"
#import "DataService.h"
#import "YPosterView.h"

@interface YMovieController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) YPosterView *posterView;
@property (nonatomic,strong) NSArray *movieList;
@end

@implementation YMovieController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNaviItem];
    [self createTableView];
    [self createPosterView];
    
    
    
  
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //内容向下偏移64 向上偏移49 {64, 0, 49, 0}
//    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
//    //{0, -64}
//    NSLog(@"%@",NSStringFromCGPoint(self.tableView.contentOffset));
//    
//    NSLog(@"hahah --- %@",NSStringFromCGRect(self.view.bounds));
    
}

- (NSArray *)movieList
{
    if (_movieList == nil) {
         _movieList =  [self loadData];
    }
    return _movieList;
}

#pragma mark - 状态栏相关
//注意 多级控制器不会调用此方法 这个方法不会被调用
//多层关系中 nav的子控制器里面重写该方法无效  但是可以在navi中显式地调用该方法
//[self.topViewController preferredStatusBarStyle]
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 导航栏按钮
- (void)createNaviItem
{
    UIView *flip = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    //让button的宽高可以正好包含他的子视图
    [button sizeToFit];
    [flip addSubview:button];
    [button addTarget:self action:@selector(flipAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:flip];
}

- (void)flipAction:(UIButton *)button
{
    static BOOL isList = YES;
    NSString *imageName;
    UIViewAnimationOptions option;
    if (isList) {
        imageName = @"poster_home";
        option = UIViewAnimationOptionTransitionFlipFromLeft;
    }
    else
    {
        imageName = @"list_home";
        option = UIViewAnimationOptionTransitionFlipFromRight;
    }
    //设置button的图片
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //翻转动画
    [UIView transitionWithView:self.view duration:.3 options:option animations:nil completion:nil];
    [UIView transitionWithView:button.superview duration:.3 options:option animations:nil completion:nil];
    isList = !isList;
    self.tableView.hidden = !self.tableView.hidden;
    self.posterView.hidden = !self.posterView.hidden;
    
}

-(void)viewWillLayoutSubviews
{
    self.tableView.frame = self.view.bounds;
}

#pragma mark - tableView
- (void)createTableView
{
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    //这时view的宽高 是屏幕的宽高 在后面的程序中 他才会去判断有没有naviBar 是不是透明 如果不是透明 那么view的高度会改变 667-64=603 但是tableView的高度已经确定 坑！
//    self.tableView.frame = self.view.bounds;
//    NSLog(@"self view %@",NSStringFromCGRect(self.view.bounds));
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden = YES;
    self.tableView.rowHeight = 100;
    self.tableView.backgroundColor = [UIColor clearColor];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movieList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMovieListCell *cell = [YMovieListCell cellWithTableView:tableView];
    cell.movie = self.movieList[indexPath.row];
    return cell;
}


#pragma  mark - postView
- (void)createPosterView
{
    self.posterView = [[YPosterView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.posterView];
//    self.posterView.moveList = self.movieList;
//    self.posterView.backgroundColor = [UIColor greenColor];
}

#pragma mark - 加载数据
- (NSArray *)loadData
{
    YHttpRequest *request = [[YHttpRequest alloc] init];
    NSMutableArray *movieList = [NSMutableArray array];
    [request getDataWithRelativePath:DBUSBox WithParams:nil withBlock:^(id data, NSError *error) {
        if (data != nil) {
            NSDictionary * dict = data;
            //   NSLog(@"%@",dict);
            self.title = dict[@"title"];
            NSArray *array = dict[@"subjects"];
            
            NSInteger i = 0;
            for (NSDictionary *movieInfo in array) {
                i++;
                NSDictionary *subject = movieInfo[@"subject"];
                NSString *objectId = subject[@"id"];
                NSString *movieTitle = subject[@"title"];
                NSString *year = subject[@"year"];
                NSDictionary *rating = subject[@"rating"];
                NSNumber *average = rating[@"average"];
                NSDictionary *images = subject[@"images"];
                NSDictionary *movie = @{@"objectId":objectId,
                                        @"title":movieTitle,
                                        @"year":year,
                                        @"average":average,
                                        @"images":images
                                        };
                YMovie *mMovie = [YMovie moveWithDictionary:movie];
                [movieList addObject:mMovie];
            }
            _movieList = movieList;
            //刷新表格
            self.posterView.moveList = self.movieList;
            [self.tableView reloadData];
        }
        else
        {
            NSLog(@"error = %@",error);
        }
    }];
   
    return movieList;
    
}




@end
