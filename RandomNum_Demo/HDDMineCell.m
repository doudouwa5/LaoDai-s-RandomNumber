//
//  HDDMineCell.m
//  RandomNum_Demo
//
//  Created by HanDD on 2020/7/2.
//  Copyright © 2020 AlezJi. All rights reserved.
//

#import "HDDMineCell.h"
#import "HDDMineCellModel.h"


@interface HDDMineCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel *tittleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@end


@implementation HDDMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(HDDMineCellModel *)model{
    self.leftImage.image = [UIImage imageNamed:model.imageName];
    self.tittleLabel.text = model.tittle;
    self.desLabel.text = model.des;
    self.rightImage.hidden = model.hiddenRightImage;
}

@end
