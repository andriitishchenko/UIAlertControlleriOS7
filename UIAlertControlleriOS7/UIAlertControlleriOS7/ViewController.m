//
//  ViewController.m
//  UIAlertControlleriOS7
//
//  Created by Andrii Tishchenko on 19.08.15.
//  Copyright (c) 2015 Andrii Tishchenko. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertViewController.h"

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
}
@end
