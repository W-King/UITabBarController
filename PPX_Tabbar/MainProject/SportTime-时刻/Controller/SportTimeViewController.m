//
//  SportTimeViewController.m
//  PPX_Tabbar
//
//  Created by pipixia on 2016/10/31.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "SportTimeViewController.h"

@interface SportTimeViewController ()

@end

@implementation SportTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    [self modifyCustomNav];
    
}
#pragma mark - Init UI
- (void)modifyCustomNav{
    [self.customNav setNavTitle:@"时刻"];
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
