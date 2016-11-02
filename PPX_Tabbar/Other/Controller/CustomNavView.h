//
//  CustomNavView.h
//  TinyStore
//
//  Created by 齐志坚 on 15/3/10.
//  Copyright (c) 2015年 齐志坚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavView : UIView
{
    @public
    UIView *_bottomView;
}
@property (nonatomic, strong)UIImageView *bgImageView;

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton *rightButton;
@property (nonatomic,weak)UIViewController *VC;
@property(nonatomic,strong)UIButton *backButton;


+ (CGFloat)barWidth;
+ (CGFloat)barHeight;

/**
 *使用自定义按钮和标题替换默认内容
 */
- (void)setBackButton;
- (void)setLeftNavButton:(UIButton *)butt;
- (void)setRightNavButton:(UIButton *)butt;
- (void)setNavTitle:(NSString *)strTitle;
/**
 *使用title创建一个导航条按钮
 */
+ (UIButton *)createNavButttonByTitle:(NSString *)strTitle target:(id)target action:(SEL)action;

/**
 *使用自定义图片创建一个导航条按钮
 */
+ (UIButton *)createNavButtonByImageNormal:(NSString *)strNormal imageSelected:(NSString *)strSelected target:(id)target action:(SEL)action;

- (void)backButtonClicked:(id)sender;
@end
