//
//  SVInnovation.h
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 21/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVInnovation : NSObject

@property (strong, nonatomic) NSString *innovationName;
@property (strong, nonatomic) NSString *pionnerName;
@property (assign, nonatomic) NSInteger innovationId;
@property (strong, nonatomic) NSString *category;
@property (assign, nonatomic) BOOL starred;
@property (strong, nonatomic) NSString *beaconMajor;
@property (strong, nonatomic) NSString *enBrefTextField;
@property (strong, nonatomic) NSString *innovationTextField;
@property (strong, nonatomic) NSString *pionnerTextField;
@property (strong, nonatomic) NSString *shamengoPath;
@property (strong, nonatomic) NSString *pionnerImageName;
@property (strong, nonatomic) NSString *innovationImageName;
@property (strong, nonatomic) NSString *innovationMoviePath;

- (id)initPropertiesWithDictionary:(NSDictionary *)properties;

@end
