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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpButtonClicked:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_(@"linkSignUp")]];
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
