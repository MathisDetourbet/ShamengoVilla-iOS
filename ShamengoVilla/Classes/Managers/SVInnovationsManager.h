//
//  SVInnovationsManager.h
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 21/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVInnovationsManager : NSObject

@property (strong, nonatomic) NSMutableArray *innovationsList;

+ (id)sharedManager;
- (void)loadInnovations;

@end
