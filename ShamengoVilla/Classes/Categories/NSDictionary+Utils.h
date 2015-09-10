//
//  NSDictionary+Utils.h
//  sports
//
//  Created by GA-EL MOUDEN Yassin on 23/04/14.
//  Copyright (c) 2014 Lagardere Active. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Utils)
- (id)objectForKeyNotNull:(id)key expectedClass:(Class)expectClass;
@end
