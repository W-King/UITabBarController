//
//  MainTabbarController.m
//  BigSport
//
//  Created by 刘凡 on 16/4/7.
//  Copyright © 2016年 iCHSY. All rights reserved.
//

#import "MainTabbarController.h"
#import <UMMobClick/MobClick.h>

//vc
#import "HomeViewController.h"
#import "SportTimeViewController.h"
#import "MyInfoViewController.h"
#import "MessageViewController.h"
#import "BaseNav.h"
#import "PublishView.h"
//跳转
#import "EditSportTimePictureViewController.h"
#import "EditAtlasViewController.h"
#import "EditSportTimeViewController.h"
#import "EditVideoViewController.h"

//宏
#import "BaseColorMacro.h"
#import "NotificationMacro.h"
#import "ProjectConfigHeader.h"
#import "PPXTabBar.h"

//tool
#import "LoginServiceTool.h"
#import "UserInfoTool.h"
#import "EditSportTimeService.h"
#import "PhotoService.h"

//网络相关
#import "NetworkRequests.h"
//#import "BaseViewController+NODataView.h"
#import "NetworkingStatus.h"
//#import "ReadTheNumberRequest.h"
//model
#import "SportChickenSoupModel.h"

@interface MainTabbarController()
<UITabBarControllerDelegate,
PublishViewDelegate,
PhotoServiceDelegate>
{
    BaseNav *messageNav;
    PublishView *publishView;
}

@end

@implementation MainTabbarController

#pragma mark - Init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        [self creatViewController];
        [self addObserverEvent];
        [self creatPublishView];

    }
    return self;
}

- (void)creatViewController
{
    
    // 更换tabBar
    [self setValue:[[PPXTabBar alloc] init] forKeyPath:@"tabBar"];

//    RecommendViewController *recommendVC = [[RecommendViewController alloc] init];
    HomeViewController *recommendVC = [[HomeViewController alloc] init];
    BaseNav *recommendNav = [[BaseNav alloc] initWithRootViewController:recommendVC];
    recommendNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"Tabbar_icon_find_N"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Tabbar_icon_find_S"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
   
// V1.1.0  发现更换为运动时刻 LF
//    FindViewController *findViewController = [[FindViewController alloc] init];
//    BaseNav *findNav = [[BaseNav alloc] initWithRootViewController:findViewController];
//     findNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"时刻" image:[[UIImage imageNamed:@"Tabbar_icon_find_N"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Tabbar_icon_find_S"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    SportTimeViewController *findViewController = [[SportTimeViewController alloc] init];
    BaseNav *findNav = [[BaseNav alloc] initWithRootViewController:findViewController];
    findNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"时刻" image:[[UIImage imageNamed:@"Tabbar_icon_Recommend_N"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Tabbar_icon_Recommend_S"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    MessageViewController *messageVC =  [[MessageViewController alloc] init];
    messageNav = [[BaseNav alloc] initWithRootViewController:messageVC];
    messageNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[[UIImage imageNamed:@"Tabbar_message_find_N"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Tabbar_message_find_S"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    MyInfoViewController *myInfoVC = [[MyInfoViewController alloc] init];
    BaseNav *myInfoNav = [[BaseNav alloc] initWithRootViewController:myInfoVC];
    myInfoNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"Tabbar_icon_me_N"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Tabbar_icon_me_S"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    self.viewControllers = @[recommendNav,findNav,messageNav,myInfoNav];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_COLOR(@"#999999"),NSFontAttributeName:[UIFont systemFontOfSize:10.0f]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_COLOR(@"#F46B0A"),NSFontAttributeName:[UIFont boldSystemFontOfSize:10.0f]} forState:UIControlStateSelected];
    
}

- (void)addObserverEvent
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutEvent) name:XTYJ_LOGOUTEVENT object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeEvent) name:XTYJ_TOHOME object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MomentEvent) name:XTYJ_TOLISTTIME object:nil];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMessageViewController) name:XTYJ_MESSAGE_VIEW_CONTROLLER object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageNavNumber:) name:XTYJ_MESSAGENUMBER object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editButtonClickEvent) name:XTYJ_PUBLISH object:nil];

}

- (void)creatPublishView
{
    publishView = [[PublishView alloc]init];
    publishView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    publishView.delegate = self;
    publishView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    publishView.alpha = 0;
    [self.view addSubview:publishView];
}

#pragma mark - Button Event
- (void)editButtonClickEvent
{
    [self.view bringSubviewToFront:publishView];
    [UIView animateWithDuration:0.5
                     animations:^{
                         publishView.alpha = 1;
                     }];
    [self requestSportChickenSoup];
}


- (void)publishViewButtonState:(PublishViewType)buttonState
{
    [LoginServiceTool needLoginServiceViewController:self selector:@selector(selectpublishViewIndex:) withObject:@(buttonState)];
}

- (void)selectpublishViewIndex:(NSNumber *)index
{
    switch ([index integerValue]) {
        case PublishViewType_Picture://发图片
        {
            [MobClick event:@"100807"];
            if ([EditSportTimeService editSportTimeServicePiceture]) {
                
                EditSportTimePictureViewController *editSportTimePictureVC = [[EditSportTimePictureViewController alloc]init];
                [self.selectedViewController pushViewController:editSportTimePictureVC animated:YES];
            }
            else
            {
                [self selectCoverIamge];
            }
            break;
        }
        case PublishViewType_Atlas://发图集
        {
            [MobClick event:@"100802"];
            [self pushToEditAtlasViewController];
            break;
        }
        case PublishViewType_Article://发文章
        {
            [MobClick event:@"100801"];
            [self pushToEditSportTimeViewController];
            
            break;
        }
        case PublishViewType_Video://发视频
        {
            [MobClick event:@"100808"];
            [self pushToEditVideoViewController];
            break;
        }
        default:
            break;
    }
    
}
#pragma mark - Push Event

- (void)pushToEditAtlasViewController
{
    EditAtlasViewController *editAtlasViewController = [[EditAtlasViewController alloc] init];
    [self.selectedViewController pushViewController:editAtlasViewController animated:YES];
}

- (void)pushToEditSportTimeViewController
{
    EditSportTimeViewController *editSportTimeViewController = [[EditSportTimeViewController alloc] init];
    [self.selectedViewController pushViewController:editSportTimeViewController animated:YES];
}

- (void)pushToEditVideoViewController
{
    EditVideoViewController *editVideoViewController = [[EditVideoViewController alloc] init];
    [self.selectedViewController pushViewController:editVideoViewController animated:YES];
}
#pragma mark - PhotoServiceDelegate

- (void)selectCoverIamge
{
    [PhotoService shared].delegate = self;
    [[PhotoService shared] viewController:self photosType:PhotoImageSizeType_Original];
}

- (void)photosServiceImages:(NSArray *)images photosType:(PhotoImageSizeType)type
{
    if (type == PhotoImageSizeType_Original)
    {
        if ([images count] > 0)
        {
            PhotoImageModel *info = images[0];
            
            EditSportTimePictureViewController *editSportTimePictureVC = [[EditSportTimePictureViewController alloc]init];
            editSportTimePictureVC.coverModel = info;
            [self.selectedViewController pushViewController:editSportTimePictureVC animated:YES];
        }
    }
    
}


#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    BaseNav *nav = (BaseNav *)viewController;
    if ([((UIViewController *)nav.viewControllers[0]) isKindOfClass:[MyInfoViewController class]]||[((UIViewController *)nav.viewControllers[0]) isKindOfClass:[MessageViewController class]])
    {
        [LoginServiceTool needLoginServiceViewController:self selector:@selector(selectItemWithNavType:) withObject:viewController];
        return NO;
    }
    return YES;
}

#pragma mark - Other

- (void)selectItemWithNavType:(BaseNav *)viewController
{
    self.selectedIndex = [self.viewControllers indexOfObject:viewController];
}

#pragma mark - NSNotification Event
- (void)homeEvent
{
    self.selectedIndex = 0;
}

- (void)MomentEvent
{
    self.selectedIndex = 1;
}

- (void)logoutEvent
{
    self.selectedIndex = 0;
    messageNav.tabBarItem.badgeValue = nil;
}

- (void)messageNavNumber:(NSNotification*)notificationNumber
{
    NSDictionary *nameDictionary = [notificationNumber userInfo];
    NSString *numberStr = nil;
    
    if ([nameDictionary[@"messsageNumber"] intValue] > 0)
    {
        numberStr = nameDictionary[@"messsageNumber"];
    }
    messageNav.tabBarItem.badgeValue = numberStr;
}

- (void)showMessageViewController
{
    //消息中心
    if (self.selectedIndex != 2)
    {
        [self.selectedViewController.navigationController popToRootViewControllerAnimated:NO];
        self.selectedIndex = 2;
    }
}
#pragma mark - Request
- (void)requestSportChickenSoup
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [[NetworkRequests sharedClient] requestWithName:XTY_SportChickenSoup withParameters:dic successCallBack:^(SportChickenSoupModel *sportChickenSoupModel)
     {
         if ([sportChickenSoupModel.status integerValue] == 1)
         {
             //             publishView.alpha = 1;
             [publishView titlePrompt:sportChickenSoupModel.chickenSoup];
             //             [self.view addSubview:publishView];
         }
         else
         {
             [WarningTool showToastHintWithText:sportChickenSoupModel.error];
         }
     } failCallback:^(NSString *error) {
         [WarningTool showToastNetError];
     }];
}


@end
