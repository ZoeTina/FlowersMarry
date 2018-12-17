//
//  FMMineReviewModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineReviewModel.h"

@implementation FMMineReviewModel
+ (NSMutableArray *)getModelData {
    
    NSArray *dataArray = @[@"base_image_tu15",@"base_image_tu16",@"base_image_tu17",
                           @"base_image_tu18",@"base_image_tu19",@"base_image_tu20",
                           @"base_image_tu17",@"base_image_tu16",@"base_image_tu15"];
    NSMutableArray *array = [dataArray copy];
    return array;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [MineReviewModel class]};
}
@end

@implementation MineReviewModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [MineReviewListModel class]};
}
@end

@implementation MineReviewListModel
+ (NSDictionary *)objectClassInArray{
    return @{@"photo" : [MineCommentPhotoModel class],
             @"auth" : [MineBusinessAuth class]};
}
@end

@implementation MineCommentPhotoModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}
@end

@implementation MineBusinessAuth

@end

