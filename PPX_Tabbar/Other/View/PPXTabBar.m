//
//  PPXTabBar.m
//  BigSport
//
//  Created by pipixia on 16/10/28.
//  Copyright © 2016年 iCHSY. All rights reserved.
//

#import "PPXTabBar.h"
#import "UIView+Distribution.h"
#import "PublishView.h"
#import "BaseMacro.h"
#import "NotificationMacro.h"

@interface PPXTabBar()
/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation PPXTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"Tabbar_icon_fabu"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"Tabbar_icon_fabu"] forState:UIControlStateHighlighted];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [publishButton addTarget:self action:@selector(publishButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.fWidth;
    CGFloat height = self.fHeight;
    
    // 设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
    }
}

- (void)publishButtonClicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:XTYJ_PUBLISH object:nil];

}


@end
