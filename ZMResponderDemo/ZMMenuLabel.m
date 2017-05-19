//
//  ZMMenuLabel.m
//  ZMResponderDemo
//
//  Created by ZengZhiming on 2017/5/15.
//  Copyright © 2017年 菜鸟基地. All rights reserved.
//

#import "ZMMenuLabel.h"

@implementation ZMMenuLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 启用用户交互
        self.userInteractionEnabled = YES;
        // 添加长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMenu:)];
        longPressGesture.minimumPressDuration = 0.2;
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}

/** 允许对象成为第一响应者 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}

/** 长按响应 */
- (void)longPressMenu:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        // 设置成为第一响应者
        [self becomeFirstResponder];
        // 显示菜单
        UIMenuController *menuCtrl = [UIMenuController sharedMenuController];
        [menuCtrl setTargetRect:self.frame inView:self.superview];
        [menuCtrl setMenuVisible:YES animated:YES];
    }
}

/** 返回需要显示的菜单按钮 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // 只显示复制、粘贴按钮
    if (action == @selector(copy:) || action == @selector(paste:)) {
        return YES;
    }
    return NO;
}

/** 实现复制方法 */
- (void)copy:(id)sender {
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = self.text;
}

/** 实现粘贴方法 */
- (void)paste:(id)sender {
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    self.text = paste.string;
}

@end
