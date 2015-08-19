//
//  UIAlertViewController.m
//  
//
//  Created by Andrii Tishchenko on 13.08.15.
//  Copyright (c) 2015 ignite. All rights reserved.
//


#import <objc/runtime.h>

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "UIAlertViewController.h"

#import "AppDelegate.h"

 Class uiAlertController;
 Class uiAlertAction;

#define blueDeffButtonColor [UIColor colorWithRed:18.0/255.0 green:114.0/255.0 blue:251.0/255.0 alpha:1.0];
#define redDeffButtonColor [UIColor colorWithRed:255.0/255.0 green:50.0/255.0 blue:37.0/255.0 alpha:1.0];

static NSTimeInterval const AVCAnimatedTransitionDuration = 0.15f;

@interface AVCAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
    @property (nonatomic) BOOL reverse;
@end

@interface AVCTransitioningDelegate : NSObject<UIViewControllerTransitioningDelegate>
    @property (nonatomic) BOOL presenting;
@end

@implementation AVCAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    if (self.reverse) {
        [container insertSubview:toViewController.view belowSubview:fromViewController.view];
    }
    else {
        toViewController.view.transform = CGAffineTransformMakeScale(0, 0);
        [container addSubview:toViewController.view];
    }
    
    [UIView animateKeyframesWithDuration:AVCAnimatedTransitionDuration delay:0 options:0 animations:^{
        if (self.reverse) {
            fromViewController.view.transform = CGAffineTransformMakeScale(0, 0);
        }
        else {
            toViewController.view.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return AVCAnimatedTransitionDuration;
}

@end


@implementation AVCTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    AVCAnimatedTransitioning *transitioning = [AVCAnimatedTransitioning new];
    return transitioning;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    AVCAnimatedTransitioning *transitioning = [AVCAnimatedTransitioning new];
    transitioning.reverse = YES;
    return transitioning;
}

@end

//=========================

typedef NS_ENUM(NSInteger, UIAlertViewButtonsStyle) {
    UIAlertViewButtonsStyleDefault = 0,
    UIAlertViewButtonsStyleHorizontal,
    UIAlertViewButtonsStyleVertical
};

@interface UIAlertViewAction()
@property (nonatomic, copy) void (^__strong handler)(UIAlertViewAction *__strong);
@end

@implementation UIAlertViewAction
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertViewActionStyle)style handler:(void (^)(UIAlertViewAction *action))handler{
    UIAlertViewAction*va = [UIAlertViewAction new];
    va.title = title;
    va.handler = handler;
    va.style = style;
    return va;
}

@end

///========================
@interface UIAlertViewController()
    @property (nonatomic, copy) NSString *title;
    @property (nonatomic, copy) NSString *message;

    @property (strong,nonatomic) NSMutableArray *actions;
    @property (strong,nonatomic) NSMutableArray *buttons;
    @property (strong,nonatomic) UIView*contentView;
    @property (strong,nonatomic)  UILabel*labelMessage;
    @property (strong,nonatomic) UILabel*labelTitle;
    @property(nonatomic, assign) UIModalPresentationStyle restoreModalPresentationStyle;
    @property (nonatomic) BOOL isPresenting;

    @property (nonatomic) AVCTransitioningDelegate* transitionDelegate;

@end

@implementation UIAlertViewController

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertViewControllerStyle)preferredStyle{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIAlertViewController* vc =[UIAlertViewController new];
    [vc setModalPresentationStyle: UIModalPresentationCustom];
    vc.modalPresentationCapturesStatusBarAppearance = YES;

    vc.restoreModalPresentationStyle = appDelegate.window.rootViewController.modalPresentationStyle;
    appDelegate.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    vc.transitioningDelegate = vc.transitionDelegate;
    
    
    vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4];
    vc.title = title;
    vc.message = message;
    return vc;
}


+(void)RegisterClass{
    if (uiAlertController) {
        return;
    }
    
    if(![UIAlertController class]){
        Class alrt0 = objc_allocateClassPair([UIAlertViewAction class], "UIAlertAction", 0);
        objc_registerClassPair(alrt0);
        
        Class alrt1 = objc_allocateClassPair([UIAlertViewController class], "UIAlertController", 0);
        objc_registerClassPair(alrt1);
    }
    uiAlertController = NSClassFromString(@"UIAlertController");
    uiAlertAction = NSClassFromString(@"UIAlertAction");
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler
{
    NSLog(@"addTextFieldWithConfigurationHandler not implemented...YET");
}

- (void)addAction:(UIAlertViewAction *)action{
    if (!action) {
        return;
    }
    if (!self.actions) {
        self.actions = [NSMutableArray new];
    }
    [self.actions addObject:action];
}

-(id)init
{
    if(self = [super init])
    {
        self.transitionDelegate = [AVCTransitioningDelegate new];
        self.contentView = [UIView new];
        self.contentView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
        self.contentView.alpha = 0.9;
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.shadowOffset = CGSizeMake(-2, 7);
        
        self.labelTitle = [[UILabel alloc] init];
        self.labelTitle.text = self.title;
        self.labelTitle.numberOfLines = 0;
        self.labelTitle.textAlignment = NSTextAlignmentCenter;
        self.labelTitle.font = [UIFont boldSystemFontOfSize:17.0f];

        
        self.labelMessage = [[UILabel alloc] init];
        self.labelMessage.text = self.message;
        self.labelMessage.numberOfLines = 0;
        self.labelMessage.textAlignment = NSTextAlignmentCenter;
        self.labelMessage.font = [UIFont systemFontOfSize:13.0f];

        
        [self.labelTitle setTranslatesAutoresizingMaskIntoConstraints: NO];
        [self.labelMessage setTranslatesAutoresizingMaskIntoConstraints: NO];
        [self.contentView setTranslatesAutoresizingMaskIntoConstraints: NO];
    }
    return self;
}


-(IBAction)buttonPressed:(id)sender{
    UIButton *button = (UIButton *)sender;
    NSInteger index = button.tag;
    if (self.actions.count>index) {
        UIAlertViewAction*action = (UIAlertViewAction*)self.actions[index];
        action.handler(nil);
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.labelMessage];
    [self.view addSubview:self.contentView];
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}
//
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.labelTitle.text = self.title;
    self.labelMessage.text = self.message;
    
    
    
    
    NSInteger btnIndex = 0;
    self.buttons = [NSMutableArray new];
    for (UIAlertViewAction* action in self.actions) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = btnIndex;
        [button setTitle:action.title forState:UIControlStateNormal];
        UIColor*titleColor = blueDeffButtonColor;
        if (action.style == 1) {
            titleColor =  blueDeffButtonColor;
        }
        else if (action.style == 2) {
            titleColor =  redDeffButtonColor
        }
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        [button setTitle:action.title forState:UIControlStateNormal];
        if (action.style == 1) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        }
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.buttons addObject:button];
        btnIndex++;
    }

    UIAlertViewButtonsStyle displayHorizontaly = UIAlertViewButtonsStyleDefault;
    if (self.buttons.count == 2) {
        displayHorizontaly = UIAlertViewButtonsStyleHorizontal;
    }
    else if (self.buttons.count > 2) {
        displayHorizontaly = UIAlertViewButtonsStyleVertical;
    }
    
//    CGFloat

    
    NSDictionary *views =  NSDictionaryOfVariableBindings (_contentView,_labelTitle,_labelMessage);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0@900)-[_contentView(<=260)]-(0@900)-|"
                                                                      options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"V:|-(>=0@200)-[_contentView(<=380)]-(>=0@200)-|"
                                                                      options:kNilOptions metrics:nil views:views]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
//                               @"V:[_contentView(>=3)]"
//                                                                      options:kNilOptions metrics:nil views:views]];

    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f constant:0.f]
     ];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f constant:0.f]
     ];
    
    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_labelTitle]-10-|"
                                                                         options:kNilOptions metrics:nil views:views]];
    
    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_labelMessage]-10-|"
                                                                         options:kNilOptions metrics:nil views:views]];
    
    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                                  @"V:|-15-[_labelTitle(<=54@900)]-10-[_labelMessage(<=300)]-(>=5@400)-|"
                                                                         options:kNilOptions metrics:nil views:views]];
    
   
    
    NSInteger count = [self.buttons count];
    
    UIButton*prevButton;
    
    for (NSInteger i =0; i < count; i++) {
        UIButton*btn = self.buttons[i];
        NSDictionary *views =  NSDictionaryOfVariableBindings (_labelMessage,btn);
        if (prevButton) {
            views =  NSDictionaryOfVariableBindings (_labelMessage,btn,prevButton);
        }

        [self.contentView addSubview:btn];
        
        

        NSInteger width = 260;
        if (displayHorizontaly == UIAlertViewButtonsStyleHorizontal) {
            width = 260/2.0;
        }

        NSDictionary *metrics = @{@"width":@(width),@"height":@(50)};
        
        [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[btn(==width)]" options:kNilOptions metrics:metrics views:views]];
        [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_labelMessage]-(>=15)-[btn(==height)]"
                                                                             options:kNilOptions metrics:metrics views:views]];
        
        if (displayHorizontaly == UIAlertViewButtonsStyleVertical) {
            [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[btn]-0-|"
                                                                                 options:kNilOptions metrics:nil views:views]];
            if (i == 0) {
                [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[btn]-0-|"
                                                                                     options:kNilOptions metrics:nil views:views]];
            }
            else
            {
                [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[btn]-0-[prevButton]"
                                                                                     options:kNilOptions metrics:nil views:views]];
            }
            
        }
        else
        {
            
            if (i == 0) {
                [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[btn]"
                                                                                     options:kNilOptions metrics:nil views:views]];
                [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[btn]-(0@1000)-|" options:kNilOptions metrics:nil views:views]];
            }
            else
            {
                [_contentView addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:prevButton
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1.f constant:1.f]
                 ];
            }
            if (i == count-1) {
                [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[btn]-0-|"
                                                                                     options:kNilOptions metrics:nil views:views]];
            }
        }
        [btn layoutIfNeeded];
        
        
        CGRect rect = btn.bounds;
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:CGPointZero];
        [path addLineToPoint:(CGPoint){rect.size.width==0?rect.size.width:width, 1}];
        CAShapeLayer *borderLayer = [CAShapeLayer new];
        borderLayer.frame = rect;
        borderLayer.path  = path.CGPath;
        borderLayer.lineWidth   = 2 / [UIScreen mainScreen].scale;
        borderLayer.strokeColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:223.0/255.0 alpha:1].CGColor;
        borderLayer.fillColor   = [UIColor clearColor].CGColor;
        [btn.layer addSublayer:borderLayer];

        prevButton = btn;
    }
    

}

-(void)viewDidDisappear:(BOOL)animated {
    self.transitioningDelegate = nil;
    [super viewDidDisappear:animated];
}


- (BOOL)prefersStatusBarHidden {
    return [UIApplication sharedApplication].statusBarHidden;
}

- (void)viewWillDisappear:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController.modalPresentationStyle = self.restoreModalPresentationStyle;
}


@end


