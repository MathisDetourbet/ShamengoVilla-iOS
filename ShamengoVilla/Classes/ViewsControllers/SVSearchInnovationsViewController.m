//
//  SVSearchInnovationsViewController.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 21/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVSearchInnovationsViewController.h"
#import "SVInnovationsManager.h"

@interface SVSearchInnovationsViewController ()

@end

@implementation SVSearchInnovationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SVInnovationsManager *manager = [SVInnovationsManager sharedManager];
    if (manager.innovationsList == nil) {
        [manager loadInnovations];
    }
    self.innovationsList = [[NSMutableArray alloc] initWithArray:manager.innovationsList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
