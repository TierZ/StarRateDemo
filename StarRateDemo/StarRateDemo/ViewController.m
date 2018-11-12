//
//  ViewController.m
//  StarRateDemo
//
//  Created by CumminsTY on 2018/11/9.
//  Copyright © 2018 --. All rights reserved.
//

#import "ViewController.h"
#import "StarRate/StarRateView.h"
@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    StarRateView *ratingView = [[StarRateView alloc] initWithFrame:CGRectMake(50, 100, CGRectGetWidth(self.view.frame) - 80, 30)];
    ratingView.selectedStarImage = [UIImage imageNamed:@"star_orange"]; //选中图片
    ratingView.unSelectStarImage = [UIImage imageNamed:@"star_gray"]; //未选中图片
    ratingView.rateType = StarRateHalf; //评分类型
    ratingView.starSpace = 10.0f; //间距
    ratingView.starCount = 5;
    ratingView.block = ^(CGFloat rate) {
        NSLog(@"rate = %f",rate);
    };
    [self.view addSubview:ratingView];
    
    
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:@"这是一个网址http://www.jianshu.com/users/37f2920f6848字符串！"];
    [attrStr addAttribute:NSLinkAttributeName
                    value:@"http://www.jianshu.com/users/37f2920f6848"
                    range:NSMakeRange(6, attrStr.length -6 -4)];
    
    UITextView * lab = [[UITextView alloc]initWithFrame:CGRectMake(50, 330, 300, 100)];
    lab.delegate = self;
    lab.editable = NO;
    lab.selectable = YES;
    lab.attributedText = attrStr;
    lab.textColor = [UIColor redColor];
    lab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:lab];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(nonnull NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    NSLog(@"url = %@  点击跳转",URL);
    return NO;
}

@end
