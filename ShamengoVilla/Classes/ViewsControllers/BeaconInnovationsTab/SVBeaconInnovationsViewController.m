//
//  SVBeaconInnovationsViewController.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 21/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVBeaconInnovationsViewController.h"
#import "SVInnovationsManager.h"
#import "SVInnovation.h"
#import <EstimoteSDK/EstimoteSDK.h>

@interface SVBeaconInnovationsViewController () <ESTBeaconManagerDelegate>

@property (nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic) CLBeaconRegion *beaconRegion;

- (void)initBeaconManager;
- (NSArray *)innovationsNearBeacon:(CLBeacon *)beacon;

@end

@implementation SVBeaconInnovationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.innovationsList = nil;
    [self.tableView reloadData];
    
    [self initBeaconManager];
    [self buildUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
}

- (void)buildUI {
    
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                             target:self
                                                                             action:@selector(refreshInnovationsList)];
    refresh.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = refresh;
}


#pragma mark - ESTBeaconManager Methods

- (void)initBeaconManager {
    
    // Initialization Beacon Manager
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[CLBeaconRegion alloc]
                        initWithProximityUUID:[[NSUUID alloc]
                        initWithUUIDString:@"85FC11DD-4CCA-4B27-AFB3-876854BB5C3B"]
                        identifier:@"ranged region"];
    
    // NSLocationAlwaysUsageDescription in Info.plist
    // [self.beaconManager requestAlwaysAuthorization];
    // NSLocationWhenInUseUsageDescription in Info.plist
    [self.beaconManager requestWhenInUseAuthorization];
    
//    [[UIApplication sharedApplication]
//     registerUserNotificationSettings:[UIUserNotificationSettings
//                                       settingsForTypes:UIUserNotificationTypeAlert
//                                       categories:nil]];
}

- (NSArray *)innovationsNearBeacon:(CLBeacon *)beacon {
    NSString *beaconMajor = [NSString stringWithFormat:@"%@", beacon.major];
    NSMutableArray *innovationsNearBeacon = [NSMutableArray new];
    NSArray *innovationsJSON = [NSArray arrayWithArray:[[SVInnovationsManager sharedManager] innovationsList]];
    
    for (SVInnovation *innov in innovationsJSON) {
        if ([innov.beaconMajor isEqualToString:beaconMajor]) {
            [innovationsNearBeacon addObject:innov];
        }
    }
    
    return [NSArray arrayWithArray:innovationsNearBeacon];
}


#pragma mark - ESTBeaconManager Delegate

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *nearestBeacon = beacons.firstObject;
    
    if (nearestBeacon) {
        self.innovationsList = [NSMutableArray arrayWithArray:[self innovationsNearBeacon:nearestBeacon]];
        [self.tableView reloadData];
        
        NSLog(@"innovations detected : %@", self.innovationsList);
    }
}

//- (void)beaconManager:(id)manager didDetermineState:(CLRegionState)state forRegion:(CLBeaconRegion *)region {
//    [self.beaconManager requestStateForRegion:region];
//}
//
//- (void)beaconManager:(id)manager didEnterRegion:(CLBeaconRegion *)region {
//    
//    UILocalNotification *notification = [UILocalNotification new];
//    notification.alertBody =
//    @"Your gate closes in 47 minutes. "
//    "Current security wait time is 15 minutes, "
//    "and it's a 5 minute walk from security to the gate. "
//    "Looks like you've got plenty of time!";
//    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
//}

- (void)refreshInnovationsList
{
    
}

@end
