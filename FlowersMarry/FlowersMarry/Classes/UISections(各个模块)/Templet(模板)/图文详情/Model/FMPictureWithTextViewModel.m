//
//  FMPictureWithTextViewModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/19.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPictureWithTextViewModel.h"

@implementation FMPictureWithTextViewModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [PictureWithTextModel class]};
}



+ (FMPictureWithTextViewModel *)fetchModelData {
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"PictureWithTextData" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
//    FMPictureWithTextViewModel *model =[FMPictureWithTextViewModel mj_objectWithDictionary:jsonObject];
    FMPictureWithTextViewModel *model =[FMPictureWithTextViewModel mj_objectWithKeyValues:jsonObject];

    return model;
}
@end

@implementation PictureWithTextModel
+ (NSDictionary *)objectClassInArray{
    return @{@"comments" : [MCommentsModel class],
             @"recommended" : [RecommendedModel class],
             @"articlet" : [ArticletModel class]
             };
}
@end

@implementation MCommentsModel
+ (NSDictionary *)objectClassInArray{
    return @{@"reply" : [ReplyModel class]};
}

+ (NSMutableArray *)fetchModelData {
    
    NSArray *array = [[NSArray alloc] init];

    array = @[@{
                @"kid": @"16101",
                @"avatar": @"",
                @"content": @"因为是网上订的 所以一直都有所担心。没想到对方很大 环境也很好 服务也特别好。特别感谢化妆师英子老师 由于自己怀孕了才拍照。在选服装的时候特别累就没认真选。也没选合适。",
                @"nickname": @"微笑12345",
                @"reply": @[@{@"replyTime": @"1分钟前",
                              @"replyContent": @"感谢您的选择和信任，我们会一如既往地为更多人服务!"
                           }]
                },
                @{@"kid": @"16101",
                  @"avatar":@"",
                  @"content":@"因为是网上订的 所以一直都有所担心。没想到对方很大 环境也很好 服务也特别好。",
                  @"nickname":@"微笑12345",
                  @"reply": @[@{
                               @"replyTime": @"1分钟前",
                               @"replyContent": @"感谢您的选择和信任，我们会一如既往地为更多人服务!"
                               }]
                 },
                 @{
                   @"kid": @"16101",
                   @"avatar": @"",
                   @"content": @"因为是网上订的 所以一直都有所担心。没想到对方很大 环境也很好 服务也特别好。特别感谢化妆师英子老师 由于自己怀孕了才拍照。在选服装的时候特别累就没认真选。也没选合适。",
                   @"nickname": @"微笑12345",
                   @"reply": @[@{
                                @"replyTime": @"1分钟前",
                                @"replyContent": @"感谢您的选择和信任，我们会一如既往地为更多人服务!"
                               }]
                 },
                 @{
                   @"kid": @"16101",
                   @"avatar": @"",
                   @"content": @"因为是网上订的 所以一直都有所担心。没想到对方很大 环境也很好 服务也特别好。特别感谢化妆师英子老师 由于自己怀孕了才拍照。在选服装的时候特别累就没认真选。也没选合适。",
                   @"nickname": @"微笑12345",
                   @"reply": @[@{
                               @"replyTime": @"1分钟前",
                               @"replyContent": @"感谢您的选择和信任，我们会一如既往地为更多人服务!"
                               }]
                 }];
    //模拟网络请求接收到的数组对象 FMTongxunluModel数组
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSInteger index = 0; index < array.count;index++){
        MCommentsModel *model = [MCommentsModel new];
        model.kid = array[index][@"kid"];
        model.nickname = array[index][@"nickname"];
        model.content = array[index][@"content"];
        NSArray *replyArray = array[index][@"reply"];
        for (NSInteger idx = 0; idx < replyArray.count;idx++) {
            ReplyModel *replyModel = [ReplyModel new];
            replyModel.replyTime = replyArray[idx][@"replyTime"];
            replyModel.replyContent = replyArray[idx][@"replyContent"];
        }
        //        model.name = [stringsToSort objectAtIndex:index];
        
        [dataArray addObject:model];
    }
    return dataArray;
}

@end

@implementation ReplyModel

@end

@implementation RecommendedModel

@end

@implementation ArticletModel

@end
