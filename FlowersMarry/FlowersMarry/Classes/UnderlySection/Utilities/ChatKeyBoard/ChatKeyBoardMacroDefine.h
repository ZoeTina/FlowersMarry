//
//  ChatKeyBoardMacroDefine.h
//  LWGreenBaby
//
//  Created by 律金刚 on 16/4/11.
//  Copyright © 2016年 宁小陌. All rights reserved.
//

#ifndef ChatKeyBoardMacroDefine_h
#define ChatKeyBoardMacroDefine_h

/**  判断文字中是否包含表情 */
#define IsTextContainFace(text) [text containsString:@"["] &&  [text containsString:@"]"] && [[text substringFromIndex:text.length - 1] isEqualToString:@"]"]

/** 判断emoji下标 */
#define emojiText(text)  (text.length >= 2) ? [text substringFromIndex:text.length - 2] : [text substringFromIndex:0]

//ChatKeyBoard背景颜色
#define kChatKeyBoardColor              [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1.0f]

//键盘上面的工具条
#define kChatToolBarHeight              49

//表情模块高度
#define kFacePanelHeight                216
#define kFacePanelBottomToolBarHeight   44
#define kUIPageControllerHeight         25

//拍照、发视频等更多功能模块的面板的高度
#define kMorePanelHeight                216
#define kMoreItemH                      80
#define kMoreItemIconSize               60


//整个聊天工具的高度
#define kChatKeyBoardHeight     kChatToolBarHeight + kFacePanelHeight

#define isIPhone4_5                (kScreenWidth == 320)
#define isIPhone6_6s               (kScreenWidth == 375)
#define isIPhone6p_6sp             (kScreenWidth == 414)

#endif /* ChatKeyBoardMacroDefine_h */
