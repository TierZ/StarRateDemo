//
//  StarRateView.h
//  StarRateDemo
//
//  Created by CumminsTY on 2018/11/9.
//  Copyright © 2018 --. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    StarRateWhole,
    StarRateHalf,
} StarRateType;

typedef void (^SelectedStarBlock)(CGFloat rate); //选择后的结果block
@interface StarRateView : UIView
@property (nonatomic, assign) NSInteger starCount;//星星数量
@property (nonatomic, assign) NSInteger starSpace;//星星间距
@property (nonatomic, assign) NSInteger defaultCount;//默认显示的星星

@property (nonatomic, strong) UIImage * unSelectStarImage;
@property (nonatomic, strong) UIImage * selectedStarImage;
@property (nonatomic, assign) StarRateType rateType;
@property (nonatomic, copy) SelectedStarBlock block;
@end

NS_ASSUME_NONNULL_END
