//
//  ZMDrawingBoardView.h
//  ZMResponderDemo
//
//  Created by ZengZhiming on 2017/5/17.
//  Copyright © 2017年 菜鸟基地. All rights reserved.
//

/** ==============ZMDrawingBoardView.h文件=================== */

#import <UIKit/UIKit.h>

/** 画板View */
@interface ZMDrawingBoardView : UIView

@end


/** 划线Model */
@interface ZMLineModel : NSObject

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;

@end
