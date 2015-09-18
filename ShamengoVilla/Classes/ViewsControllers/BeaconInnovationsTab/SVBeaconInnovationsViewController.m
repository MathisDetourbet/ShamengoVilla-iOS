//
//  SVBeaconInnovationsViewController.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 21/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVBeaconInnovationsViewController.h"
#import "SVInnovationsManager.h"

@interface SVBeaconInnovationsViewController ()

@end

@implementation SVBeaconInnovationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshInnovationsList)];
    refresh.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = refresh;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshInnovationsList
{
    
}

@end
