//
//  BlockAlertView.h
//  BlockAlertViewDemo
//
//  Created by fanpyi on 14-7-27.
//  Copyright (c) 2014年 fanpyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockAlertView : UIAlertView<UIAlertViewDelegate>

//UIAlertViewStyleDefault样式
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)())confirmBlock;

//add By 老陶 2015-03-16
//UIAlertViewStylePlainTextInput样式
+ (void)alertPlainTextWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)(NSString *plainText))confirmBlock;

//add By 老陶 2015-03-31
//文本框右边带有按钮的alertView
+ (void)alertCustomPlainTextWithTitle:(NSString *)title message:(NSString *)message
                            placeHold:(NSString *)placeHold
                          buttonTitle:(NSString *)buttonTitle target:(id)target action:(SEL)sel
                cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)(NSString *plainText))confirmBlock;


//add By 老陶 2015-03-27
//UIAlertViewStyleLoginAndPasswordInput样式
//+ (void)alertLoginAndPasswordInputWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)(NSString *login,NSString *password))confirmBlock;


@end
