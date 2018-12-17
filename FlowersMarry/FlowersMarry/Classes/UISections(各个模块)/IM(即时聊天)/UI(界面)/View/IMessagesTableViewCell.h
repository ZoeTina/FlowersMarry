//
//  IMessagesTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMessagesModel.h"
#import "IMessagesTools.h"

typedef void  (^DoubleClickBlock) (IMessagesModel * model);


@interface IMessagesTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView messageModel:(IMessagesModel *)model;

+(CGFloat)tableHeightWithModel:(IMessagesModel *)model;


@property (nonatomic,strong) UIImageView* voiceAnimationImageView;
@property (nonatomic,strong) UIImageView* coversImageView;

@property (nonatomic,strong) IMessagesModel* messageModel;
@property(nonatomic,copy)DoubleClickBlock doubleblock;
@property(nonatomic,copy)DoubleClickBlock singleblock;
@property(nonatomic,copy)DoubleClickBlock resendblock;

-(void)setDoubleClickBlock:(DoubleClickBlock )doubleClickBlock;
-(void)setSingleClickBlock:(DoubleClickBlock )singleClickBlock;
-(void)setResendClickBlock:(DoubleClickBlock )resendClickBlock;

-(void)stopVoiceAnimation;
-(void)startVoiceAnimation;
-(void)startSentMessageAnimation;
-(void)stopSentMessageAnimation;


@end
