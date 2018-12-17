//
//  FMPictureWithTextViewModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/19.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PictureWithTextModel,MCommentsModel,RecommendedModel,ArticletModel,ReplyModel;
@interface FMPictureWithTextViewModel : NSObject

@property (nonatomic, copy) NSString *error;

@property (nonatomic, strong) PictureWithTextModel *data;

+ (FMPictureWithTextViewModel *)fetchModelData;
@end

@interface PictureWithTextModel : NSObject

@property (nonatomic, strong) NSMutableArray<MCommentsModel *> *comments;
@property (nonatomic, strong) NSMutableArray<RecommendedModel *> *recommended;
@property (nonatomic, strong) NSMutableArray<ArticletModel *> *articlet;

@end

@interface MCommentsModel : NSObject
+ (NSMutableArray *)fetchModelData;
@property (nonatomic, copy) NSString *kid;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, strong) NSMutableArray<ReplyModel *> *reply;

@end

@interface ReplyModel : NSObject
@property (nonatomic, copy) NSString *replyTime;
@property (nonatomic, copy) NSString *replyContent;

@end

@interface RecommendedModel : NSObject

@property (nonatomic, copy) NSString *article_src;
@property (nonatomic, copy) NSString *article_content;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *like;

@end

@interface ArticletModel : NSObject

@property (nonatomic, copy) NSString *article_id;
@property (nonatomic, copy) NSString *article_src;
@property (nonatomic, copy) NSString *article_content;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *type;

@end
