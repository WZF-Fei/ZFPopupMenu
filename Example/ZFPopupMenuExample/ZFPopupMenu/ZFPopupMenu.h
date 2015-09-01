//
//  ZFPopupMenu.h
//  ZFNavigation
//
//  Created by macOne on 15/8/26.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    Horizontal,
    Vertical
    
}LayoutType;

@interface ZFPopupMenu : UIView


@property (nonatomic,assign) CGFloat offset; //偏移量

//设置字体颜色
+(void)setTextColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue aphla:(CGFloat)aphla;
//设置menu背景颜色
+(void)setMenuBackgroundColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue aphla:(CGFloat)aphla;
//设置高亮背景
+(void)setHighlightedImage:(UIImage *)image;
//设置分割线颜色
+(void)setSeparationLineColor:(UIColor *)color;

- (instancetype)initWithItems:(NSArray *)items;

-(void)showInView:(UIView *)view fromRect:(CGRect)rect layoutType:(LayoutType)type;

//加入偏移量
-(void)showInView:(UIView *)view fromRect:(CGRect)rect layoutType:(LayoutType)type offset:(CGFloat)offset;

-(void)dismissAnimated:(BOOL)animated;
@end
