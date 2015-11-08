//
//  SVNavSChemeManager.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 18/09/2015.
//  Copyright © 2015 Efrei. All rights reserved.
//

#import "SVNavSChemeManager.h"
#import "SVAppDelegate.h"

@implementation SVNavSChemeManager

+ (id)manager
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)initRootViewController
{
    UIWindow * window = ((SVAppDelegate *)[[UIApplication sharedApplication] delegate]).window;
    window.rootViewController = [window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"idTabBarSV"];
}

- (void)changeRootViewController:(UIViewController *)viewController
{
    UIView *snapShot = [((SVAppDelegate *)([UIApplication sharedApplication].delegate)).window snapshotViewAfterScreenUpdates:YES];
    [viewController.view addSubview:snapShot];
    ((SVAppDelegate *)([UIApplication sharedApplication].delegate)).window.rootViewController = viewController;
    [snapShot removeFromSuperview];
}

@end
