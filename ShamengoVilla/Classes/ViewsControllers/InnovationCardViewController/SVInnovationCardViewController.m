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
    self.pionnerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.innovation.pionnerImageName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)playVideo:(UIButton *)sender {
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"KantaHani30secpourtest" ofType:@"mp4"];
    NSURL *videoURL = [NSURL URLWithString:videoPath];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    self.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    self.moviePlayer.fullscreen = YES;
    self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    self.moviePlayer.shouldAutoplay = YES;
    [self.moviePlayer.view setFrame:self.view.frame];
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
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
