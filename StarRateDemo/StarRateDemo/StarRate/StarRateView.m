//
//  StarRateView.m
//  StarRateDemo
//
//  Created by CumminsTY on 2018/11/9.
//  Copyright © 2018 --. All rights reserved.
//

#import "StarRateView.h"
@interface StarRateView()
@property (nonatomic, strong) UIView * starBgView; //加载所有星星的view
@property (nonatomic, strong) UIView * selectStarBgView; //加载选中星星的view
@property (nonatomic, assign) CGSize starSize;
@end
@implementation StarRateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setuViews];
        [self initData];
        [self configLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setuViews];
        [self initData];
        [self configLayout];
    }
    return self ;
}


-(void)setuViews{
    self.starBgView = [UIView new];
    [self addSubview:self.starBgView];
    
    self.selectStarBgView = [UIView new];
    [self addSubview:self.selectStarBgView];
    self.selectStarBgView.clipsToBounds = YES;

    
   
}

-(void)initData{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureEvent:)];
    
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:pan];
    
}

- (void)configLayout{
    
    self.starBgView.frame = CGRectMake(0, 0,CGRectGetWidth(self.frame), self.starSize.height);
    self.selectStarBgView.frame = CGRectMake(0, self.starBgView.frame.origin.y, CGRectGetWidth(self.selectStarBgView.frame), self.starSize.height);
}


#pragma mark - 手势
- (void)tapGestureEvent:(UITapGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:self];
    
    [self updateStarView:[self pointToRatio:point]];
}

-(void)panGesture:(UIPanGestureRecognizer*)pan{
    CGPoint point = [pan locationInView:self];
    
    [self updateStarView:[self pointToRatio:point]];

}


#pragma mark - private

/**
 比例

 @param point 选中的点
 @return 点击的位置 转化为所在的比例
 */
- (CGFloat)pointToRatio:(CGPoint)point{
    
    CGFloat ratio = 0.0f;
    
    if (point.x < self.starSpace) {
        
        ratio = 0;
        
    }else if (point.x > (CGRectGetMaxX(self.frame)-self.starSpace)){
        
        ratio = 1;
        
    }else{
        /* 比例转换
         *
         * 当前点击位置在当前视图宽度中的比例 转换为 当前点击星星位置在全部星星宽度中的比例
         * 当前点击位置去除其中的间距宽度等于星星的宽度 point.x - 间距 = 所选中的星星宽度
         * 所选中的星星宽度 / 所有星星宽度 = 当前选中的比例
         */
        
        CGFloat itemWidth = self.starSpace + self.starSize.width;
        
        CGFloat icount = point.x / itemWidth;
        
        NSInteger count = floorf(icount);
        
        CGFloat added = (itemWidth * (icount - count));
        
        added = added >= self.starSpace ? self.starSpace : added;
        
        CGFloat x = point.x - self.starSpace * count - added;
        
        ratio = x / (self.starSize.width * self.starCount);
    }
    
    return ratio;
}


/**
 更新星星视图 传入当前所选中的比例值

 @param ratio 比例
 */
- (void)updateStarView:(CGFloat)ratio{
    
    if (ratio < 0) return;
    
    if (ratio > 1) return;
    
    CGFloat width = 0.0f;
    
    // 根据类型计算比例和宽度
    
    switch (self.rateType) {
            
        case StarRateWhole:
        {
            ratio = ceilf(self.starCount * ratio);
            
            width = self.starSize.width * ratio + (self.starSpace * roundf(ratio));
        }
            break;
            
        case StarRateHalf:
        {
            
            ratio = self.starCount * ratio;
            
            CGFloat z = floorf(ratio);
            
            CGFloat s = ratio - z;
            
            if (s > 0.5f) ratio = z + 1.0f;
            
            if (s <= 0.5f && s >= 0.001f) ratio = z + 0.5f;
            
            width = self.starSize.width * ratio + (self.starSpace * roundf(ratio));
        }
            break;
            
        default:
            break;
    }
    
    // 设置宽度
    
    if (width < 0) width = 0;
    
    if (width > CGRectGetWidth(self.frame)) width = CGRectGetWidth(self.frame);
    
    CGRect selectedImagesViewFrame = self.selectStarBgView.frame;
    
    selectedImagesViewFrame.size.width = width;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.selectStarBgView.frame = selectedImagesViewFrame;
        
    }];
    
 
}


#pragma mark - setter/getter
-(void)setUnSelectStarImage:(UIImage *)unSelectStarImage{
    _unSelectStarImage = unSelectStarImage;
    
    [self.starBgView.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        imageView.image = unSelectStarImage;
    }];
}
-(void)setSelectedStarImage:(UIImage *)selectedStarImage{
    _selectedStarImage = selectedStarImage;
    
    [self.selectStarBgView.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        imageView.image = selectedStarImage;
    }];

}


-(void)setStarCount:(NSInteger)starCount{
    _starCount = starCount;
    for (int i = 0; i<starCount; i++) {
        UIImageView * unSelectStarIv = [[UIImageView alloc]initWithImage:self.unSelectStarImage];
        [self.starBgView addSubview:unSelectStarIv];
        
        UIImageView *selectedStarIv = [[UIImageView alloc] initWithImage:self.selectedStarImage];
        [self.selectStarBgView addSubview:selectedStarIv];
   
        
        CGRect imageFrame = CGRectMake(i ? (self.starSize.width + self.starSpace) * i + self.starSpace :  self.starSpace, 0, self.starSize.width, self.starSize.height);
        
        unSelectStarIv.frame = imageFrame;
        
        selectedStarIv.frame = imageFrame;
        
        
    }
    
}



-(CGSize)starSize{
    return CGSizeMake(self.frame.size.height, self.frame.size.height);
}
@end
