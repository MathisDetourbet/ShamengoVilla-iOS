//
//  SVSearchInnovationsViewController.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 21/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVSearchInnovationsViewController.h"
#import "SVInnovationsManager.h"
#import "SVInnovation.h"

@interface SVSearchInnovationsViewController ()

@property (strong, nonatomic) NSString *searchName;

@end

@implementation SVSearchInnovationsViewController

#pragma mark - Life view cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                               target:self
                               action:@selector(showSearch)];
    
    search.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = search;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSearch
{
    self.navigationController.navigationBar.topItem.rightBarButtonItem = nil;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    self.navigationController.navigationBar.topItem.titleView = searchBar;
    searchBar.tintColor = [UIColor grayColor];
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    searchBar.placeholder = @"Numéro, pionnier, innovation";
    [searchBar becomeFirstResponder];
}

- (void)dismissSearchBar
{
    self.navigationController.navigationBar.topItem.titleView = nil;
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                               target:self
                               action:@selector(showSearch)];
    
    self.navigationController.navigationBar.topItem.rightBarButtonItem = search;
    
    [self loadJSONData];
}


#pragma mark - Search Items Method

- (void)loadSearch {
    
    NSMutableArray *searchList = [[NSMutableArray alloc] init];
    NSInteger innovNumber = [self.searchName integerValue];
    
    if (innovNumber != 0) {
        
        for (SVInnovation *innovation in self.innovationsList) {
            
            if (innovation.innovationId == innovNumber) {
                [searchList addObject:innovation];
                
                if ([searchList count] > 0) {
                    self.innovationsList = searchList;
                    
                } else {
                    [self.innovationsList removeAllObjects];
                }
                
                [self.tableView reloadData];
                
                return;
            }
        }
    }
    
    for (SVInnovation *innovation in self.innovationsList) {
        
        if ([innovation.innovationName caseInsensitiveCompare:self.searchName] == NSOrderedSame) {
            [searchList addObject:innovation];
        }
        
        [innovation.innovationName containsString:@""];
    }
    
    for (SVInnovation *innovation in self.innovationsList) {
        
        if ([innovation.pionnerName caseInsensitiveCompare:self.searchName] == NSOrderedSame) {
            [searchList addObject:innovation];
        }
    }
    
    if ([searchList count] > 0) {
        self.innovationsList = searchList;
        
    } else {
        [self.innovationsList removeAllObjects];
    }
    
    [self.tableView reloadData];
}


#pragma mark - SearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchName = searchBar.text;
    [self loadSearch];
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self dismissSearchBar];
}


@end
