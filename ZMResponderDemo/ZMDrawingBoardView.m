//
//  ZMDrawingBoardView.m
//  ZMResponderDemo
//
//  Created by ZengZhiming on 2017/5/17.
//  Copyright © 2017年 菜鸟基地. All rights reserved.
//

/** ==============ZMDrawingBoardView.m文件=================== */

#import "ZMDrawingBoardView.h"

/** 画板View */
@interface ZMDrawingBoardView ()

@property (nonatomic, strong) ZMLineModel *currentLine;
@property (nonatomic, strong) NSMutableArray<ZMLineModel *> *toucheArray;

@end

@implementation ZMDrawingBoardView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
        self.backgroundColor = [UIColor whiteColor];
        self.toucheArray = [NSMutableArray array];
    }
    return self;
}

/** 绘制画板 */
- (void)drawRect:(CGRect)rect {
    // 获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    // 设置宽度
    CGContextSetLineWidth(context, 5.0);
    // 设置颜色
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
    
    for (ZMLineModel *line in self.toucheArray) {
        // 开始绘制
        CGContextBeginPath(context);
        // 移动画笔到起点
        CGContextMoveToPoint(context, line.begin.x, line.begin.y);
        // 添加下一点
        CGContextAddLineToPoint(context, line.end.x, line.end.y);
        // 绘制完成
        CGContextStrokePath(context);
    }
}

/** 划线开始 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 标记开始撤销分组
    [self.undoManager beginUndoGrouping];
    
    for (UITouch *touch in touches) {
        // 记录起始点
        CGPoint locTouch = [touch locationInView:self];
        _currentLine = [[ZMLineModel alloc] init];
        _currentLine.begin = locTouch;
        _currentLine.end = locTouch;
    }
    
}

/** 划线移动 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        // 添加线条
        CGPoint locTouch = [touch locationInView:self];
        _currentLine.end = locTouch;
        [self addLine:_currentLine];
        // 当前线条
        _currentLine = [[ZMLineModel alloc] init];
        _currentLine.begin = locTouch;
        _currentLine.end = locTouch;
    }
}

/** 划线结束 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 结束标记撤销分组
    [self.undoManager endUndoGrouping];
}

/** 添加划线 */
- (void)addLine:(ZMLineModel *)line
{
    // 添加划线并重绘画板
    [self.toucheArray addObject:line];
    [self setNeedsDisplay];
    // 注册撤销方法
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
}

/** 移除划线 */
- (void)removeLine:(ZMLineModel *)line
{
    if ([self.toucheArray containsObject:line]) {
        // 移除划线并重绘画板
        [self.toucheArray removeObject:line];
        [self setNeedsDisplay];
        // 注册撤销方法
        [[self.undoManager prepareWithInvocationTarget:self] addLine:line];
    }
}

/** 撤销按钮点击响应 */
- (void)undoButtonAction:(id)sender {
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}

/** 重做按钮点击响应 */
- (void)redoButtonAction:(id)sender {
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
}

/** 初始化子控件 */
- (void)initSubView {
    // 撤销按钮
    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    undoButton.frame = CGRectMake(0, 64, 70, 50);
    [undoButton setTitle:@"undo撤销" forState:UIControlStateNormal];
    [undoButton sizeToFit];
    [undoButton addTarget:self action:@selector(undoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:undoButton];
    // 重做按钮
    UIButton *redoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    redoButton.frame = CGRectMake(CGRectGetWidth(self.frame)-70, 64, 70, 50);
    [redoButton setTitle:@"redo重做" forState:UIControlStateNormal];
    [redoButton sizeToFit];
    [redoButton addTarget:self action:@selector(redoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:redoButton];
}

@end


/** 划线Model */
@implementation ZMLineModel

@end
