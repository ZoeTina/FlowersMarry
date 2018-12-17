//
//  IMessagesFaceModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "IMessagesFaceModel.h"

@implementation IMessagesFaceModel
+ (NSArray *)loadFaceArray {
    
    NSMutableArray *subjectArray = [NSMutableArray array];
    NSArray *sources = @[@"face"];
    for (int i = 0; i < sources.count; ++i) {
        NSString *plistName = sources[i];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *faceDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        NSArray *allkeys = faceDic.allKeys;
        
        FaceThemeModel *themeM = [[FaceThemeModel alloc] init];
        themeM.themeStyle = FaceThemeStyleCustomEmoji;
        themeM.themeDecribe = [NSString stringWithFormat:@"表情%d", i];
        
        NSMutableArray *modelsArr = [NSMutableArray array];
        
        for (int i = 0; i < allkeys.count; ++i) {
            NSString *name = allkeys[i];
            FaceModel *fm = [[FaceModel alloc] init];
            fm.faceTitle = name;
            fm.faceIcon = [faceDic objectForKey:name];
            [modelsArr addObject:fm];
        }
        themeM.faceModels = modelsArr;
        [subjectArray addObject:themeM];
    }
    
    return subjectArray;
}

@end
