//
//  ZFPopupMenuItem.m
//  ZFNavigation
//
//  Created by macOne on 15/8/26.
//  Copyright (c) 2015年 WZF. All rights reserved.

//some idea by kxMenu see more
//https://github.com/kolyvan/kxmenu
//
#import "ZFPopupMenuItem.h"

@implementation ZFPopupMenuItem

+ (instancetype) initWithMenuName:(NSString *)itemName
                            image:(UIImage *)image
                           action:(SEL)action
                           target:(id)target
{
    return [[ZFPopupMenuItem alloc] initWithMenuName:itemName
                                             image:image
                                            action:action
                                            target:target];
}


-(id) initWithMenuName:(NSString *)itemName
                 image:(UIImage *)image
                action:(SEL)action
                target:(id)target
{
    self = [super init];
    if (self) {
        _itemName = itemName;
        _image = image;
        _action = action;
        _target = target;
    }
    
    return self;
}

-(void) performAction
{
    id target = self.target;
    
    if (target && [target respondsToSelector:_action]) {
        
        [target performSelectorOnMainThread:_action withObject:self waitUntilDone:YES];
    }
}
@end
