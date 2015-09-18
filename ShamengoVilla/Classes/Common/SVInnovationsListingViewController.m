//
//  SVInnovationsListingViewController.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 21/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVInnovationsListingViewController.h"
#import "SVInnovationsManager.h"
#import "SVInnovationTableViewCell.h"
#import "SVInnovation.h"
#import "SVInnovationCardViewController.h"

@interface SVInnovationsListingViewController ()

@end

@implementation SVInnovationsListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadJSONData];
    NSLog(@"nav : %@", self.navigationController);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Load JSON Data

- (void)loadJSONData
{
    SVInnovationsManager *manager = [SVInnovationsManager sharedManager];
    if (manager.innovationsList == nil) {
        [manager loadInnovations];
    }
    self.innovationsList = [[NSMutableArray alloc] initWithArray:manager.innovationsList];
    
    [self.tableView reloadData];
}


#pragma mark - UITableView Datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.innovationsList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVInnovationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idInnovationCell"];
    if (!cell) {
        cell = [[SVInnovationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"idInnovationCell"];
    }
    [cell setNeedsLayout];
    [cell layoutSubviews];
    
    [cell displayInnovation:((SVInnovation *)[self.innovationsList objectAtIndex:indexPath.row]) forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVInnovation *innovToPresent = [self.innovationsList objectAtIndex:indexPath.row];
    SVInnovationCardViewController *innovCard = [[SVInnovationCardViewController alloc] initWithInnovation:innovToPresent];
    [self.navigationController pushViewController:innovCard animated:YES];
}

@end
