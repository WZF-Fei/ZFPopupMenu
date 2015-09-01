//
//  ZFPopupMenuItem.h
//  ZFNavigation
//
//  Created by macOne on 15/8/26.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFPopupMenuItem : UIView

@property (nonatomic,strong) NSString *itemName;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,readwrite) SEL action;
@property (nonatomic,weak) id target;

+ (instancetype) initWithMenuName:(NSString *)itemName
                            image:(UIImage *)image
                           action:(SEL)action
                           target:(id)target;

-(void) performAction;

@end
