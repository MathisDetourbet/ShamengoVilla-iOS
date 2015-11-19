//
//  SVInnovationCardViewController.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 14/09/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVInnovationCardViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SVAppDelegate.h"
#import "SVConstants.h"

@interface SVInnovationCardViewController ()

@property (strong, nonatomic) MPMoviePlayerController   *moviePlayer;
@property (strong, nonatomic) UITabBarController        *tabBarController;
@property (assign, nonatomic) BOOL                      starred;

@property (weak, nonatomic) IBOutlet UIImageView        *pionnerImageView;
@property (weak, nonatomic) IBOutlet UILabel            *pioneerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel            *innovDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel            *innovIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView        *innovCategoryImageView;
@property (weak, nonatomic) IBOutlet UILabel            *pioneerCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel            *innovTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton           *starButton;
@property (weak, nonatomic) IBOutlet UIView *bottomContainerView;
@property (weak, nonatomic) IBOutlet UIButton *playMovieButton;

- (void)buildUI;
- (void)doneButtonClicked:(NSNotification *)notification;
- (void)shareAction;

@end

@implementation SVInnovationCardViewController

- (id)initWithInnovation:(SVInnovation *)innov {
    
    self = [super init];
    
    if (self) {
        self.innovation = innov;
    }
    
    return self;
}


/*********************************************************************/
#pragma mark - Life view cycle
/*********************************************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *movieNameJSON = [[NSString alloc] initWithFormat:@"%@", self.innovation.innovationMoviePath];
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:movieNameJSON ofType:@""];
    
    if (!videoPath) {
        self.playMovieButton.hidden = YES;
    }
    
    self.starred = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
    self.tabBarController = (UITabBarController *)[[(SVAppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildUI {
    // ID
    self.innovIDLabel.text = [NSString stringWithFormat:@"%lu", (long)self.innovation.innovationId];
    self.innovIDLabel.font = [UIFont fontWithName:@"TitilliumText22L-Regular" size:17.f];
    
    // Title
    self.innovTitleLabel.text = [NSString stringWithFormat:@"%@", self.innovation.innovationName];
    self.innovTitleLabel.font = [UIFont fontWithName:@"TitilliumText22L-XBold" size:15.f];
    
    // Category
    self.innovCategoryImageView.image = [UIImage imageNamed:self.innovation.innovCategory];
    
    // Star
    NSArray *userFavoris = [[NSUserDefaults standardUserDefaults] arrayForKey:kUserFavoritesArray];
    
    if ([userFavoris containsObject:[NSNumber numberWithInteger:self.innovation.innovationId]]) {
        [self.starButton setImage:[UIImage imageNamed:@"StarOn"] forState:UIControlStateNormal];
        self.starred = YES;
    }
    
    // Description
    self.innovDescriptionLabel.numberOfLines = 0;
    self.innovDescriptionLabel.textAlignment = NSTextAlignmentJustified;
    NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
    paragraphStyles.firstLineHeadIndent = 1.f;
    paragraphStyles.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyles};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self.innovation.innovDescription] attributes: attributes];
    self.innovDescriptionLabel.attributedText = attributedString;
    self.innovDescriptionLabel.font = [UIFont fontWithName:@"TitilliumText22L-Regular" size:13.f];
    
    // Pioneer Name
    self.pioneerNameLabel.text = [NSString stringWithFormat:@"%@", self.innovation.pionnerName];
    self.pioneerNameLabel.font = [UIFont fontWithName:@"TitilliumText22L-XBold" size:15.f];
    //self.pioneerNameLabel.textColor = [self getColorNameForCategoryName:self.innovation.innovCategory];
    
    // Pioneer Country
    self.pioneerCountryLabel.text = [NSString stringWithFormat:@"%@", self.innovation.pionnerCountry];
    self.pioneerCountryLabel.font = [UIFont fontWithName:@"TitilliumText22L-Regular" size:13.f];
    
    // Pioneer Image
    self.pionnerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.innovation.pionnerImageName]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                           target:self
                                                                                           action:@selector(shareAction)];
}


/*********************************************************************/
#pragma mark - MPMoviePlayer Controls Methods
/*********************************************************************/

- (IBAction)playVideo:(UIButton *)sender {
    
    NSString *movieNameJSON = [[NSString alloc] initWithFormat:@"%@", self.innovation.innovationMoviePath];
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:movieNameJSON ofType:@""];
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    [self.moviePlayer setMovieSourceType:MPMovieSourceTypeFile];
    [self.moviePlayer setFullscreen:YES];
    [self.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
    [self.moviePlayer setShouldAutoplay:YES];
    [self.moviePlayer.view setFrame:self.view.frame];
    [self.moviePlayer.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.moviePlayer.view];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.moviePlayer.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.moviePlayer.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.moviePlayer.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.moviePlayer.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f]];

    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClicked:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}

- (void)doneButtonClicked:(NSNotification *)notification {
    
    NSNumber *reason = [notification.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    if ([reason intValue] == MPMovieFinishReasonUserExited) {
        [self.moviePlayer stop];
        [self.moviePlayer.view removeFromSuperview];
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:nil];
    }
}

- (IBAction)starButtonClicked:(UIButton *)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userFavoris = [NSMutableArray arrayWithArray:[userDefaults objectForKey:kUserFavoritesArray]];

    [sender setImage:[UIImage imageNamed:_starred ? @"StarOff" : @"StarOn"] forState:UIControlStateNormal];
    _starred ? [userFavoris removeObject:[NSNumber numberWithInteger:self.innovation.innovationId]] : [userFavoris addObject:[NSNumber numberWithInteger:self.innovation.innovationId]];
    _starred = !_starred;
    
    [userDefaults setObject:[NSArray arrayWithArray:userFavoris] forKey:kUserFavoritesArray];
    [userDefaults synchronize];
}

- (void)shareAction {
    
    NSArray *activityItems = @[UIActivityTypeMail, UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypeMessage];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)moreInfosButtonClicked:(UIButton *)sender {
    
    NSString *shamengoPath = self.innovation.shamengoPath;
    
    if (shamengoPath && ![shamengoPath isEqualToString:@""]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:shamengoPath]];
    }
}

/*********************************************************************/
#pragma mark - Categorie color method
/*********************************************************************/

- (NSString *)getPinsNameForCategoryName:(NSString *)categoryName {
    
    if ([categoryName isEqualToString:@"Alimentation"]) {
        return @"pins_food";
        
    } else if ([categoryName isEqualToString:@"Eau"]) {
        return @"pins_water";
        
    } else if ([categoryName isEqualToString:@"Transports"]) {
        return @"pins_transport";
        
    } else if ([categoryName isEqualToString:@"Energie"]) {
        return @"pins_energy";
        
    } else if ([categoryName isEqualToString:@"L'Habitat"]) {
        return @"pins_home";
        
    } else {
        return @"pins_home";
    }
}

- (UIColor *)getColorNameForCategoryName:(NSString *)categoryName {
    
    if ([categoryName isEqualToString:@"Alimentation"]) {
        return [UIColor colorWithRed:147.f green:192.f blue:31.f alpha:0.f];
        
    } else if ([categoryName isEqualToString:@"Eau"]) {
        return [UIColor colorWithRed:4.f green:186.f blue:238.f alpha:0.f];
        
    } else if ([categoryName isEqualToString:@"Transports"]) {
        return [UIColor colorWithRed:58.f green:58.f blue:58.f alpha:0.f];
        
    } else if ([categoryName isEqualToString:@"Energie"]) {
        return [UIColor colorWithRed:242.f green:145.f blue:0.f alpha:0.f];
        
    } else if ([categoryName isEqualToString:@"L'Habitat"]) {
        return [UIColor colorWithRed:207.f green:1.f blue:108.f alpha:0.f];
        
    } else {
        return [UIColor colorWithRed:58.f green:58.f blue:58.f alpha:0.f];
    }
}

@end
