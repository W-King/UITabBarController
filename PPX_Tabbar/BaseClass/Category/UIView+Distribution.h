//
//  UIView+Distribution.h
//  LessonUITableView
//
//  Created by lanouhn on 13-12-25.
//  Copyright (c) 2013年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Distribution)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, readonly) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, readonly) CGFloat bottom;
@property (nonatomic, assign) CGFloat fWidth;
@property (nonatomic, assign) CGFloat fHeight;

@end
