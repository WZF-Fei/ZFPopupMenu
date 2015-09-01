//
//  ZFPopupMenu.m
//  ZFNavigation
//
//  Created by macOne on 15/8/26.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "ZFPopupMenu.h"
#import "ZFPopupMenuItem.h"
#import "ZFPopupOverlayView.h"
#import <QuartzCore/QuartzCore.h>

#define kArrowSize 10.0 //箭头大小
#define ArrowEdgeSize 15.0 //箭头与frame的边距
#define kMarginFrame 5    //弹出菜单的frame与屏幕的边距
#define kCloumnCount 5    //横向排序的每行个数
#define kMarginY  5.0
#define kMarginX  15.0

static  UIColor *textColor = nil;
static  UIFont  *textFont = nil;
static  CGFloat backRed = 1;
static  CGFloat backGreen = 1 ;
static  CGFloat backBlue = 1;
static  CGFloat backAphla = 1.0;
static  UIImage *highlightedImage;
static  UIColor *SeparationLineColor = nil;

@interface ZFPopupMenu()

@property (nonatomic,copy)      NSArray *menuItems;
@property (nonatomic,strong)    UIView *contentView;
@property (nonatomic,strong)    UIScrollView *scrollView;
@property (nonatomic,assign)    CGRect fromRect;
@property (nonatomic,weak)      UIView *view;
@property (nonatomic,assign)    LayoutType layoutType;
@property (nonatomic,strong)    ZFPopupOverlayView *overlayView;

@property (nonatomic,assign)    UIColor *textColor;

@property (nonatomic,assign)    CGPoint arrowStartPoint; //箭头顶点
@property (nonatomic,assign)    BOOL showScroll;

@end

@implementation ZFPopupMenu


#pragma mark 类方法，获取背景颜色
+(CGFloat)backRed
{

    return backRed;
}

+(CGFloat)backGreen
{
    return backGreen;
}

+(CGFloat)backBlue
{
    return backBlue;
}

+(CGFloat)backAphla
{
    return backAphla;
}

+(UIColor *)textColor
{
    if (!textColor) {
        textColor = [UIColor blackColor];
    }
    return textColor;
}

+(UIFont *)textFont
{
    if (!textFont) {
        textFont = [UIFont systemFontOfSize:13.0];
    }
    return textFont;
}

+(UIImage *)highlightedImage
{
    if (!highlightedImage) {
        highlightedImage = [ZFPopupMenu createImageWithColor:[UIColor grayColor]];
    }

    return highlightedImage;
}

+(UIColor *)SeparationLineColor
{
    if (!SeparationLineColor) {
        SeparationLineColor = [UIColor grayColor];
    }
    return SeparationLineColor;
}

//设置menu背景颜色
+(void)setMenuBackgroundColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue aphla:(CGFloat)aphla
{
    backRed = red;
    backGreen = green;
    backBlue = blue;
    backAphla = aphla;
    
}

+(void)setHighlightedImage:(UIImage *)image
{
    highlightedImage = image;
}

#pragma mark - 设置字体颜色
//设置字体颜色
+(void)setTextColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue aphla:(CGFloat)aphla
{
    textColor = [UIColor colorWithRed:red green:green blue:blue alpha:aphla];
    
}

+(void)setSeparationLineColor:(UIColor *)color
{
    SeparationLineColor = color;
}

#pragma mark - setter 方法
- (void) setOffset:(CGFloat)offset
{
    if (_offset) {
        _offset = 10;
    }
    else{
        _offset = offset;
    }
}
#pragma mark - 初始化
- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if(self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingNone;
        self.opaque = NO;
        _menuItems = items;
        _offset = 10;
        _layoutType = Vertical;
        _showScroll = NO;
    }
    
    return self;
}

#pragma mark - 构造菜单子项
-(UIView *) makeContenViewFromView:(UIView *)fromView
{
    /*
     1. item 赋给初始值
     2. 然后先根据图片和字体高度比较计算最大高度
     3. 根据itemName 计算最大宽度
     */
    
    /*
     横向排列 要根据宽度计算平分子项（默认每行子项为5）
     
     */
    
    static const CGFloat kMinItemWidth = 30;
    static const CGFloat kMinItemHeight = 30;
    
    const CGFloat kMaxHorizontalItemWidth = (float)(fromView.frame.size.width - 4.0*kMarginY)/kCloumnCount;

    
    CGFloat maxItemWidth = 0.0;
    CGFloat maxItemHeight = 0.0;
    CGFloat maxImageWidth = 0.0;
    CGFloat maxImageHeight = 0.0;
    CGFloat maxHorizontalItemHeight = 0.0;

    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    
    for (ZFPopupMenuItem *menuItem in _menuItems){
        maxImageWidth = menuItem.image.size.width >maxImageWidth ? menuItem.image.size.width : maxImageWidth;
        maxImageHeight = menuItem.image.size.height >maxItemHeight ? menuItem.image.size.height : maxItemHeight;
    }
    
    for (ZFPopupMenuItem *menuItem in _menuItems){
        
        CGSize titleSize = [menuItem.itemName sizeWithAttributes:@{NSFontAttributeName:[ZFPopupMenu textFont]}];
        
        CGFloat itemHeight = MAX (menuItem.image.size.height,titleSize.height) + kMarginY *2;
        CGFloat itemWidth = maxImageWidth + titleSize.width + kMarginX *2;
        
        if (itemHeight > maxItemHeight) {
            maxItemHeight = itemHeight;
        }
        if (itemWidth > maxItemWidth) {
            maxItemWidth = itemWidth;
        }
        maxHorizontalItemHeight = maxImageHeight + titleSize.height;
    }
    
    //横向排列 竖向排列
    maxItemWidth = MAX(maxItemWidth, kMinItemWidth);
    maxItemHeight = MAX(maxItemHeight, kMinItemHeight);
    
    CGFloat titleX = kMarginX + (maxImageWidth > 0 ? maxImageWidth + kMarginX : 0);
    CGFloat titleWidth = maxItemWidth - titleX ;
    
    CGFloat itemY = 5.0;
    CGFloat itemX = 5.0;
    NSInteger num = 0;
    
    
    switch (_layoutType) {
        case Horizontal:
        {
            for (ZFPopupMenuItem *menuItem in _menuItems) {
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(itemX, itemY, kMaxHorizontalItemWidth, maxHorizontalItemHeight + kMarginY *2 )];
//                [view setBackgroundColor:[UIColor yellowColor]];
                [contentView addSubview:view];
                
                //item button
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = num;

//                button.backgroundColor = [UIColor brownColor];
                button.frame = view.bounds;
                [button addTarget:self action:@selector(ckickItem:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundImage:[ZFPopupMenu highlightedImage] forState:UIControlStateHighlighted];
                [view addSubview:button];
                

                UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0 , kMarginY, kMaxHorizontalItemWidth, maxImageHeight)];
                imageView.image = menuItem.image;
                imageView.clipsToBounds = YES;
                imageView.contentMode = UIViewContentModeCenter;
                imageView.autoresizingMask = UIViewAutoresizingNone;
                [view addSubview:imageView];
                
                UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0 , kMarginY *2  + maxImageHeight, kMaxHorizontalItemWidth, maxHorizontalItemHeight - maxImageHeight)];
                title.text = menuItem.itemName;
                title.textColor = [ZFPopupMenu textColor];
                title.font = [ZFPopupMenu textFont];
                title.textAlignment = NSTextAlignmentCenter;
                [view addSubview:title];
                


      
                ++num;
                if (num % kCloumnCount == 0) {
                
                    itemY +=  maxHorizontalItemHeight + kMarginY *2;
                    UILabel *HLine = [[UILabel alloc] initWithFrame:CGRectMake(0, maxHorizontalItemHeight + kMarginY *2, kMaxHorizontalItemWidth, 0.5)];
                    HLine.layer.borderWidth = 0.5;
                    HLine.layer.borderColor = [ZFPopupMenu SeparationLineColor].CGColor;
                    [view addSubview:HLine];
                }
                else
                {
                   
                    UILabel *VLine = [[UILabel alloc] initWithFrame:CGRectMake(kMaxHorizontalItemWidth, 0, 0.5, maxHorizontalItemHeight + kMarginY *2)];
                    VLine.layer.borderWidth = 0.5;
                    VLine.layer.borderColor = [ZFPopupMenu SeparationLineColor].CGColor;
                    [view addSubview:VLine];
                    
                    UILabel *HLine = [[UILabel alloc] initWithFrame:CGRectMake(0, maxHorizontalItemHeight + kMarginY *2, kMaxHorizontalItemWidth, 0.5)];
                    HLine.layer.borderWidth = 0.5;
                    HLine.layer.borderColor = [ZFPopupMenu SeparationLineColor].CGColor;
                    [view addSubview:HLine];
                    
                }

                itemX = (num % kCloumnCount) *kMaxHorizontalItemWidth + 5;
 
            }
            
            if ([_menuItems count] % kCloumnCount == 0) {
                contentView.frame = CGRectMake(0, 0, fromView.frame.size.width - 2*kMarginY, itemY);
            }
            else{
                contentView.frame = CGRectMake(0, 0, fromView.frame.size.width - 2*kMarginY, itemY + maxHorizontalItemHeight + kMarginY *3);
            }

        }
            break;
           
        case Vertical:
        {
            for (ZFPopupMenuItem *menuItem in _menuItems) {
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, itemY, maxItemWidth + kMarginX, maxItemHeight )];
                //        [view setBackgroundColor:[UIColor yellowColor]];
                [contentView addSubview:view];
                
                //item button
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = num;
                button.frame = view.bounds;
                [button addTarget:self action:@selector(ckickItem:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundImage:[ZFPopupMenu highlightedImage] forState:UIControlStateHighlighted];
                [view addSubview:button];
                
                UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, kMarginY, titleWidth, maxItemHeight - kMarginY*2)];
                title.text = menuItem.itemName;
                title.textColor = [ZFPopupMenu textColor];
                title.font = [ZFPopupMenu textFont];
                title.textAlignment = NSTextAlignmentLeft;
                [view addSubview:title];
                
                UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(kMarginX, kMarginY, maxImageWidth, maxItemHeight - kMarginY * 2)];
                imageView.image = menuItem.image;
                imageView.clipsToBounds = YES;
                imageView.contentMode = UIViewContentModeCenter;
                imageView.autoresizingMask = UIViewAutoresizingNone;
                [view addSubview:imageView];
                
                if (num < (_menuItems.count -1)) {
                    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, maxItemHeight, maxItemWidth + kMarginX, 0.5)];
                    line.layer.borderWidth = 0.5;
                    line.layer.borderColor = [ZFPopupMenu SeparationLineColor].CGColor;
                    [view addSubview:line];
                }
                
                itemY += maxItemHeight;
                num ++ ;
                
            }
            
            contentView.frame = CGRectMake(0, 0, maxItemWidth +kMarginX, itemY + kMarginY);
        }
            break;
        default:
            break;
    }
    
    return contentView;
}


#pragma mark - 菜单显示的的位置
-(void)showInView:(UIView *)view fromRect:(CGRect)rect layoutType:(LayoutType)type
{
    _fromRect = rect;
    _layoutType = type;
    
    _contentView = [self makeContenViewFromView:view];
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_contentView.frame), _contentView.frame.size.height)];
//    [_scrollView setBackgroundColor:[UIColor redColor]];
//    _scrollView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    [_scrollView addSubview:_contentView];
    
    
    [self addSubview:_scrollView];
    
    //构造弹出菜单的frame 留出箭头区域
    [self setupFrameInView:view fromRect:_fromRect];
    
    //重新计算其高度赋给scrolleview
    if (_showScroll) {
        [_scrollView setFrame:CGRectMake(CGRectGetMinX(_contentView.frame), 15, CGRectGetWidth(_contentView.frame), self.frame.size.height - 20)];
    }
    else
    {
        [_scrollView setFrame:CGRectMake(CGRectGetMinX(_contentView.frame), 0, CGRectGetWidth(_contentView.frame), self.frame.size.height)];
    }
    
    //加入覆盖背景
    self.overlayView = [[ZFPopupOverlayView alloc] initWithFrame:view.frame];
    self.overlayView.popupMenu = self;
    [self.overlayView addSubview:self];
    
    [view addSubview:self.overlayView];
    
    
    //加入动画效果
    _contentView.hidden = YES;
    const CGRect toFrame = self.frame;
    self.frame = (CGRect){CGRectGetMinX(self.frame) +_arrowStartPoint.x, CGRectGetMinY(self.frame), 1, 1};
    
    [UIView animateWithDuration:0.2
                     animations:^(void) {
                         
                         self.alpha = 1.0f;
                         self.frame = toFrame;
                         
                     } completion:^(BOOL completed) {
                         _contentView.hidden = NO;
                     }];
    
}


-(void)showInView:(UIView *)view fromRect:(CGRect)rect layoutType:(LayoutType)type offset:(CGFloat)offset
{
    _offset = offset;

    [self showInView:view fromRect:rect layoutType:type];
    
}

#pragma mark - 构造视图的frame
- (void) setupFrameInView:(UIView *)view
                 fromRect:(CGRect)fromRect
{
    CGSize contentSize = _contentView.frame.size;
    
    //取fromRect中点 + ArrowEdgeSize + ArrowEdgeSize, 判断是否在屏幕内

    CGFloat fromMidX = CGRectGetMidX(fromRect); //from区域中点坐标
    CGFloat arrowStartPointXR = CGRectGetMidX(fromRect) + kArrowSize + ArrowEdgeSize;
    CGFloat arrowStartPointXL = fromRect.origin.x - kArrowSize - ArrowEdgeSize;
    CGFloat arrowStartPointY = 0;
    
    
    if (_layoutType == Horizontal) {
        arrowStartPointXR = CGRectGetMaxX(fromRect) - kArrowSize - ArrowEdgeSize;
        arrowStartPointXL = CGRectGetMinX(fromRect) + kArrowSize + ArrowEdgeSize;
    }
   
    if ((fromMidX + contentSize.width *0.5 + kMarginFrame ) <= CGRectGetMaxX(view.frame) &&
        (fromMidX - contentSize.width *0.5 + kMarginFrame ) >= CGRectGetMinX(view.frame)) {
        if (_layoutType == Horizontal){
            self.frame = CGRectMake(CGRectGetMinX(view.frame) + kMarginFrame, CGRectGetMaxY(fromRect) + _offset, contentSize.width, contentSize.height +kArrowSize);
        }
        else
        {
            self.frame = CGRectMake(fromMidX - contentSize.width * 0.5 + kMarginFrame , CGRectGetMaxY(fromRect) + _offset, contentSize.width, contentSize.height +kArrowSize);
        }
        
    }
    else if ((fromMidX + contentSize.width *0.5 + kMarginFrame ) > CGRectGetMaxX(view.frame))
    {
        self.frame = CGRectMake(CGRectGetMaxX(view.frame) - contentSize.width - kMarginFrame, CGRectGetMaxY(fromRect) + _offset, contentSize.width, contentSize.height + kArrowSize);
    }
    else if((fromMidX - contentSize.width *0.5 + kMarginFrame ) < CGRectGetMinX(view.frame))
    {
        self.frame = CGRectMake(CGRectGetMinX(view.frame) + kMarginFrame, CGRectGetMaxY(fromRect) + _offset, contentSize.width, contentSize.height + kArrowSize);
    }
    
    //构造箭头坐标,转换到self 视图坐标

    if (self.frame.origin.x <= arrowStartPointXL && (self.frame.origin.x + contentSize.width) >= arrowStartPointXR) {
        _arrowStartPoint = CGPointMake(fromMidX - self.frame.origin.x, arrowStartPointY);
    }
    else if (self.frame.origin.x > arrowStartPointXL)
    {
        _arrowStartPoint = CGPointMake(ArrowEdgeSize, arrowStartPointY);
    }
    else if ((self.frame.origin.x + contentSize.width) < arrowStartPointXR)
    {
        _arrowStartPoint = CGPointMake(contentSize.width - ArrowEdgeSize - kArrowSize, arrowStartPointY);
    }
    
    if (self.frame.size.height + CGRectGetMaxY(fromRect) + _offset + kMarginFrame > CGRectGetMaxY(view.frame)) {
        
        CGFloat height = CGRectGetMaxY(view.frame) - (CGRectGetMaxY(fromRect) + _offset + kMarginFrame);
        self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,height);
        _showScroll = YES;
        
    }
    _contentView.frame = (CGRect){0, kArrowSize, contentSize};

}

#pragma mark - 填充箭头
- (void)drawRect:(CGRect)rect {
    // Drawing code

    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    [arrowPath moveToPoint:    _arrowStartPoint];
    [arrowPath addLineToPoint: (CGPoint){_arrowStartPoint.x - 10, 10}];
    [arrowPath addLineToPoint: (CGPoint){_arrowStartPoint.x + 10, 10}];
    
    [[UIColor colorWithRed:[ZFPopupMenu backRed]  green:[ZFPopupMenu backGreen] blue:[ZFPopupMenu backBlue] alpha:[ZFPopupMenu backAphla]] set];
    
    [arrowPath fill];
    
    const CGRect bodyFrame = CGRectMake(0, self.bounds.origin.y + kArrowSize, self.bounds.size.width, self.bounds.size.height - kArrowSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:bodyFrame cornerRadius:8];
    CGContextSetRGBFillColor (context,  [ZFPopupMenu backRed], [ZFPopupMenu backGreen], [ZFPopupMenu backBlue], [ZFPopupMenu backAphla]);//设置填充颜色
    [roundedRectanglePath fill];
    [roundedRectanglePath addClip];
    

}



-(void)ckickItem:(UIButton *)sender
{
    ZFPopupMenuItem *menuItem = _menuItems[sender.tag];
    [menuItem performAction];
    [self dismissAnimated:YES];
}

#pragma mark - 视图消失事件
-(void)dismissAnimated:(BOOL) animated
{
    textColor = nil;
    backRed = 1;
    backGreen = 1;
    backBlue = 1;
    backAphla = 1;
    highlightedImage = nil;
    
    if (animated) {
        
        _contentView.hidden = YES;
        CGRect frame = (CGRect){ CGRectGetMinX(self.frame) +_arrowStartPoint.x, CGRectGetMinY(self.frame),1,1};
        [UIView animateWithDuration:0.2
                         animations:^(void) {
                             
                             self.alpha = 0;
                             self.frame = frame;
                             
                         } completion:^(BOOL finished) {
                             
                             [self removeFromSuperview];
                             [self.overlayView removeFromSuperview];
                         }];
    }
    else
    {
        [self removeFromSuperview];
        [self.overlayView removeFromSuperview];

    }

}

#pragma mark -UIColor 转换为UIImage
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
