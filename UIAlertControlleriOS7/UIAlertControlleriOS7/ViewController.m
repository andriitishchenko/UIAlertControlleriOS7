//
//  ViewController.m
//  UIAlertControlleriOS7
//
//  Created by Andrii Tishchenko on 19.08.15.
//  Copyright (c) 2015 Andrii Tishchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)showAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAction:(id)sender {
    
    
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
}
@end
