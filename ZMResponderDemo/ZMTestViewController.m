//
//  ZMTestViewController.m
//  ZMResponderDemo
//
//  Created by ZengZhiming on 2017/4/25.
//  Copyright © 2017年 菜鸟基地. All rights reserved.
//

#import "ZMTestViewController.h"
#import "ZMAudioView.h"
#import "ZMMenuLabel.h"
#import "ZMDrawingBoardView.h"
#import "ZMKeyCommandView.h"
#import "ZMCustomInputView.h"

@interface ZMTestViewController ()


@end

@implementation ZMTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


/**
 *  查找视图的视图控制器
 *
 *  @param view 视图
 *
 *  @return 返回视图的控制器
 */
- (UIViewController *)getControllerFromView:(UIView *)view {
    // 遍历响应者链。返回第一个找到视图控制器
    UIResponder *responder = view;
    while ((responder = [responder nextResponder])){
        if ([responder isKindOfClass: [UIViewController class]]){
            return (UIViewController *)responder;
        }
    }
    // 如果没有找到则返回nil
    return nil;
}



/** 手指按下时响应 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"--->手指按下时响应");
}

/** 手指移动时响应 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    NSLog(@"--->手指移动时响应");
}

/** 手指抬起时响应 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    NSLog(@"--->手指抬起时响应");
}

/** 触摸取消(意外中断, 如:电话, Home键退出等) */
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"--->取消触摸响应");
}



/** 开始加速 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(3_0) {
    [super motionBegan:motion withEvent:event];
    NSLog(@"--->开始加速");
}

/** 结束加速 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(3_0) {
    [super motionEnded:motion withEvent:event];
    NSLog(@"--->结束加速");
}

/** 加速取消（意外中断, 如:电话, Home键退出等） */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(3_0) {
    [super motionCancelled:motion withEvent:event];
    NSLog(@"--->加速取消");
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
