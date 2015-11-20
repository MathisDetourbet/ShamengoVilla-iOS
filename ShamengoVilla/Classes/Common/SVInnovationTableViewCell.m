//
//  SVInnovationTableViewCell.m
//  ShamengoVilla
//
//  Created by Mathis Detourbet on 31/08/2015.
//  Copyright (c) 2015 Efrei. All rights reserved.
//

#import "SVInnovationTableViewCell.h"

@interface SVInnovationTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView         *containerView;
@property (weak, nonatomic) IBOutlet UILabel        *innovationTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel        *innovationIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *innovationImageView;
@property (weak, nonatomic) IBOutlet UILabel        *pionnerNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *categoryImageView;

@end

@implementation SVInnovationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.layer.shadowOffset = CGSizeMake(1, 0);
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = .25;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)displayInnovation:(SVInnovation *)innovation forIndexPath:(NSIndexPath *)indexPath {
    
    self.innovationTitleLabel.text = [NSString stringWithFormat:@"\"%@\"", innovation.innovationName];
    self.innovationTitleLabel.font = [UIFont fontWithName:@"TitilliumText22L-Regular" size:11.f];
    
    self.innovationIDLabel.text = [NSString stringWithFormat:@"%ld", (long)innovation.innovationId];
    self.innovationIDLabel.font = [UIFont fontWithName:@"TitilliumText22L-XBold" size:17.f];
    
    self.pionnerNameLabel.text = innovation.pionnerName;
    self.pionnerNameLabel.font = [UIFont fontWithName:@"TitilliumText22L-Regular" size:10.f];
    
    self.innovationImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", innovation.innovationImageName]];
    
    self.categoryImageView.image = [UIImage imageNamed:innovation.innovCategory];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
