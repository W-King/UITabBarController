//
//  LoginTool.m
//  BigSport
//
//  Created by 刘凡 on 16/4/11.
//  Copyright © 2016年 iCHSY. All rights reserved.
//

#import "LoginServiceTool.h"
#import "BaseNav.h"
#import "UserInfoTool.h"
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
    if ([UserInfoTool isLogin])
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
    if ([UserInfoTool isLogin])
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
