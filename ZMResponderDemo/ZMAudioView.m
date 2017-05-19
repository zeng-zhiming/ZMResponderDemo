//
//  ZMAudioView.m
//  ZMResponderDemo
//
//  Created by ZengZhiming on 2017/5/12.
//  Copyright © 2017年 菜鸟基地. All rights reserved.
//

#import "ZMAudioView.h"
#import <AVFoundation/AVFoundation.h>

@implementation ZMAudioView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 启动接受远程事件
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        // 设置成为第一响应者
        [self becomeFirstResponder];
        // 播放一段静音文件，使APP获取音频的控制权
        NSURL *audioURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"mute_60s" ofType:@"mp3"]];
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
        [audioPlayer play];
    }
    return self;
}

/** 允许对象成为第一响应者 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}

/** 远程控制事件响应 */
- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {
    NSLog(@"--->耳机线控响应");
}

- (void)dealloc {
    // 停止接受远程事件
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    // 放弃第一响应者
    [self resignFirstResponder];
}

@end
