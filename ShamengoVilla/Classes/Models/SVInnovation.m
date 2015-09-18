//
//  SVInnovation.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 21/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVInnovation.h"
#import "NSDictionary+Utils.h"

@implementation SVInnovation

- (id)initPropertiesWithDictionary:(NSDictionary *)properties {
    
    self = [super init];
    
    if (self) {
        
        self.innovationName = [properties objectForKeyNotNull:@"innovName" expectedClass:[NSString class]];
        self.pionnerName = [properties objectForKeyNotNull:@"pioneerName" expectedClass:[NSString class]];
        self.pionnerCountry = [properties objectForKeyNotNull:@"pionneerCountry" expectedClass:[NSString class]];
        self.innovationId = [[properties objectForKeyNotNull:@"innovNumber" expectedClass:[NSNumber class]] integerValue];
        self.category = [properties objectForKeyNotNull:@"category" expectedClass:[NSString class]];
        self.starred = [[properties objectForKeyNotNull:@"starred" expectedClass:[NSNumber class]] boolValue];
        self.beaconMajor = [properties objectForKeyNotNull:@"beaconMajor" expectedClass:[NSString class]];
        self.beaconMinor = [properties objectForKeyNotNull:@"beaconMinor" expectedClass:[NSString class]];
        self.innovDescription = [properties objectForKeyNotNull:@"description" expectedClass:[NSString class]];
        self.pionnerImageName = [properties objectForKeyNotNull:@"pioneerPicture" expectedClass:[NSString class]];
        self.innovationImageName = [properties objectForKeyNotNull:@"innovVideo" expectedClass:[NSString class]];
        self.innovationMoviePath = [properties objectForKeyNotNull:@"innovVideo" expectedClass:[NSString class]];
        self.shamengoPath = [properties objectForKeyNotNull:@"ShamengoLink" expectedClass:[NSString class]];
    }
    
    return self;
}

@end
