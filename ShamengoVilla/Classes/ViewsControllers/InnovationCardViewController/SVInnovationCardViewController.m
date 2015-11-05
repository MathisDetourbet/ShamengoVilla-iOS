//
//  SVInnovationCardViewController.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 14/09/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVInnovationCardViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SVInnovationCardViewController ()

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@property (weak, nonatomic) IBOutlet UIImageView *pionnerImageView;
@property (weak, nonatomic) IBOutlet UILabel *pioneerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *innovDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *innovIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *innovCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *pioneerCountryLabel;

- (void)buildUI;
- (void)doneButtonClicked;
- (void)shareAction;

@end

@implementation SVInnovationCardViewController

- (id)initWithInnovation:(SVInnovation *)innov
{
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildUI {
    
    self.innovIDLabel.text = [NSString stringWithFormat:@"%lu", self.innovation.innovationId];
    self.innovCategoryLabel.text = [NSString stringWithFormat:@"%@", self.innovation.innovCategory];
    
    self.innovDescriptionLabel.text = [NSString stringWithFormat:@"%@", self.innovation.innovDescription];
    self.innovDescriptionLabel.numberOfLines = 0;
    self.innovDescriptionLabel.textAlignment = NSTextAlignmentJustified;
    
    self.pioneerNameLabel.text = [NSString stringWithFormat:@"%@", self.innovation.pionnerName];
    self.pioneerCountryLabel.text = [NSString stringWithFormat:@"%@", self.innovation.pionnerCountry];
    self.pionnerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.innovation.pionnerImageName]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                           target:self
                                                                                           action:@selector(shareAction)];
}

- (IBAction)playVideo:(UIButton *)sender {
    
    NSString *movieNameJSON = [[NSString alloc] initWithFormat:@"%@", self.innovation.innovationMoviePath];
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:movieNameJSON ofType:@""];
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    self.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    self.moviePlayer.fullscreen = YES;
    self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    self.moviePlayer.shouldAutoplay = YES;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
