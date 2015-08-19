//
//  UIAlertViewController.h
//  
//
//  Created by Andrii Tishchenko on 13.08.15.
//  Copyright (c) 2015 ignite. All rights reserved.



/*
 
 
 TEXTFIELDS NOT WORKS!!
 autorotate NOT WORKS!!
 NOTHING WORKS!!

 
 How to use:
 ========================
 1  register class:
 ========================
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIAlertViewController RegisterClass];
    return YES;
 }
 ========================
 2 call UIAlertController:
 ========================
     Class alertClass = objc_getClass("UIAlertController");
     Class actionClass = objc_getClass("UIAlertAction");
     
     UIAlertController *alertController = [alertClass
     alertControllerWithTitle: @"Title Demo "
     message:@"You have incoming message, please pay $ :)"
     preferredStyle:UIAlertControllerStyleAlert];
     
     
     UIAlertAction *okAction = [actionClass
     actionWithTitle:@"OK"
     style:UIAlertActionStyleDefault
     handler:^(UIAlertAction *action)
     {
        NSLog(@"Ok");
     }];
 
     UIAlertAction *noAction = [actionClass
     actionWithTitle:@"No"
     style:UIAlertActionStyleCancel
     handler:^(UIAlertAction *action)
     {
        NSLog(@"No");
     }];
 
     UIAlertAction *boomAction = [actionClass
     actionWithTitle:@"BooM!"
     style:UIAlertActionStyleDestructive
     handler:^(UIAlertAction *action)
     {
        NSLog(@"BooM");
     }];
     
     [alertController addAction:okAction];
     [alertController addAction:noAction];
     [alertController addAction:boomAction];
     
     
     [self presentViewController:alertController animated:YES completion:NULL];
 
*/


#ifndef lottomobile_Header_h
#define lottomobile_Header_h
//#define kUIAlertControllerClassName @"UIAlertController"

#import <UIKit/UIViewController.h>



typedef NS_ENUM(NSInteger, UIAlertViewActionStyle) {
    UIAlertViewActionStyleDefault = 0,
    UIAlertViewActionStyleCancel,
    UIAlertViewActionStyleDestructive
};

typedef NS_ENUM(NSInteger, UIAlertViewControllerStyle) {
    UIAlertViewControllerStyleActionSheet = 0,
    UIAlertViewControllerStyleAlert
};

@interface UIAlertViewAction : NSObject <NSCopying>
    @property (nonatomic, copy) NSString *title;
    @property (nonatomic) UIAlertViewActionStyle style;
    @property (nonatomic, getter=isEnabled) BOOL enabled;
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertViewActionStyle)style handler:(void (^)(UIAlertViewAction *action))handler;
@end

@interface UIAlertViewController : UIViewController
@property (nonatomic, readonly) NSArray *textFields;
@property (nonatomic, readonly) UIAlertViewControllerStyle preferredStyle;

+ (void)RegisterClass;
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertViewControllerStyle)preferredStyle;
- (void)addAction:(UIAlertViewAction *)action;
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;





@end


#endif