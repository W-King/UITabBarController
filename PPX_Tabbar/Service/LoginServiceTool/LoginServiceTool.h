//
//  LoginTool.h
//  BigSport
//
//  Created by 刘凡 on 16/4/11.
//  Copyright © 2016年 iCHSY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"

typedef void (^LoginResult)(BOOL isLogin);

@interface LoginServiceTool : NSObject

+ (void)presentLoginViewControllerWihtViewController:(UIViewController*)viewController loginResult:(void(^)(BOOL isLogin))result;

+ (void)needLoginServiceViewController:(id)controller selector:(SEL)selector withObject:(id)object;

+ (void)needLoginServiceViewController:(id)controller selector:(SEL)selector;
@end
