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
        self.pionnerName = [properties objectForKeyNotNull:@"pionnerName" expectedClass:[NSString class]];
        self.innovationId = [[properties objectForKeyNotNull:@"innovNumber" expectedClass:[NSNumber class]] integerValue];
        self.category = [properties objectForKeyNotNull:@"category" expectedClass:[NSString class]];
        self.starred = [[properties objectForKeyNotNull:@"starred" expectedClass:[NSNumber class]] boolValue];
        self.beaconMajor = [properties objectForKeyNotNull:@"beaconMajor" expectedClass:[NSString class]];
        
        if ([properties objectForKeyNotNull:@"textFields" expectedClass:[NSDictionary class]]) {
            
            NSDictionary *textFields = [properties objectForKey:@"textFields"];
            self.enBrefTextField = [textFields objectForKeyNotNull:@"en bref" expectedClass:[NSString class]];
            self.innovationTextField = [textFields objectForKeyNotNull:@"innovation" expectedClass:[NSString class]];
            self.pionnerTextField = [textFields objectForKeyNotNull:@"pionner" expectedClass:[NSString class]];
        }
        
        if ([properties objectForKeyNotNull:@"paths" expectedClass:[NSDictionary class]]) {
            
            NSDictionary *paths = [properties objectForKey:@"path"];
            self.shamengoPath = [paths objectForKeyNotNull:@"ShamengoLink" expectedClass:[NSString class]];
            self.pionnerImageName = [paths objectForKeyNotNull:@"pioneerPicture" expectedClass:[NSString class]];
            self.innovationImageName = [paths objectForKeyNotNull:@"innovVideo" expectedClass:[NSString class]];
        }
    }
    
    return self;
}

@end
