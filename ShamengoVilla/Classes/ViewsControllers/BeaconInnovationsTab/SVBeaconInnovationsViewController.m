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
#import <CoreBluetooth/CoreBluetooth.h>

@interface SVBeaconInnovationsViewController () <ESTBeaconManagerDelegate, CBCentralManagerDelegate, UIAlertViewDelegate>

@property (nonatomic) ESTBeaconManager      *beaconManager;
@property (nonatomic) CLBeaconRegion        *beaconRegion;
@property (nonatomic) CBCentralManager      *bluetoothManager;

@property (weak, nonatomic) IBOutlet UIView *noBeaconView;

- (void)initBeaconManager;
- (NSArray *)innovationsNearBeacon:(CLBeacon *)beacon;

@end

@implementation SVBeaconInnovationsViewController


/*********************************************************************/
#pragma mark - Life view cycle
/*********************************************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self buildUI];
    
    self.resultInnovList = nil;
    [self.tableView reloadData];
    self.tableView.hidden = YES;
    self.noBeaconView.hidden = NO;
    
    [self detectBluetooth];
    [self initBeaconManager];
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
//    
//    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
//                                                                             target:self
//                                                                             action:@selector(refreshInnovationsList)];
//    refresh.tintColor = [UIColor blackColor];
//    self.navigationController.navigationBar.topItem.rightBarButtonItem = refresh;
}

//- (void)refreshInnovationsList {
//    
//}


/*********************************************************************/
#pragma mark - ESTBeaconManager Methods
/*********************************************************************/

- (void)initBeaconManager {
    
    // Initialization Beacon Manager
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc]
                                                   initWithUUIDString:@"85FC11DD-4CCA-4B27-AFB3-876854BB5C3B"]
                                                           identifier:@"ranged region"];
    [self.beaconManager requestWhenInUseAuthorization];
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


/*********************************************************************/
#pragma mark - ESTBeaconManager Delegate
/*********************************************************************/

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    
    CLBeacon *nearestBeacon = beacons.firstObject;
    
    if (nearestBeacon) {
        NSArray *innovBeaconList = [self innovationsNearBeacon:nearestBeacon];
        NSArray *innovListBefore = self.resultInnovList;
        
        if (!innovListBefore && ([innovBeaconList count] > 0)) {
            self.resultInnovList = innovBeaconList;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            
            self.noBeaconView.alpha = 1.f;
            
            [UIView animateWithDuration:1.f animations:^{
                self.noBeaconView.alpha = 0.f;
                
            } completion:^(BOOL finished) {
                if (finished) {
                    self.noBeaconView.hidden = YES;
                    self.tableView.hidden = NO;
                }
            }];
        }
        
        NSSet *setNow = [NSSet setWithArray:innovBeaconList];
        NSSet *setBefore = [NSSet setWithArray:innovListBefore];
        
        if ([setNow isEqualToSet:setBefore]) {
            return;
            
        } else {
            self.resultInnovList = innovBeaconList;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            
            self.noBeaconView.alpha = 1.f;
            
            [UIView animateWithDuration:1.f animations:^{
                self.noBeaconView.alpha = 0.f;
                
            } completion:^(BOOL finished) {
                if (finished) {
                    self.noBeaconView.hidden = YES;
                    self.tableView.hidden = NO;
                }
            }];
        }
        
    } else {
        self.tableView.hidden = YES;
        
        [UIView animateWithDuration:1.f animations:^{
            self.noBeaconView.alpha = 1.f;
            
        } completion:^(BOOL finished) {
            if (finished) {
                self.noBeaconView.hidden = NO;
            }
        }];
    }
}

- (void)beaconManager:(id)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    NSLog(@"Echec de la détection de Beacon... Autorisation requise");
}


/*********************************************************************/
#pragma mark - Bluetooth Detection Methods
/*********************************************************************/

- (void)detectBluetooth {
    
    if (!self.bluetoothManager)
    {
        // Put on main queue so we can call UIAlertView from delegate callbacks.
        self.bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    }
    
    [self centralManagerDidUpdateState:self.bluetoothManager]; // Show initial state
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    NSString *stateString = nil;
    switch (self.bluetoothManager.state)
    {
        case CBCentralManagerStateResetting: stateString = @"The connection with the system service was momentarily lost, update imminent."; break;
        case CBCentralManagerStateUnsupported: stateString = @"The platform doesn't support Bluetooth Low Energy."; break;
        case CBCentralManagerStateUnauthorized: stateString = @"The app is not authorized to use Bluetooth Low Energy."; break;
        case CBCentralManagerStatePoweredOff: stateString = @"Bluetooth is currently powered off."; break;
        case CBCentralManagerStatePoweredOn: stateString = @"Bluetooth is currently powered on and available to use."; break;
        default: stateString = @"State unknown, update imminent."; break;
    }
}

@end
