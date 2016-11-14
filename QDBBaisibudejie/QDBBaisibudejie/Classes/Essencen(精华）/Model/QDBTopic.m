//
//  QDBTopic.m
//  QDBBaisibudejie
//
//  Created by weixiaoyang on 2016/11/1.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "QDBTopic.h"
#import <MJExtension.h>

@interface QDBTopic()
{
    CGFloat _rowHeight;
    CGRect _picViewF;
}
@end

@implementation QDBTopic

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"smallImage":@"image0",
             @"midImage":@"image1",
             @"bigImage":@"image2"};
}
/**
 *   处理时间
 */
-(NSString *)create_time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *createDate = [formatter dateFromString:_create_time];
    
    if ([createDate isThisYear]) {
        //今年
        if ([createDate isToday]) {
            
            NSDateComponents *comps = [[NSDate date] deltaFrom:createDate];
            //今天
            if (comps.hour>0) {
                //几小时前
                return [NSString stringWithFormat:@"%zd小时前",comps.hour];
            }else if (comps.minute>0){
                //几分钟前
                return [NSString stringWithFormat:@"%zd分钟前",comps.minute];
            }else{
                //刚刚
                return @"刚刚";
            }
        }else if([createDate isYesteday])   {
            //昨天  昨天 HH:mm:ss
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:createDate];
        }else{
            //其他 MM-dd HH:mm:ss
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:createDate];
        }
    }else{
        //不是今年 yyyy-MM-dd HH:mm:ss
        return _create_time;
    }
    
}

-(CGFloat)rowHeight
{
    if (!_rowHeight) {
        //计算文字高度
        CGFloat maxW = kScreenW - 2*kTopicCellMargin;
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
        
        
        _rowHeight = kTopictCellTextY +kTopicCellMargin+ textH +kTopicCellMargin ;
        
        if (_type == QDBTopicTypePicture) {
            CGFloat picX = kTopicCellMargin;
            CGFloat picY = kTopictCellTextY +kTopicCellMargin+ textH +kTopicCellMargin;
            CGFloat picW = maxW;
            CGFloat picH = kScreenW * _height/_width;
            if (picH >= kTopictCellMaxImageH) {
                picH = kTopictCellAdjustImageH;
                self.isBigPicture = YES;
            }
            _picViewF = CGRectMake(picX, picY, picW, picH);
            //图片帖子
            _rowHeight = _rowHeight + picH + kTopicCellMargin;
        }else if (_type == QDBTopicTypeVoice){
            //声音帖子
            CGFloat voiceX = kTopicCellMargin;
            CGFloat voiceY = kTopictCellTextY +kTopicCellMargin+ textH +kTopicCellMargin;
            CGFloat voiceW = maxW;
            CGFloat voiceH = kScreenW * _height/_width;
            
            _voiceViewF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _rowHeight = _rowHeight + voiceH + kTopicCellMargin;

        }
        _rowHeight = _rowHeight +kTopictCellBottomBarH +kTopicCellMargin;
    }
    
    return _rowHeight;
}
@end
