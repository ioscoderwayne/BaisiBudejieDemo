//
//  QDBCategoryCell.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/10/25.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBCategoryCell.h"

@interface QDBCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation QDBCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = RGBColor(240, 240, 240);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   //设置颜色
    self.nameLabel.textColor = selected?RGBColor(219, 21, 26): RGBColor(78, 78, 78);
    
    self.indicatorView.hidden = !selected;
    
}

-(void)setRecommendTagModel:(QDBRecommendTagModel *)recommendTagModel
{
    _recommendTagModel = recommendTagModel;
    
    self.nameLabel.text = recommendTagModel.name;
}
@end
