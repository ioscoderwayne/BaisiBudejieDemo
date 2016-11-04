//
//  QDBRecommedTagCell.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/28.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBRecommedTagCell.h"
#import "QDBTagModel.h"
#import <UIImageView+WebCache.h>

@interface QDBRecommedTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *referCountLabel;

@end

@implementation QDBRecommedTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTagModel:(QDBTagModel *)tagModel
{
    _tagModel = tagModel;
    
    //设置数据
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:tagModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = tagModel.theme_name;
    NSString *subNumber = nil;
    if (tagModel.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", tagModel.sub_number];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", tagModel.sub_number / 10000.0];
    }
    self.referCountLabel.text = subNumber;
    
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x += 10;
    frame.size.width -= 2*frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
