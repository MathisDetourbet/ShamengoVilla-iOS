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

@interface SVInnovationCardViewController ()

@property (strong, nonatomic) MPMoviePlayerController   *moviePlayer;
@property (strong, nonatomic) UITabBarController        *tabBarController;

@property (weak, nonatomic) IBOutlet UIImageView        *pionnerImageView;
@property (weak, nonatomic) IBOutlet UILabel            *pioneerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel            *innovDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel            *innovIDLabel;
@property (weak, nonatomic) IBOutlet UILabel            *innovCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel            *pioneerCountryLabel;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
    self.tabBarController = (UITabBarController*)[[(SVAppDelegate *)[[UIApplication sharedApplication]delegate] window] rootViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildUI {
    // ID
    self.innovIDLabel.text = [NSString stringWithFormat:@"%lu", self.innovation.innovationId];
    
    // Category
    self.innovCategoryLabel.text = [NSString stringWithFormat:@"%@", self.innovation.innovCategory];
    
    // Description
    self.innovDescriptionLabel.numberOfLines = 0;
    self.innovDescriptionLabel.textAlignment = NSTextAlignmentJustified;
    NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
    paragraphStyles.firstLineHeadIndent = 1.f;
    paragraphStyles.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyles};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self.innovation.innovDescription] attributes: attributes];
    self.innovDescriptionLabel.attributedText = attributedString;
    
    // Pioneer Name
    self.pioneerNameLabel.text = [NSString stringWithFormat:@"%@", self.innovation.pionnerName];
    
    // Pioneer Country
    self.pioneerCountryLabel.text = [NSString stringWithFormat:@"%@", self.innovation.pionnerCountry];
    
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

- (void)shareAction {
    
    NSArray *activityItems = @[UIActivityTypeMail, UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypeMessage];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
