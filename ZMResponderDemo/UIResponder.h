//
//  UIResponder.h
//  ZMHeaderFile
//
//  Created by ZengZhiming on 2017/4/18.
//  Copyright © 2017年 菜鸟基地. All rights reserved.
//
//  详解 UIResponder.h
//  Version iOS 10.3
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIEvent.h>

NS_ASSUME_NONNULL_BEGIN

@class UIPress;
@class UIPressesEvent;

#pragma mark - UIResponderStandardEditActions协议定义

@protocol UIResponderStandardEditActions <NSObject>
@optional
/** 剪切事件 */
- (void)cut:(nullable id)sender NS_AVAILABLE_IOS(3_0);
/** 复制事件 */
- (void)copy:(nullable id)sender NS_AVAILABLE_IOS(3_0);
/** 粘贴事件 */
- (void)paste:(nullable id)sender NS_AVAILABLE_IOS(3_0);
/** 选择事件 */
- (void)select:(nullable id)sender NS_AVAILABLE_IOS(3_0);
/** 全选事件 */
- (void)selectAll:(nullable id)sender NS_AVAILABLE_IOS(3_0);
/** 删除事件 */
- (void)delete:(nullable id)sender NS_AVAILABLE_IOS(3_2);
/** 从左到右写入字符串(居左) */
- (void)makeTextWritingDirectionLeftToRight:(nullable id)sender NS_AVAILABLE_IOS(5_0);
/** 从右到左写入字符串(居右) */
- (void)makeTextWritingDirectionRightToLeft:(nullable id)sender NS_AVAILABLE_IOS(5_0);
/** 切换字体为黑体(粗体) */
- (void)toggleBoldface:(nullable id)sender NS_AVAILABLE_IOS(6_0);
/** 切换字体为斜体 */
- (void)toggleItalics:(nullable id)sender NS_AVAILABLE_IOS(6_0);
/** 给文字添加下划线 */
- (void)toggleUnderline:(nullable id)sender NS_AVAILABLE_IOS(6_0);

/** 增加字体大小 */
- (void)increaseSize:(nullable id)sender NS_AVAILABLE_IOS(7_0);
/** 减小字体大小 */
- (void)decreaseSize:(nullable id)sender NS_AVAILABLE_IOS(7_0);

@end

#pragma mark - UIResponder类定义

NS_CLASS_AVAILABLE_IOS(2_0) @interface UIResponder : NSObject <UIResponderStandardEditActions>

#pragma mark - 响应者相关方法

/** 获取下一个响应者 */
#if UIKIT_DEFINE_AS_PROPERTIES
@property(nonatomic, readonly, nullable) UIResponder *nextResponder;
#else
- (nullable UIResponder *)nextResponder;
#endif

/** 是否允许成为第一响应者。默认返回NO */
#if UIKIT_DEFINE_AS_PROPERTIES
@property(nonatomic, readonly) BOOL canBecomeFirstResponder;
#else
- (BOOL)canBecomeFirstResponder;
#endif
/** 设置成为第一响应者 */
- (BOOL)becomeFirstResponder;

/** 是否允许放弃第一响应者。默认返回YES */
#if UIKIT_DEFINE_AS_PROPERTIES
@property(nonatomic, readonly) BOOL canResignFirstResponder;
#else
- (BOOL)canResignFirstResponder;
#endif
/** 设置放弃第一响应者 */
- (BOOL)resignFirstResponder;

/** 判断对象是否是第一响应者 */
#if UIKIT_DEFINE_AS_PROPERTIES
@property(nonatomic, readonly) BOOL isFirstResponder;
#else
- (BOOL)isFirstResponder;
#endif

#pragma mark - 触摸相关方法，一般用于响应屏幕触摸
/** 手指按下时响应 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
/** 手指移动时响应 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
/** 手指抬起时响应 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
/** 取消(意外中断, 如:电话, 系统警告窗等) */
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
/** 3DTouch响应(iOS9.1后使用) */
- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches NS_AVAILABLE_IOS(9_1);

#pragma mark - 深按相关方法，一般用于遥控器按键响应
/** 手指按压开始时响应 */
- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0);
/** 手指按压位置移动时响应 */
- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0);
/** 手指抬起接受按压时响应 */
- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0);
/** 按压取消(意外中断, 如:电话, 系统警告窗等) */
- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0);

#pragma mark - 加速相关方法，一般用于摇一摇、运动事件监听等
/** 开始加速 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(3_0);
/** 结束加速 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(3_0);
/** 加速取消（意外中断, 如:电话, 系统警告窗等） */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(3_0);

/** 远程控制事件 */
- (void)remoteControlReceivedWithEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(4_0);

/** 返回UIMenuController需要显示的控件(如：复制，粘贴等) */
- (BOOL)canPerformAction:(SEL)action withSender:(nullable id)sender NS_AVAILABLE_IOS(3_0);

/** 返回响应的操作目标对象 */
- (nullable id)targetForAction:(SEL)action withSender:(nullable id)sender NS_AVAILABLE_IOS(7_0);

/** 获取响应链就近共享撤消管理 */
@property(nullable, nonatomic,readonly) NSUndoManager *undoManager NS_AVAILABLE_IOS(3_0);

@end

/** 快捷主键枚举 */
typedef NS_OPTIONS(NSInteger, UIKeyModifierFlags) {
    UIKeyModifierAlphaShift     = 1 << 16,  //!< Alpha+Shift键.
    UIKeyModifierShift          = 1 << 17,  //!< Shift键.
    UIKeyModifierControl        = 1 << 18,  //!< Control键.
    UIKeyModifierAlternate      = 1 << 19,  //!< Alt键.
    UIKeyModifierCommand        = 1 << 20,  //!< Command键.
    UIKeyModifierNumericPad     = 1 << 21,  //!< Num键.
} NS_ENUM_AVAILABLE_IOS(7_0);

#pragma mark - 快捷键对象

NS_CLASS_AVAILABLE_IOS(7_0) @interface UIKeyCommand : NSObject <NSCopying, NSSecureCoding>

/** 初始化对象 */
- (instancetype)init NS_DESIGNATED_INITIALIZER;
/** 初始化对象 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/** 获取快捷辅键（如快捷命令【Command+A】中的 A 键） */
@property (nonatomic,readonly) NSString *input;
/** 获取快捷主键（如快捷命令【Command+A】中的 Command 键） */
@property (nonatomic,readonly) UIKeyModifierFlags modifierFlags;
/** 显示给用户的快捷键标题 */
@property (nullable,nonatomic,copy) NSString *discoverabilityTitle NS_AVAILABLE_IOS(9_0);

/** 创建一个快捷键命令 */
+ (UIKeyCommand *)keyCommandWithInput:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags action:(SEL)action;

/** 创建一个快捷键命令 */
+ (UIKeyCommand *)keyCommandWithInput:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags action:(SEL)action discoverabilityTitle:(NSString *)discoverabilityTitle NS_AVAILABLE_IOS(9_0);

@end

#pragma mark - 响应快捷命令

@interface UIResponder (UIResponderKeyCommands)
/** 返回快捷键命令数组 */
@property (nullable,nonatomic,readonly) NSArray<UIKeyCommand *> *keyCommands NS_AVAILABLE_IOS(7_0);
@end

@class UIInputViewController;
@class UITextInputMode;
@class UITextInputAssistantItem;

#pragma mark - 输入视图

@interface UIResponder (UIResponderInputViewAdditions)

/** 键盘输入视图(系统默认的,可以自定义) */
@property (nullable, nonatomic, readonly, strong) __kindof UIView *inputView NS_AVAILABLE_IOS(3_2);
/** 弹出键盘时附带的视图 */
@property (nullable, nonatomic, readonly, strong) __kindof UIView *inputAccessoryView NS_AVAILABLE_IOS(3_2);

/** 输入助手配置键盘的快捷方式栏时使用 */
@property (nonnull, nonatomic, readonly, strong) UITextInputAssistantItem *inputAssistantItem NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

/** 键盘输入视图控制器 */
@property (nullable, nonatomic, readonly, strong) UIInputViewController *inputViewController NS_AVAILABLE_IOS(8_0);
/** 弹出键盘时附带的视图的视图控制器 */
@property (nullable, nonatomic, readonly, strong) UIInputViewController *inputAccessoryViewController NS_AVAILABLE_IOS(8_0);

/** 文本输入模式 */
@property (nullable, nonatomic, readonly, strong) UITextInputMode *textInputMode NS_AVAILABLE_IOS(7_0);

/** 文本输入模式标识 */
@property (nullable, nonatomic, readonly, strong) NSString *textInputContextIdentifier NS_AVAILABLE_IOS(7_0);
/** 根据设置的标识清除指定的文本输入模式 */
+ (void)clearTextInputContextIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(7_0);

/** 重新刷新键盘输入视图 */
- (void)reloadInputViews NS_AVAILABLE_IOS(3_2);

@end

/** 特殊快捷辅键定义 */
UIKIT_EXTERN NSString *const UIKeyInputUpArrow         NS_AVAILABLE_IOS(7_0); //!< 上按键.
UIKIT_EXTERN NSString *const UIKeyInputDownArrow       NS_AVAILABLE_IOS(7_0); //!< 下按键.
UIKIT_EXTERN NSString *const UIKeyInputLeftArrow       NS_AVAILABLE_IOS(7_0); //!< 左按键.
UIKIT_EXTERN NSString *const UIKeyInputRightArrow      NS_AVAILABLE_IOS(7_0); //!< 右按键
UIKIT_EXTERN NSString *const UIKeyInputEscape          NS_AVAILABLE_IOS(7_0); //!< Esc按键.

#pragma mark - 响应者活动

@interface UIResponder (ActivityContinuation)
/** 用户活动 */
@property (nullable, nonatomic, strong) NSUserActivity *userActivity NS_AVAILABLE_IOS(8_0);
/** 更新用户活动 */
- (void)updateUserActivityState:(NSUserActivity *)activity NS_AVAILABLE_IOS(8_0);
/** 恢复用户活动 */
- (void)restoreUserActivityState:(NSUserActivity *)activity NS_AVAILABLE_IOS(8_0);
@end

NS_ASSUME_NONNULL_END


