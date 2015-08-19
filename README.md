# UIAlertControlleriOS7
UIAlertController iOS7

TEXTFIELDS NOT WORKS!!

autorotate NOT WORKS!!

NOTHING WORKS!!

 
 How to use:

 ========================

 1  register class:

 ========================
 ''''
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIAlertViewController RegisterClass];
    return YES;
 }
 ''''

 ========================

 2 call UIAlertController:

 ========================
 ''''
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
 
''''