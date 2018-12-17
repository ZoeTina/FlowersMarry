//
//  BRPickerViewMacro.h
//  BRPickerViewDemo
//
//  Created by 任波 on 2018/4/23.
//  Copyright © 2018年 91renb. All rights reserved.
//

#ifndef TTPickerViewMacro_h
#define TTPickerViewMacro_h

#define kPickerHeight 216
#define kTopViewHeight 44

// 状态栏的高度(20 / 44(iPhoneX))
#define TT_STATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)
#define TT_IS_iPhoneX ((TT_STATUSBAR_HEIGHT == 44) ? YES : NO)
// 底部安全区域远离高度
#define TT_BOTTOM_MARGIN ((CGFloat)(TT_IS_iPhoneX ? 34 : 0))

// 默认主题颜色
#define kDefaultThemeColor UIColorHexString(0x464646)
// topView视图的背景颜色
#define kTTToolBarColor UIColorHexString(0xFDFDFD)

// 静态库中编写 Category 时的便利宏，用于解决 Category 方法从静态库中加载需要特别设置的问题
#ifndef TTSYNTH_DUMMY_CLASS

#define TTSYNTH_DUMMY_CLASS(_name_) \
@interface TTSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation TTSYNTH_DUMMY_CLASS_ ## _name_ @end

#endif

// 过期提醒
#define TTPickerViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

/**
 合成弱引用/强引用
 
 Example:
     @weakify(self)
     [self doSomething^{
         @strongify(self)
         if (!self) return;
         ...
     }];
 
 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#endif /* TTPickerViewMacro_h */
