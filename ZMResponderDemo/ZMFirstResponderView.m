//
//  ZMFirstResponderView.m
//  ZMResponderDemo
//
//  Created by ZengZhiming on 2017/5/12.
//  Copyright © 2017年 菜鸟基地. All rights reserved.
//

#import "ZMFirstResponderView.h"

@implementation ZMFirstResponderView

/** 演示设置为第一响应者 */
- (void)setBecomeFirstResponder {
    // 判断对象是否已经是第一响应者
    if ([self isFirstResponder]) {
        return;
    }
    // 判断对象是否允许成为第一响应者
    if ([self canBecomeFirstResponder]) {
        // 设置成为第一响应者
        [self becomeFirstResponder];
    }
}

/** 演示放弃第一响应者 */
- (void)setResignFirstResponder {
    // 判断对象是否不是第一响应者
    if (![self isFirstResponder]) {
        return;
    }
    // 判断对象是否允许放弃第一响应者
    if ([self canResignFirstResponder]) {
        // 设置放弃第一响应者
        [self resignFirstResponder];
    }
}

/** 重写方法，允许对象成为第一响应者 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
