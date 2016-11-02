//
//  LoginTool.h
//  PPX_Tabbar
//
//  Created by pipixia on 2016/11/2.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"

typedef void (^LoginResult)(BOOL isLogin);

@interface LoginServiceTool : NSObject

+ (void)presentLoginViewControllerWihtViewController:(UIViewController*)viewController loginResult:(void(^)(BOOL isLogin))result;

+ (void)needLoginServiceViewController:(id)controller selector:(SEL)selector withObject:(id)object;

+ (void)needLoginServiceViewController:(id)controller selector:(SEL)selector;
@end
