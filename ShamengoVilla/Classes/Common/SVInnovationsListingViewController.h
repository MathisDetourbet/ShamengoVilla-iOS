//
//  SVInnovationsListingViewController.h
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 21/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVInnovationsListingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *resultInnovList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)loadJSONData;
- (void)hideTabBar;

@end
