//
//  AppDelegate.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 09/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVAppDelegate.h"
#import "SVInnovationsManager.h"
#import "SVNavSChemeManager.h"
#import <EstimoteSDK/EstimoteSDK.h>

@interface AppDelegate () <ESTBeaconManagerDelegate>

@property (nonatomic) ESTBeaconManager *beaconManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Load innovations in the memory
    [[SVInnovationsManager sharedManager] loadInnovations];
    [[SVNavSChemeManager manager] initRootViewController];
    
    // Initialization Beacon Manager
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    [self.beaconManager requestAlwaysAuthorization];
    
    [self.beaconManager startMonitoringForRegion:[[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"85FC11DD-4CCA-4B27-AFB3-876854BB5C3B"] major:1385 identifier:@"first beacon region"]];
    
    [[UIApplication sharedApplication]
     registerUserNotificationSettings:[UIUserNotificationSettings
                                       settingsForTypes:UIUserNotificationTypeAlert
                                       categories:nil]];
    
    return YES;
}

- (void)beaconManager:(id)manager didDetermineState:(CLRegionState)state forRegion:(CLBeaconRegion *)region {
    [self.beaconManager requestStateForRegion:region];
}

- (void)beaconManager:(id)manager didEnterRegion:(CLBeaconRegion *)region {
    
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody =
        @"Your gate closes in 47 minutes. "
        "Current security wait time is 15 minutes, "
        "and it's a 5 minute walk from security to the gate. "
        "Looks like you've got plenty of time!";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
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
