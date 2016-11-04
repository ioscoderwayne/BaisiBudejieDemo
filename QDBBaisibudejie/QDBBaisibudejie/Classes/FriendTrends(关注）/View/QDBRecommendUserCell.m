//
//  QDBRecommendUserCell.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/25.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBRecommendUserCell.h"
#import <UIImageView+WebCache.h>

@interface QDBRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation QDBRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUserModel:(QDBUserModel *)userModel
{
    _userModel = userModel;
    //设置数据
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:userModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置name
    self.nameLabel.text = userModel.screen_name;
    //设置粉丝
    NSString *fansCount = nil;
    if (userModel.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注", userModel.fans_count];
    } else { // 大于等于10000
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", userModel.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
}

@end
