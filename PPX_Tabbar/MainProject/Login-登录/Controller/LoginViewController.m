//
//  LoginViewController.m
//  PPX_Tabbar
//
//  Created by pipixia on 2016/11/2.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    self.showType = LoginViewControllerShowType_Push;
    return self;
}

- (instancetype)initWithShowType:(LoginViewControllerShowType)type
{
    self = [self init];
    if (self) {
        self.showType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self InitUI];
}

#pragma mark - Init UI

- (void)modifyCustomNav
{
    [self.customNav setNavTitle:@"登录"];
    
    if (_showType == LoginViewControllerShowType_Present)
    {
        [self.customNav setLeftNavButton:[[self.customNav class] createNavButtonByImageNormal:@"icon_dismiss" imageSelected:@"icon_dismiss" target:self action:@selector(dismissButtonEvent)]];
    }
}
- (void)InitUI
{
    [self modifyCustomNav];
}
#pragma mark - Button Event

- (void)dismissButtonEvent
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
