//
//  CSIndexPatch.m
//  CSDropDownMenu
//
//  Created by 宁小陌 on 2018/5/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCIndexPatch.h"

@implementation SCIndexPatch

- (instancetype)initWithColumn:(NSInteger)column section:(NSInteger)section row:(NSInteger)row {
    self = [super init];
    if (self) {
        _column = column;
        _section = section;
        if (row) {
            _row = row;
        } else {
            _row = -1;
        }
    }
    return self;
}

- (BOOL)getHasRow {
    return -1 == _row;
}

@end
