//
//  BaseNav.m
//  TinyStore
//
//  Created by 齐志坚 on 15/3/10.
//  Copyright (c) 2015年 齐志坚. All rights reserved.
//

#import "BaseNav.h"
@interface BaseNav ()

@end

@implementation BaseNav

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
