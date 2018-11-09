//
//  ViewController.m
//  StarRateDemo
//
//  Created by CumminsTY on 2018/11/9.
//  Copyright © 2018 --. All rights reserved.
//

#import "ViewController.h"
#import "StarRate/StarRateView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    StarRateView *ratingView = [[StarRateView alloc] initWithFrame:CGRectMake(50, 100, CGRectGetWidth(self.view.frame) - 80, 30)];
    ratingView.starSpace = 10.0f; //间距

    ratingView.starCount = 5;

    
    ratingView.selectedStarImage = [UIImage imageNamed:@"star_orange"]; //选中图片
    
    ratingView.unSelectStarImage = [UIImage imageNamed:@"star_gray"]; //未选中图片
    
    ratingView.rateType = StarRateHalf; //评分类型

    
    [self.view addSubview:ratingView];
    
    
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    iv.image = [UIImage imageNamed:@"star_orange"];
    [self.view addSubview:iv];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


@end
