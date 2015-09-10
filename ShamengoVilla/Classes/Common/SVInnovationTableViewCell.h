//
//  SVInnovationTableViewCell.h
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 31/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVInnovation.h"

@interface SVInnovationTableViewCell : UITableViewCell

- (void)displayInnovation:(SVInnovation *)innovation forIndexPath:(NSIndexPath *)indexPath;

@end
