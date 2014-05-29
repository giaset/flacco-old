//
//  FLCPhotoTableViewCell.m
//  Flacco
//
//  Created by Gianni Settino on 2014-05-29.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

#import "FLCPhotoTableViewCell.h"

@implementation FLCPhotoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.photoView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        [self addSubview:self.photoView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

@end
