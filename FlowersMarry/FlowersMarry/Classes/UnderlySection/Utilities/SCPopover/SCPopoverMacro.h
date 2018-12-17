//
//  SCPopoverMacro.h
//  SCPopover
//
//  Created by 宁小陌 on 2018/7/3.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#ifndef SCPopoverMacro_h
#define SCPopoverMacro_h



#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

typedef void(^SCCompleteHandle)(BOOL presented);

typedef NS_ENUM(NSUInteger, SCPopoverType){
    SCPopoverTypeActionSheet = 1,
    SCPopoverTypeAlert = 2
};

#endif /* SCPopoverMacro_h */
