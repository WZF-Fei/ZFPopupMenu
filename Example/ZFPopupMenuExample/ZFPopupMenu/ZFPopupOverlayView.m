//
//  ZFPopupOverlayView.m
//  ZFNavigation
//
//  Created by macOne on 15/8/27.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "ZFPopupOverlayView.h"

@implementation ZFPopupOverlayView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self setAlpha:0.3];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    
    if (view == self) {

        [self.popupMenu dismissAnimated:YES];
    }
}
@end
