//
//  BaseViewController.m
//  PPX_Tabbar
//
//  Created by pipixia on 2016/11/2.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseMacro.h"

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB_COLOR(@"#F0F0F0");
    self.customNav = [[CustomNavView alloc] initWithFrame:CGRectMake(0, 0, [CustomNavView barWidth], [CustomNavView barHeight])];
    self.customNav.VC = self;
    [self.view addSubview:self.customNav];
    
}
@end
