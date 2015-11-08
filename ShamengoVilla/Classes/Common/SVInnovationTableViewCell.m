//
//  SVInnovationTableViewCell.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 31/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVInnovationTableViewCell.h"

@interface SVInnovationTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *innovationTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *innovationIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView *innovationImageView;
@property (weak, nonatomic) IBOutlet UILabel *pionnerNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;

@end

@implementation SVInnovationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)displayInnovation:(SVInnovation *)innovation forIndexPath:(NSIndexPath *)indexPath {
    
    self.innovationTitleLabel.text = [NSString stringWithFormat:@"\"%@\"", innovation.innovationName];
    self.innovationIDLabel.text = [NSString stringWithFormat:@"%ld", (long)innovation.innovationId];
    self.pionnerNameLabel.text = innovation.pionnerName;
    
    // A supprimer lorsque toutes les images seront dispo !
    if ([innovation.innovationImageName isEqualToString:@"innov01.png"] || [innovation.innovationImageName isEqualToString:@"innov02.png"]) {
        self.innovationImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", innovation.innovationImageName]];
    }
    
    self.categoryImageView.image = [UIImage imageNamed:[self getPinsNameForCategoryName:innovation.innovCategory]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (NSString *)getPinsNameForCategoryName:(NSString *)categoryName {
    
    if ([categoryName isEqualToString:@"Alimentation"]) {
        return @"pins_food";
        
    } else if ([categoryName isEqualToString:@"Eau"]) {
        return @"pins_water";
        
    } else if ([categoryName isEqualToString:@"Transports"]) {
        return @"pins_transport";
        
    } else if ([categoryName isEqualToString:@"Energie"]) {
        return @"pins_energy";
        
    } else if ([categoryName isEqualToString:@"L'Habitat"]) {
        return @"pins_home";
        
    } else {
        return @"pins_home";
    }
}


@end
