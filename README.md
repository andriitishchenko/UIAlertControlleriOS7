# UIAlertControlleriOS7

> TEXTFIELDS NOT WORKS!!
> NOTHING WORKS!!



>  How to use:
> ========================
> 1  register class:
> ========================
    #import "UIAlertViewController.h"

```
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIAlertControllerIOS7Registration();
    return YES;
 }

```


> ========================
>  2 call UIAlertController:
> ========================


```     
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
 
```

