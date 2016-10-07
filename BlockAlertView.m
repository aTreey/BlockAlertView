//
//  BlockAlertView.m
//  BlockAlertViewDemo
//
//  Created by fanpyi on 14-7-27.
//  Copyright (c) 2014年 fanpyi. All rights reserved.
//

#import "BlockAlertView.h"
@interface BlockAlertView()

@property(copy,nonatomic)void (^cancelClicked)();

//@property(copy,nonatomic)void (^confirmClicked)();

@property (copy, nonatomic)void (^confirmClicked)(NSString *plainText);

@end
@implementation BlockAlertView

//change By 老陶 2015-03-16 16:35
//增加plainText的返回值
-(id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)())confirmBlock{
    self=[super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:confirmTitle, nil];
    if (self) {
        _cancelClicked=[cancelblock copy];
        _confirmClicked=[confirmBlock copy];
    }
    return self;
}

+(void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)())confirmBlock{
    BlockAlertView *alert=[[BlockAlertView alloc]initWithTitle:title message:message cancelButtonWithTitle:cancelTitle cancelBlock:cancelblock confirmButtonWithTitle:confirmTitle confrimBlock:confirmBlock];
    [alert show];
}

//add By 老陶 2015-03-16
//UIAlertViewStylePlainTextInput样式
+ (void)alertPlainTextWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)(NSString *plainText))confirmBlock {
    BlockAlertView *alert=[[BlockAlertView alloc]initWithTitle:title message:message cancelButtonWithTitle:cancelTitle cancelBlock:cancelblock confirmButtonWithTitle:confirmTitle confrimBlock:confirmBlock];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

//add By 老陶 2015-03-31
//文本框右边带有按钮的alertView
+ (void)alertCustomPlainTextWithTitle:(NSString *)title message:(NSString *)message
                            placeHold:(NSString *)placeHold
                          buttonTitle:(NSString *)buttonTitle target:(id)target action:(SEL)sel
                cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)(NSString *plainText))confirmBlock {
    BlockAlertView *alert=[[BlockAlertView alloc]initWithTitle:title message:message cancelButtonWithTitle:cancelTitle cancelBlock:cancelblock confirmButtonWithTitle:confirmTitle confrimBlock:confirmBlock];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    UITextField *textField = [alert textFieldAtIndex:0];
    textField.placeholder = placeHold;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 20);
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:85/255.0 green:185/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    CGRect rect = textField.frame;
    rect.size.height = 50;
    textField.frame = rect;
    textField.rightView = button;
    textField.rightViewMode = UITextFieldViewModeAlways;
    [alert show];
}

/*
//add By 老陶 2015-03-27
//UIAlertViewStyleLoginAndPasswordInput样式
+ (void)alertLoginAndPasswordInputWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)(NSString *login,NSString *password))confirmBlock {
    BlockAlertView *alert=[[BlockAlertView alloc]initWithTitle:title message:message cancelButtonWithTitle:cancelTitle cancelBlock:cancelblock confirmButtonWithTitle:confirmTitle confrimBlock:confirmBlock];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
}
 */

#pragma -mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //change By 老陶 v1.2.4(douxing) 2014-10-30 14:23
    //如果只显示一个button，因判断buttonIndex的数值，不准确，所以更改为直接判断是否是cancelButton
    if (alertView.cancelButtonIndex != buttonIndex) {
        if (self.confirmClicked) {
            if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
                self.confirmClicked([alertView textFieldAtIndex:0].text);
            }else {
                self.confirmClicked(@"");
            }
        }
    }else {
        if (self.cancelClicked) {
            self.cancelClicked();
        }
    }
}
@end
