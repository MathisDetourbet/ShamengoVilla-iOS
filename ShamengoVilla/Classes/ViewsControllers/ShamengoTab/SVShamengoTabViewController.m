//
//  SVShamengoTabViewController.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 14/09/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVShamengoTabViewController.h"
#import "SVConstants.h"

@interface SVShamengoTabViewController ()

@property (weak, nonatomic) IBOutlet UILabel    *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel    *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel    *thirdLabel;
@property (weak, nonatomic) IBOutlet UIButton   *signUpButton;

@end

@implementation SVShamengoTabViewController


/*********************************************************************/
#pragma mark - Life view cycle
/*********************************************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.firstLabel.text = _(@"firstLabelShamengoTab");
    self.secondLabel.text = _(@"secondLabelShamengoTab");
    self.thirdLabel.text = _(@"thirdLabelShamengoTab");
    
    NSString *deviceLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    if (![deviceLanguage isEqualToString:@"fr-FR"]) {
        [self.signUpButton setImage:[UIImage imageNamed:@"Inscription_en"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpButtonClicked:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_(@"linkSignUp")]];
}

@end
