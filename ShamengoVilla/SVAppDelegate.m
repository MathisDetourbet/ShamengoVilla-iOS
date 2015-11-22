//
//  AppDelegate.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 09/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVAppDelegate.h"
#import "SVConstants.h"
#import "SVInnovationsManager.h"
#import "SVNavSChemeManager.h"
#import <RZTransitions/RZTransitionsManager.h>
#import <RZTransitions/RZCardSlideAnimationController.h>
#import <RZTransitions/RZCirclePushAnimationController.h>
#import <RZZoomAlphaAnimationController.h>
#import <RZBaseSwipeInteractionController.h>

@interface SVAppDelegate ()

@end

@implementation SVAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Load innovations in the memory
    [[SVInnovationsManager sharedManager] loadInnovations];
    [[SVNavSChemeManager manager] initRootViewController];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults arrayForKey:kUserFavoritesArray]) {
        [userDefaults setObject:[NSArray array] forKey:kUserFavoritesArray];
        [userDefaults synchronize];
    }
    
    id<RZAnimationControllerProtocol> presentDismissAnimationController = [[RZZoomAlphaAnimationController alloc] init];
    id<RZAnimationControllerProtocol> pushPopAnimationController = [[RZCardSlideAnimationController alloc] init];
    [[RZTransitionsManager shared] setDefaultPresentDismissAnimationController:presentDismissAnimationController];
    [[RZTransitionsManager shared] setDefaultPushPopAnimationController:pushPopAnimationController];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.041 green:0.792 blue:0.403 alpha:0.815]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
