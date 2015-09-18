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

@end

@implementation SVInnovationTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)displayInnovation:(SVInnovation *)innovation forIndexPath:(NSIndexPath *)indexPath
{
    self.innovationTitleLabel.text = [NSString stringWithFormat:@"\"%@\"", innovation.innovationName];
    self.innovationIDLabel.text = [NSString stringWithFormat:@"%ld", (long)innovation.innovationId];
    self.pionnerNameLabel.text = innovation.pionnerName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


@end
