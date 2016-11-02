//
//  UIView+Distribution.m
//  LessonUITableView
//
//  Created by lanouhn on 13-12-25.
//  Copyright (c) 2013年 lanouhn. All rights reserved.
//

#import "UIView+Distribution.h"

@implementation UIView (Distribution)

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}
- (CGFloat)right
{
    return self.frame.origin.x + [self fWidth];
}
- (CGFloat)top
{
    return self.frame.origin.y;
}
- (CGFloat)bottom
{
    return self.frame.origin.y + [self fHeight];
}

- (CGFloat)fWidth
{
    return self.bounds.size.width;
}

- (CGFloat)fHeight
{
    return self.bounds.size.height;
}


#pragma mark - Set

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setFWidth:(CGFloat)fWidth
{
    CGRect frame = self.frame;
    frame.size.width = fWidth;
    self.frame = frame;
}

- (void)setFHeight:(CGFloat)fHeight
{
    CGRect frame = self.frame;
    frame.size.height = fHeight;
    self.frame = frame;
}

@end
