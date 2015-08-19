//
//  ViewController.m
//  UIAlertControlleriOS7
//
//  Created by Andrii Tishchenko on 19.08.15.
//  Copyright (c) 2015 Andrii Tishchenko. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertViewController.h"

//extern Class uiAlertController;
//extern Class uiAlertAction;

//@class uiAlertController;
//@class uiAlertAction;

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
    
    
//    Class alertClass = NSClassFromString(@"UIAlertController");
//    Class actionClass = NSClassFromString(@"UIAlertAction");
    
    UIAlertController *alertController = [uiAlertController
                                          alertControllerWithTitle: @"Title Demo "
                                          message:@"You have incoming message, please pay $ :)"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [uiAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"Ok");
                               }];
    UIAlertAction *noAction = [uiAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"No");
                               }];
    UIAlertAction *boomAction = [uiAlertAction
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
