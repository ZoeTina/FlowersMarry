//
//  FMPersonModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/4.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPersonModel.h"

@implementation FMPersonModel

@end

@implementation FMMineModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [MineModel class]};
}
@end

@implementation MineModel
+ (NSDictionary *)objectClassInArray{
    return @{@"count" : [MineMessageCount class]};
}
@end

@implementation MineMessageCount

@end


@implementation ThirdPartyModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [ThirdModel class]};
}
@end

@implementation ThirdModel

@end
