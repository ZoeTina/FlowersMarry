//
//  FMTongxunluModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTongxunluModel.h"

@implementation FMTongxunluModel

+ (NSMutableArray *)getModelData {
    
    NSArray *stringsToSort=[NSArray arrayWithObjects:
                            @"李白",@"王昭君",@"太乙真人",@"曹操",@"安琪拉",@"亚瑟",@"狄仁杰",
                            @"花木兰",@"钟馗",@"甄姬",@"诸葛亮",@"李元芳",@"阿珂",@"程咬金",
                            @"兰陵王",@"大桥",@"露娜",@"娜可露露",@"不知火舞",@"凯",@"老夫子",
                            @"小乔",@"庄周",@"张飞",@"蔡文姬",@"孙悟空",@"鲁班七号",@"刘备",
                            @"后羿", @"马可波罗",@"成吉思汗",@"虞姬",@"吕布",@"#",@"高渐离",
                            @"#百里守约",@"#百里玄策",
                            nil];
    
    
    //模拟网络请求接收到的数组对象 FMTongxunluModel数组
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSInteger index = 0; index < stringsToSort.count;index++){
        FMTongxunluModel *model = [FMTongxunluModel new];
        model.name = stringsToSort[index];
        //        model.name = [stringsToSort objectAtIndex:index];
        
        int num = (arc4random() % 10000);
        NSString *randomNumber = [NSString stringWithFormat:@"1341234%.4d", num];
        model.phone = randomNumber;
        
        [dataArray addObject:model];
    }
    return dataArray;
}


@end
