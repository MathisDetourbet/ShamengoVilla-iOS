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
#import "SVSearchInnovationsViewController.h"

#import <RZTransitions/RZTransitionsManager.h>

@interface SVInnovationsListingViewController ()

@property (strong, nonatomic) UIScrollView  *scrollView;
@property (assign, nonatomic) CGRect        tabBarOriginalFrame;
@property (assign, nonatomic) CGFloat       startingOffsetY;
@property (assign, nonatomic) CGFloat       currentOffsetY;
@property (assign, nonatomic) BOOL          isHiddenTabBar;

- (void)showTabBar;
- (void)resetTabBar;

@end

@implementation SVInnovationsListingViewController


/*********************************************************************/
#pragma mark - Life view cycle
/*********************************************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadJSONData];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.tableView.rowHeight * [self.resultInnovList count]);
    self.tabBarOriginalFrame = self.tabBarController.tabBar.frame;
    
    [self.navigationController setDelegate:[RZTransitionsManager shared]];
    [self.tabBarController.tabBar setTranslucent:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    if (self.isHiddenTabBar) {
//        [self performSelector:@selector(showTabBar) withObject:nil afterDelay:0.2f];
//    }
}


/******************************************************************/
#pragma mark - Load JSON Data
/******************************************************************/

- (void)loadJSONData {
    
    SVInnovationsManager *manager = [SVInnovationsManager sharedManager];
    if (manager.innovationsList == nil) {
        [manager loadInnovations];
    }
    self.resultInnovList = [[NSArray alloc] initWithArray:manager.innovationsList];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}


/******************************************************************/
#pragma mark - UITableView Datasource methods
/******************************************************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resultInnovList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SVInnovationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idInnovationCell"];
    
    if (!cell) {
        cell = [[SVInnovationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"idInnovationCell"];
    }
    
    [cell setNeedsLayout];
    [cell layoutSubviews];
    [cell displayInnovation:((SVInnovation *)[self.resultInnovList objectAtIndex:indexPath.row]) forIndexPath:indexPath];
    
    return cell;
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
    
    self.isHiddenTabBar = NO;
    [self.navigationController pushViewController:innovCard animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/******************************************************************/
#pragma mark - Scroll View Delegate
/******************************************************************/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.startingOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height || scrollView.frame.size.height + 50 > scrollView.contentSize.height)
    {
        return;
    }
    
    if (scrollView.contentOffset.y < 0) {
        return;
    }
    
    if (scrollView.contentOffset.y > self.currentOffsetY) {
        if (!self.isHiddenTabBar) {
            [self hideTabBar];
            self.isHiddenTabBar = YES;
        }
        
    } else if (self.isHiddenTabBar && scrollView.contentOffset.y < self.currentOffsetY) {
        
        self.isHiddenTabBar = NO;
        [self showTabBar];
    }
    
    self.currentOffsetY = scrollView.contentOffset.y;
}


/*********************************************************************/
#pragma mark - Hide / show Tab Bar method
/*********************************************************************/

- (void)resetTabBar {
    
    if (self.tabBarController.tabBar.hidden) {
        [self showTabBar];
    }
}

- (void)hideTabBar {
    
    UITabBarController *tabVC = self.parentViewController.tabBarController;
    UIView *viewToResize = self.parentViewController.view;
    
    self.isHiddenTabBar = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = tabVC.tabBar.frame;
        frame.origin.y = [[UIScreen mainScreen] bounds].size.height;
        tabVC.tabBar.frame = frame;
        
        CGRect frameVC = viewToResize.frame;
        frameVC.size.height += 48;
        viewToResize.frame = frameVC;
        
    } completion:^(BOOL finished) {
        if (finished) {
            self.tabBarController.tabBar.hidden = YES;
        }
    }];
}

- (void)showTabBar {
    
    UITabBarController *tabVC = self.parentViewController.tabBarController;;
    UIView *viewToResize = self.parentViewController.view;
    
    self.isHiddenTabBar = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = tabVC.tabBar.frame;
        frame.origin.y = [[UIScreen mainScreen] bounds].size.height - frame.size.height;
        tabVC.tabBar.frame = frame;
        
    } completion:^(BOOL finished) {
        CGRect frameVC = viewToResize.frame;
        frameVC.size.height -= 48;
        viewToResize.frame = frameVC;
        
        if (finished) {
            CGRect frame = tabVC.tabBar.frame;
            frame.origin.y = [[UIScreen mainScreen] bounds].size.height - frame.size.height;
            tabVC.tabBar.frame = frame;
            self.tabBarController.tabBar.hidden = NO;
        }
    }];
}


@end
