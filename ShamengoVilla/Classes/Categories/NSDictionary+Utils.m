//
//  NSDictionary+Utils.m
//  sports
//
//  Created by GA-EL MOUDEN Yassin on 23/04/14.
//  Copyright (c) 2014 Lagardere Active. All rights reserved.
//

#import "NSDictionary+Utils.h"

@implementation NSDictionary (Utils)

- (id)objectForKeyNotNull:(id)key expectedClass:(Class)expectClass
{
    id object = [self objectForKey:key];
    if (object == [NSNull null] || ![object isKindOfClass:expectClass])
        return nil;
    return object;
}

@end
