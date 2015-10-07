//
//  SVInnovationCardViewController.h
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 14/09/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVInnovation.h"

@interface SVInnovationCardViewController : UIViewController

@property (strong, nonatomic) SVInnovation *innovation;

- (id)initWithInnovation:(SVInnovation *)innov;

@end
