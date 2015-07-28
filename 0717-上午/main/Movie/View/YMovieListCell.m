//
//  YMovieListCell.m
//  0717-上午
//
//  Created by 杨少伟 on 15/7/20.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "YMovieListCell.h"
#import "YMovie.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YStarView.h"
#define YMargin 10

@interface YMovieListCell()

@property (nonatomic,strong) UIImageView *logo;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *mark;
@property (nonatomic,strong) UILabel *year;
@property (nonatomic,strong) YStarView *starView;

@end

@implementation YMovieListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    YMovieListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YMovieListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        //图
        self.logo = [[UIImageView alloc] init];
        [self.contentView addSubview:self.logo];
        //题
        self.title = [[UILabel alloc] init];
        [self.contentView addSubview:self.title];
        self.title.font = [UIFont systemFontOfSize:18];
        [self.title setTextColor:[UIColor orangeColor]];
        
        self.starView = [[YStarView alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
        [self.contentView addSubview:self.starView];
        //分
        self.mark = [[UILabel alloc] init];
        [self.contentView addSubview:self.mark];
        self.mark.font = [UIFont systemFontOfSize:14];
        self.mark.textColor = [UIColor whiteColor];
        //年
        self.year = [[UILabel alloc] init];
        [self.contentView addSubview:self.year];
        self.year.font = [UIFont systemFontOfSize:12];
        self.year.textColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat logoX = YMargin;
    CGFloat logoY = YMargin;
    CGFloat logoW = 60;
    CGFloat logoH = 80;
    self.logo.frame = CGRectMake(logoX, logoY, logoW, logoH);
    
    //title
    CGFloat titleX = CGRectGetMaxX(self.logo.frame) + YMargin;
    CGFloat titleY = logoY;
    CGFloat titleW = 150;
    CGFloat titleH = 30;
    self.title.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    
    CGFloat starViewX = titleX;
    CGFloat starViewY = CGRectGetMaxY(self.title.frame);
    CGRect starFrame = self.starView.frame;
    starFrame.origin = CGPointMake(starViewX, starViewY);
    self.starView.frame = starFrame;
    self.starView.grade = self.movie.average;
    
    //mark
    CGFloat markW = 35;
    CGFloat markX = self.contentView.bounds.size.width - markW*2;
    CGFloat markH = 30;
    CGFloat markY = CGRectGetMidY(self.starView.frame) - markH/2;
    self.mark.frame = CGRectMake(markX, markY, markW, markH);
    
    //year
    CGFloat yearX = titleX;
    CGFloat yearH = 20;
    CGFloat yearY = CGRectGetMaxY(self.starView.frame) + YMargin/2;
    CGFloat yearW = titleW;
    self.year.frame = CGRectMake(yearX, yearY, yearW, yearH);
}




-(void)setMovie:(YMovie *)movie
{
    _movie = movie;
    NSString *image = movie.images[@"medium"];
    [self.logo sd_setImageWithURL:[NSURL URLWithString:image]];
    self.title.text = movie.title;
    self.year.text = [NSString stringWithFormat:@"上映时间:%@年",movie.year];
    self.mark.text = [NSString stringWithFormat:@"%.1f分",movie.average];
    
}

@end
