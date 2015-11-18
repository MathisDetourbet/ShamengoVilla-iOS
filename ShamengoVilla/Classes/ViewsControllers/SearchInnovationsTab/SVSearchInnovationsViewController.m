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
#import "SVInnovationCardViewController.h"
#import "SVConstants.h"

@interface SVSearchInnovationsViewController ()

@property (strong, nonatomic) NSString  *searchName;
@property (assign, nonatomic) BOOL      isHiddenSearchBar;
@property (assign, nonatomic) BOOL      isDisplayingFavorites;

@end

@implementation SVSearchInnovationsViewController


/*********************************************************************/
#pragma mark - Life view cycle
/*********************************************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Search button
    UIBarButtonItem *search = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                               target:self
                               action:@selector(showSearch)];
    search.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = search;
    
    // Favorites button
    UIBarButtonItem *favoritesButton = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                target:self
                                action:@selector(showFavorites)];
    favoritesButton.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.topItem.leftBarButtonItem = favoritesButton;
    
    self.isHiddenSearchBar = YES;
    self.isDisplayingFavorites = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*********************************************************************/
#pragma mark - Bar button item controls
/*********************************************************************/

- (void)showSearch {
    
    self.isHiddenSearchBar = NO;
    self.navigationController.navigationBar.topItem.leftBarButtonItem = nil;
    self.navigationController.navigationBar.topItem.rightBarButtonItem = nil;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    self.navigationController.navigationBar.topItem.titleView = searchBar;
    searchBar.tintColor = [UIColor grayColor];
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    searchBar.placeholder = @"Numéro, pionnier, innovation";
    [searchBar becomeFirstResponder];
}

- (void)dismissSearchBar {
    
    self.isHiddenSearchBar = YES;
    self.navigationController.navigationBar.topItem.titleView = nil;
    
    // Search button
    UIBarButtonItem *search = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                               target:self
                               action:@selector(showSearch)];
    
    self.navigationController.navigationBar.topItem.rightBarButtonItem = search;
    
    // Favorites button
    UIBarButtonItem *favoritesButton = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                        target:self
                                        action:@selector(showFavorites)];
    favoritesButton.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.topItem.leftBarButtonItem = favoritesButton;
    
    [self loadJSONData];
}

- (void)showFavorites {
    
    if (_isDisplayingFavorites) {
        self.resultInnovList = [[SVInnovationsManager sharedManager] innovationsList];
        _isDisplayingFavorites = NO;
        
    } else {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *favoritesDefaultList = [userDefaults arrayForKey:kUserFavoritesArray];
        NSArray *innovList = [NSArray arrayWithArray:[[SVInnovationsManager sharedManager] innovationsList]];
        NSMutableArray *favoritesInnovList = [NSMutableArray new];
        _isDisplayingFavorites = YES;
        
        for (SVInnovation *innov in innovList) {
            if ([favoritesDefaultList containsObject:[NSNumber numberWithInteger:innov.innovationId]]) {
                [favoritesInnovList addObject:innov];
            }
        }
        
        if ([favoritesInnovList count] > 0) {
            self.resultInnovList = favoritesInnovList;
            
        } else {
            self.resultInnovList = nil;
        }
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}


/*********************************************************************/
#pragma mark - Search Items Method
/*********************************************************************/

- (void)loadSearch {
    
    NSArray *innovList = [[SVInnovationsManager sharedManager] innovationsList];
    NSMutableArray *searchList = [[NSMutableArray alloc] init];
    NSInteger innovNumber = [self.searchName integerValue];
    
    if (innovNumber != 0) {
        
        for (SVInnovation *innovation in innovList) {
            
            if (innovation.innovationId == innovNumber) {
                [searchList addObject:innovation];
                
                if ([searchList count] > 0) {
                    self.resultInnovList = searchList;
                    
                } else {
                    self.resultInnovList = nil;
                }
                
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                
                return;
            }
        }
    }
    
    for (SVInnovation *innovation in innovList) {
        
        if ([innovation.innovationName localizedCaseInsensitiveContainsString:self.searchName]) {
            [searchList addObject:innovation];
        }
    }
    
    for (SVInnovation *innovation in innovList) {
        
        if ([innovation.pionnerName localizedCaseInsensitiveContainsString:self.searchName]) {
            [searchList addObject:innovation];
        }
    }
    
    if ([searchList count] > 0) {
        self.resultInnovList = searchList;
        
    } else {
        self.resultInnovList = nil;
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}


/*********************************************************************/
#pragma mark - SearchBar Delegate
/*********************************************************************/

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    self.searchName = searchBar.text;
    [self loadSearch];
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [self dismissSearchBar];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText isEqualToString:@""]) {
        [self loadJSONData];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        self.searchName = searchBar.text;
        [self loadSearch];
    }
}


/******************************************************************/
#pragma mark - UITableView Delegate
/******************************************************************/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SVInnovation *innovToPresent = [self.resultInnovList objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SVInnovationCardViewController *innovCard = [storyboard instantiateViewControllerWithIdentifier:@"idInnovCardViewController"];
    innovCard.hidesBottomBarWhenPushed = YES;
    innovCard.innovation = innovToPresent;
    
    [self.navigationController pushViewController:innovCard animated:YES];
    
    if (!self.isHiddenSearchBar) {
        [self dismissSearchBar];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
