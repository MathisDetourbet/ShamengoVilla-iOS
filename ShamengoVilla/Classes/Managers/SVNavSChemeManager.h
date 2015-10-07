//
//  SVNavSChemeManager.h
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 18/09/2015.
//  Copyright © 2015 Efrei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SVNavSChemeManager : NSObject

+ (id)manager;
- (void)initRootViewController;
- (void)changeRootViewController:(UIViewController *)viewController;

@end
