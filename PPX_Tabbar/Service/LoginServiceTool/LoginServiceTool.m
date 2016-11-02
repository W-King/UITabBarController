//
//  LoginTool.m
//  PPX_Tabbar
//
//  Created by pipixia on 2016/11/2.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "LoginServiceTool.h"
#import "BaseNav.h"
static int i = 2;//判断是否登录

@implementation LoginServiceTool

+ (void)presentLoginViewControllerWihtViewController:(UIViewController*)viewController loginResult:(void(^)(BOOL isLogin))result
{
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithShowType:LoginViewControllerShowType_Present];
    loginViewController.loginResult = result;
    BaseNav *loginNav = [[BaseNav alloc] initWithRootViewController:loginViewController];
    [viewController presentViewController:loginNav animated:YES completion:nil];
}

+ (void)needLoginServiceViewController:(id)controller selector:(SEL)selector
{
    if (i == 1)
    {
        [self viewController:controller selector:selector];
    }
    else
    {
        [self presentLoginViewControllerWihtViewController:controller loginResult:^(BOOL isLogin){
            if (isLogin)
            {
                [self viewController:controller selector:selector];
            }
        }];
    }
}

+ (void)needLoginServiceViewController:(id)controller selector:(SEL)selector withObject:(id)object;
{
    if (i == 1)
    {
        [self viewController:controller selector:selector withObject:object];
    }
    else
    {
        [self presentLoginViewControllerWihtViewController:controller loginResult:^(BOOL isLogin){
            if (isLogin)
            {
                [self viewController:controller selector:selector withObject:object];
            }
        }];
    }
}

#pragma mark - Send Selector

+ (void)viewController:(id)controller selector:(SEL)selector
{

    if ([controller respondsToSelector:selector])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
         [controller performSelector:selector];
#pragma clang diagnostic pop
    }

}

+ (void)viewController:(id)controller selector:(SEL)selector withObject:(id)object
{
    if ([controller respondsToSelector:selector])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
       [controller performSelector:selector withObject:object];
       #pragma clang diagnostic pop
    }
}
@end
