//
//  FMToolsModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMToolsModel.h"

@implementation FMToolsModel

+ (NSMutableArray *)loadToolsDataArray{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSArray* titleArr = @[@[@"结婚任务 >",@"结婚账本 >"],
                          @[@"结婚预算",@"结婚吉日",@"结婚登记处",@"我的宾客",@"微信婚礼墙",@"电子请帖"]];
    NSArray* imagesArr = @[@[@"记任务",@"去记账"],
                           @[@"tools_btn_jisuanqi",@"tools_btn_jiri",@"tools_btn_dengjichu",@"tools_btn_binke",@"tools_btn_weixinqiang",@"tools_btn_qingtie"]];
    NSArray* subtitleArr = @[@[@"全国婚姻登记查询",@"挑选结婚黄道吉日"],
                             @[@"全国婚姻登记查询",@"挑选结婚黄道吉日",@"全国婚姻登记查询",@"挑选结婚黄道吉日",@"全国婚姻登记查询",@"挑选结婚黄道吉日"]];
    NSArray* classArr = @[@[@"FMMarriedTaskViewController",@"FMMarriedBooksViewController"],
                          @[@"FMMarriedBudgetViewController",@"FMMarriedGoodDayViewController",@"FMMarriedRegisterViewController",
                            @"FMMineGuestsViewController",@"FMWeChatWallViewController",@"FMElectronicInvitationViewController"]];

    for (int i=0; i<titleArr.count; i++) {
        NSArray *subTitlesArray = [titleArr lz_safeObjectAtIndex:i];
        NSArray *subImagesArray = [imagesArr lz_safeObjectAtIndex:i];
        NSArray *subtitleArray = [subtitleArr lz_safeObjectAtIndex:i];
        NSArray *classArray = [classArr lz_safeObjectAtIndex:i];
        NSMutableArray *subArray = [NSMutableArray array];
        for (int j = 0; j < subTitlesArray.count; j ++) {
            FMToolsModel* toolsModel = [[FMToolsModel alloc] init];
            toolsModel.title = [subTitlesArray lz_safeObjectAtIndex:j];
            toolsModel.imageText = [subImagesArray lz_safeObjectAtIndex:j];
            toolsModel.subtitle = [subtitleArray lz_safeObjectAtIndex:j];
            toolsModel.showClass = [classArray lz_safeObjectAtIndex:j];
            [subArray addObject:toolsModel];
        }
        [dataArray addObject:subArray];
    }
    return dataArray;
}

@end
