//
//  UIAlertViewController.h
//  
//
//  Created by Andrii Tishchenko on 13.08.15.
//  Copyright (c) 2015 ignite. All rights reserved.



/*
 
 UIAlertViewControllerStyleActionSheet NOT WORKS!!
 TEXTFIELDS NOT WORKS!!
 NOTHING WORKS!!

 
 How to use:
 ========================
 1  register class:
 ========================
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIAlertControllerIOS7Registration();
    return YES;
 }
 ========================
 2 call UIAlertController:
 ========================

    UIAlertController *alertController = [UIAlertControllerIOS7
     alertControllerWithTitle: @"Title Demo "
     message:@"You have incoming message, please pay $ :)"
     preferredStyle:UIAlertControllerStyleAlert];
     
     
     UIAlertAction *okAction = [UIAlertActionIOS7
     actionWithTitle:@"OK"
     style:UIAlertActionStyleDefault
     handler:^(UIAlertAction *action)
     {
        NSLog(@"Ok");
     }];
 
     UIAlertAction *noAction = [UIAlertActionIOS7
     actionWithTitle:@"No"
     style:UIAlertActionStyleCancel
     handler:^(UIAlertAction *action)
     {
        NSLog(@"No");
     }];
 
     UIAlertAction *boomAction = [UIAlertActionIOS7
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
#import <UIKit/UIViewController.h>
#import <UIKit/UIKit.h>
void UIAlertControllerIOS7Registration();

extern Class  UIAlertControllerIOS7;
extern Class  UIAlertActionIOS7;

typedef NS_ENUM(NSInteger, UIAlertViewActionStyle) {
    UIAlertViewActionStyleDefault = 0,
    UIAlertViewActionStyleCancel,
    UIAlertViewActionStyleDestructive
};

typedef NS_ENUM(NSInteger, UIAlertViewControllerStyle) {
    UIAlertViewControllerStyleActionSheet = 0,
    UIAlertViewControllerStyleAlert
};



//__attribute__((objc_runtime_name("UIAlertAction")))
@interface UIAlertViewAction : NSObject <NSCopying>
    @property (nonatomic, copy) NSString *title;
    @property (nonatomic) UIAlertViewActionStyle style;
    @property (nonatomic, getter=isEnabled) BOOL enabled;
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertViewActionStyle)style handler:(void (^)(UIAlertViewAction *action))handler;
+ (Class)getClassInst;
@end



//__attribute__((objc_runtime_name("UIAlertController")))
@interface UIAlertViewController : UIViewController
@property (nonatomic, readonly) NSArray *textFields;
@property (nonatomic, readonly) UIAlertViewControllerStyle preferredStyle;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertViewControllerStyle)preferredStyle;
- (void)addAction:(UIAlertViewAction *)action;
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;
+ (Class)getClassInst;
@end

#endif

