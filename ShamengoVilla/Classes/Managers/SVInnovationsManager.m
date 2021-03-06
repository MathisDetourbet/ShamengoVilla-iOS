//
//  SVInnovationsManager.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 21/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVInnovationsManager.h"
#import "NSDictionary+Utils.h"
#import "SVInnovation.h"

@implementation SVInnovationsManager

+ (id)sharedManager {
    
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)loadInnovations {
    
    NSString *jsonPath = nil;
    NSString *deviceLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    if ([deviceLanguage isEqualToString:@"fr-FR"]) {
        jsonPath = [[NSBundle mainBundle] pathForResource:@"jsoncop21_fr" ofType:@"json"];
        
    } else {
        jsonPath = [[NSBundle mainBundle] pathForResource:@"jsoncop21_en" ofType:@"json"];
    }
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    NSDictionary *jsonDico = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    self.innovationsList = nil;
    
    if (jsonDico != nil) {
        NSArray *fiches = [jsonDico objectForKeyNotNull:@"fiches" expectedClass:[NSArray class]];
        
        if (fiches) {
            self.innovationsList = [[NSMutableArray alloc] initWithCapacity:[fiches count]];
            
            for (NSDictionary *ficheProperties in fiches) {
                
                @autoreleasepool {
                    SVInnovation *innovation = [[SVInnovation alloc] initPropertiesWithDictionary:ficheProperties];
                    [self.innovationsList addObject:innovation];
                }
            }
            NSLog(@"%lu innovations loaded", (unsigned long)self.innovationsList.count);
            
        } else {
            NSLog(@"### Error : there is no innovation in json file");
            return;
        }
    } else {
        NSLog(@"### Error : jsonData is nil !");
        return;
    }
    
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"innovationId" ascending:YES]];
    NSArray *sortedArray = [self.innovationsList sortedArrayUsingDescriptors:sortDescriptors];
    self.innovationsList = [NSMutableArray arrayWithArray:sortedArray];
}



@end
