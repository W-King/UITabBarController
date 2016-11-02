//
//  HomeViewController.m
//  PPX_Tabbar
//
//  Created by pipixia on 2016/10/31.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    [self InitUI];

}
#pragma mark - Init UI
- (void)modifyCustomNav{
    self.customNav.backButton.hidden = YES;
    [self.customNav setNavTitle:@"发现"];
}
- (void)buttonCreate
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor purpleColor];
    [btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)InitUI
{
    [self modifyCustomNav];
    [self buttonCreate];
}

#pragma mark - button
- (void)buttonClicked
{
    DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
    [self.navigationController pushViewController:detailsVC animated:YES];
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
