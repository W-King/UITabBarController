//
//  CustomNavView.m
//  TinyStore
//
//  Created by 齐志坚 on 15/3/10.
//  Copyright (c) 2015年 齐志坚. All rights reserved.
//

#import "CustomNavView.h"
#import "ProjectConfigHeader.h"
#import "BaseMacro.h"
@interface CustomNavView ()

//@property (nonatomic, strong, readonly)UIImageView *bgImageView;


@end

@implementation CustomNavView
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize bgImageView = _bgImageView;
@synthesize titleLabel = _titleLabel;
@synthesize backButton = _backButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self UIConfig];
    }
    return self;
}

- (void)UIConfig
{
    self.backgroundColor = [UIColor blackColor];
    [self setBgView];
    [self makeNavTitleLable];
    [self setBackButton];
}

- (void)setBgView
{
    _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _bgImageView.backgroundColor = [UIColor whiteColor];
    _bgImageView.frame = self.bounds;
    [self addSubview:_bgImageView];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
    _bottomView.backgroundColor = RGB_COLOR(@"#F0F0F0");
    [_bgImageView addSubview:_bottomView];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    if (!color) {
        color = [UIColor clearColor];
    }
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (CGFloat)barHeight
{
    return 64;
}

+ (CGFloat)barWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

/**
 *使用自定义按钮和标题替换默认内容
 */
- (void)setLeftNavButton:(UIButton *)butt {
    if (butt)
    {
        [_leftButton removeFromSuperview];
        _leftButton = butt;
        _leftButton.frame = CGRectMake(0.0f, 22.0f, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
        [self addSubview:_leftButton];
        [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(0,-6.5,0, 0)];
    }
}

- (void)setRightNavButton:(UIButton *)butt {
    
    if (butt)
    {
        [_rightButton removeFromSuperview];
        _rightButton = butt;
        _rightButton.frame =  CGRectMake([[self class] barSize].width - [[self class] barBtnSize].width-5, 22.0f, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
        [self addSubview:_rightButton];
        [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
    }
}

- (void)setNavTitle:(NSString *)strTitle {
    [_titleLabel setText:strTitle];
    _titleLabel.font = FH(16);
    _titleLabel.textColor = RGB_COLOR(@"#4A4A4A");
    [self addSubview:_titleLabel];
}

- (void)makeNavTitleLable
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:20.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.frame = CGRectMake([[self class]  barBtnSize].width + 5.0f, 22.0f, [[self class] barSize].width - 2 * [[self class] barBtnSize].width - 10.0f, 40.0f);
}

- (void)setBackButton
{
    self.backButton = [[self class] createNavButtonByImageNormal:@"icon_back" imageSelected:@"icon_back" target:self action:@selector(backButtonClicked:)];
    [self setLeftNavButton:self.backButton];
   
}

- (void)backButtonClicked:(id)sender {
    if (self.VC) {
        [self.VC.navigationController popViewControllerAnimated:YES];
    }
}
+ (CGSize)barBtnSize
{
    return CGSizeMake(60.0f, 40.0f);
}
+ (CGSize)barSize
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 64.0f);
}
/**
 *使用自定义图片创建一个导航条按钮
 */
+ (UIButton *)createNavButtonByImageNormal:(NSString *)strNormal imageSelected:(NSString *)strSelected target:(id)target action:(SEL)action {
    UIImage *imageNormal = [UIImage imageNamed:strNormal];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:imageNormal forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:(strSelected ? strSelected : strNormal)] forState:UIControlStateSelected];
    return button;
}
/**
 *使用title创建一个导航条按钮
 */
+ (UIButton *)createNavButttonByTitle:(NSString *)strTitle target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:strTitle forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}

@end
