//
//  ViewController.m
//  ZFPopupMenuExample
//
//  Created by macOne on 15/9/1.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "ViewController.h"
#import "ZFPopupMenu.h"
#import "ZFPopupMenuItem.h"

@interface ViewController ()

@end

@implementation ViewController
-(NSArray *)menuItems
{
    ZFPopupMenuItem *item1 = [ZFPopupMenuItem initWithMenuName:@"新建"
                                                         image:[UIImage imageNamed:@"图标1"]
                                                        action:@selector(test1)
                                                        target:self];
    ZFPopupMenuItem *item2 = [ZFPopupMenuItem initWithMenuName:@"新建测试占位符"
                                                         image:[UIImage imageNamed:@"图标2"]
                                                        action:@selector(test2)
                                                        target:self];
    ZFPopupMenuItem *item3 = [ZFPopupMenuItem initWithMenuName:@"新建占位符"
                                                         image:[UIImage imageNamed:@"图标3"]
                                                        action:@selector(test3)
                                                        target:self];
    ZFPopupMenuItem *item4 = [ZFPopupMenuItem initWithMenuName:@"新建占位符占位符"
                                                         image:[UIImage imageNamed:@"图标4"]
                                                        action:@selector(test4)
                                                        target:self];
    
    return @[item1,item2,item3,item4,item2,item4,item3,item2,item3,item4];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];

    self.navigationItem.title = @"ZFPopMenu";
    
    //示例
    CGFloat W = 40;
    CGFloat H = 90;
    UIButton *LeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    LeftButton.titleLabel.numberOfLines = 0;
    LeftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    LeftButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    LeftButton.layer.borderWidth = 1;
    [LeftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [LeftButton setFrame:CGRectMake(10, 150 , 40, 40)];
    //    [LeftButton setBackgroundColor:[UIColor brownColor]];
    [LeftButton setTitle:@"默认横向布局" forState:UIControlStateNormal];
    [LeftButton addTarget:self action:@selector(normal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LeftButton];
    
    UIButton *midButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    midButton1.titleLabel.numberOfLines = 0;
    midButton1.titleLabel.textAlignment = NSTextAlignmentCenter;
    midButton1.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [midButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [midButton1 setFrame:CGRectMake(40 + W, 150 , 40, 40)];
    [midButton1 setBackgroundColor:[UIColor brownColor]];
    [midButton1 setTitle:@"设置背景" forState:UIControlStateNormal];
    [midButton1 addTarget:self action:@selector(setBackground:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:midButton1];
    
    UIButton *midButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    midButton2.titleLabel.numberOfLines = 0;
    midButton2.titleLabel.textAlignment = NSTextAlignmentCenter;
    midButton2.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [midButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [midButton2 setFrame:CGRectMake(2 * (40 + W), 150 , 40, 40)];
    [midButton2 setBackgroundColor:[UIColor brownColor]];
    [midButton2 setTitle:@"设置字体颜色" forState:UIControlStateNormal];
    [midButton2 addTarget:self action:@selector(setTextColor:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:midButton2];
    
    UIButton *midButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    midButton3.titleLabel.numberOfLines = 0;
    midButton3.titleLabel.textAlignment = NSTextAlignmentCenter;
    midButton3.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [midButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [midButton3 setFrame:CGRectMake(3 * (40 + W), 150 , 40, 40)];
    [midButton3 setBackgroundColor:[UIColor brownColor]];
    [midButton3 setTitle:@"设置选择高亮" forState:UIControlStateNormal];
    [midButton3 addTarget:self action:@selector(setHighlight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:midButton3];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.numberOfLines = 0;
    rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setFrame:CGRectMake(4 * (40 + W), 150 , 40, 40)];
    [rightButton setBackgroundColor:[UIColor brownColor]];
    [rightButton setTitle:@"设置透明度" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(setAphla:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    
    UIButton *VLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    VLeftButton.titleLabel.numberOfLines = 0;
    VLeftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    VLeftButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    VLeftButton.layer.borderWidth = 1;
    [VLeftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [VLeftButton setFrame:CGRectMake(10, 150 + (40 + H) , 40, 40)];
    [VLeftButton setTitle:@"默认纵向布局" forState:UIControlStateNormal];
    [VLeftButton addTarget:self action:@selector(VNormal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:VLeftButton];
    
    UIButton *VmidButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    VmidButton1.titleLabel.numberOfLines = 0;
    VmidButton1.titleLabel.textAlignment = NSTextAlignmentCenter;
    VmidButton1.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [VmidButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [VmidButton1 setFrame:CGRectMake(40 + W, 150 + (40 + H), 40, 40)];
    [VmidButton1 setBackgroundColor:[UIColor brownColor]];
    [VmidButton1 setTitle:@"设置背景" forState:UIControlStateNormal];
    [VmidButton1 addTarget:self action:@selector(VSetBackground:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:VmidButton1];
    
    UIButton *VmidButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    VmidButton2.titleLabel.numberOfLines = 0;
    VmidButton2.titleLabel.textAlignment = NSTextAlignmentCenter;
    VmidButton2.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [VmidButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [VmidButton2 setFrame:CGRectMake(2 * (40 + W), 150+ (40 + H) , 40, 40)];
    [VmidButton2 setBackgroundColor:[UIColor brownColor]];
    [VmidButton2 setTitle:@"设置字体颜色" forState:UIControlStateNormal];
    [VmidButton2 addTarget:self action:@selector(VSetTextColor:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:VmidButton2];
    
    UIButton *VmidButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    VmidButton3.titleLabel.numberOfLines = 0;
    VmidButton3.titleLabel.textAlignment = NSTextAlignmentCenter;
    VmidButton3.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [VmidButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [VmidButton3 setFrame:CGRectMake(3 * (40 + W), 150 + (40 + H), 40, 40)];
    [VmidButton3 setBackgroundColor:[UIColor brownColor]];
    [VmidButton3 setTitle:@"设置选择高亮" forState:UIControlStateNormal];
    [VmidButton3 addTarget:self action:@selector(VSetHighlight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:VmidButton3];
    
    UIButton *VrightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    VrightButton.titleLabel.numberOfLines = 0;
    VrightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    VrightButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [VrightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [VrightButton setFrame:CGRectMake(4 * (40 + W), 150 + (40 + H), 40, 40)];
    [VrightButton setBackgroundColor:[UIColor blackColor]];
    [VrightButton setTitle:@"设置透明度" forState:UIControlStateNormal];
    [VrightButton addTarget:self action:@selector(VSetAphla:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:VrightButton];
    
}



-(void)normal:(UIButton *)sender
{
    ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
    [popupMenu showInView:self.navigationController.view fromRect:sender.frame layoutType:Horizontal];
    [self.navigationController.view addSubview:popupMenu];
}

-(void)setBackground:(UIButton *)sender
{
    
    //brownColor 0.6, 0.4, 0.2
    
    [ZFPopupMenu setMenuBackgroundColorWithRed:0.6 green:0.4 blue:0.2 aphla:1];
    ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
    [popupMenu showInView:self.navigationController.view fromRect:sender.frame layoutType:Horizontal];
    [self.navigationController.view addSubview:popupMenu];
}


-(void)setTextColor:(UIButton *)sender
{
    [ZFPopupMenu setMenuBackgroundColorWithRed:0.6 green:0.4 blue:0.2 aphla:1];
    [ZFPopupMenu setTextColorWithRed:1 green:1 blue:1 aphla:1.0];
    ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
    [popupMenu showInView:self.navigationController.view fromRect:sender.frame layoutType:Horizontal];
    [self.navigationController.view addSubview:popupMenu];
}

-(void)setHighlight:(UIButton *)sender
{
    [ZFPopupMenu setMenuBackgroundColorWithRed:0.6 green:0.4 blue:0.2 aphla:1];
    [ZFPopupMenu setTextColorWithRed:1 green:1 blue:1 aphla:1.0];
    [ZFPopupMenu setHighlightedImage:[UIImage imageNamed:@"cancelBg"]];
    ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
    [popupMenu showInView:self.navigationController.view fromRect:sender.frame layoutType:Horizontal];
    [self.navigationController.view addSubview:popupMenu];
}

-(void)setAphla:(UIButton *)sender
{
    [ZFPopupMenu setMenuBackgroundColorWithRed:0.6 green:0.4 blue:0.2 aphla:0.2];
    [ZFPopupMenu setTextColorWithRed:1 green:1 blue:1 aphla:1.0];
    [ZFPopupMenu setHighlightedImage:[UIImage imageNamed:@"cancelBg"]];
    ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
    [popupMenu showInView:self.navigationController.view fromRect:sender.frame layoutType:Horizontal];
    [self.navigationController.view addSubview:popupMenu];
}
-(void)VNormal:(UIButton *)sender
{
    ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
    [popupMenu showInView:self.navigationController.view fromRect:sender.frame layoutType:Vertical];
    [self.navigationController.view addSubview:popupMenu];
}

-(void)VSetBackground:(UIButton *)sender
{
    
    //brownColor 0.6, 0.4, 0.2
    
    [ZFPopupMenu setMenuBackgroundColorWithRed:0.6 green:0.4 blue:0.2 aphla:1];
    ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
    [popupMenu showInView:self.navigationController.view fromRect:sender.frame layoutType:Vertical];
    [self.navigationController.view addSubview:popupMenu];
}


-(void)VSetTextColor:(UIButton *)sender
{
    [ZFPopupMenu setMenuBackgroundColorWithRed:0.6 green:0.4 blue:0.2 aphla:1];
    [ZFPopupMenu setTextColorWithRed:1 green:1 blue:1 aphla:1.0];
    ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
    [popupMenu showInView:self.navigationController.view fromRect:sender.frame layoutType:Vertical];
    [self.navigationController.view addSubview:popupMenu];
}

-(void)VSetHighlight:(UIButton *)sender
{
    [ZFPopupMenu setMenuBackgroundColorWithRed:0.6 green:0.4 blue:0.2 aphla:1];
    [ZFPopupMenu setTextColorWithRed:1 green:1 blue:1 aphla:1.0];
    [ZFPopupMenu setHighlightedImage:[UIImage imageNamed:@"cancelBg"]];
    ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
    [popupMenu showInView:self.navigationController.view fromRect:sender.frame layoutType:Vertical];
    [self.navigationController.view addSubview:popupMenu];
}

-(void)VSetAphla:(UIButton *)sender
{
    [ZFPopupMenu setMenuBackgroundColorWithRed:0 green:0 blue:0 aphla:0.2];
    [ZFPopupMenu setTextColorWithRed:1 green:1 blue:1 aphla:1.0];
    [ZFPopupMenu setHighlightedImage:[UIImage imageNamed:@"cancelBg"]];
    ZFPopupMenu *popupMenu = [[ZFPopupMenu alloc] initWithItems:[self menuItems]];
    [popupMenu showInView:self.navigationController.view fromRect:sender.frame layoutType:Vertical];
    [self.navigationController.view addSubview:popupMenu];
}


#pragma mark - item

-(void)test1
{
    NSLog(@"新建");
}

-(void)test2
{
    NSLog(@"新建测试占位符");
}

-(void)test3
{
    NSLog(@"新建占位符");
}

-(void)test4
{
    NSLog(@"新建占位符占位符");
}
@end
