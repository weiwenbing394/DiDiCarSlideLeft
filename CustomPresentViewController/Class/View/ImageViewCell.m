//
//  ImageViewCell.m
//  CustomPresentViewController
//
//  Created by 大家保 on 2017/3/14.
//  Copyright © 2017年 大家保. All rights reserved.
//

#import "ImageViewCell.h"

@implementation ImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconImageView=[[UIImageView alloc]initWithFrame:CGRectZero];
        self.iconImageView.contentMode=UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.iconImageView];
    }
    return self;
}

- (void)layoutSubviews{
    self.iconImageView.frame=CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
