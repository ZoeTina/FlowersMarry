//
//  UIScrollView+LZKeyboardAvoidingAdditions.h
//  SEZB
//
//  Created by 寕小陌 on 2016/12/23.
//  Copyright © 2016年 寜小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LZKeyboardAvoidingAdditions)
- (BOOL)lz_KeyboardAvoiding_focusNextTextField;
- (void)lz_KeyboardAvoiding_scrollToActiveTextField;

- (void)lz_KeyboardAvoiding_keyboardWillShow:(NSNotification*)notification;
- (void)lz_KeyboardAvoiding_keyboardWillHide:(NSNotification*)notification;
- (void)lz_KeyboardAvoiding_updateContentInset;
- (void)lz_KeyboardAvoiding_updateFromContentSizeChange;
- (void)lz_KeyboardAvoiding_assignTextDelegateForViewsBeneathView:(UIView*)view;
- (UIView*)lz_KeyboardAvoiding_findFirstResponderBeneathView:(UIView*)view;
- (CGSize)lz_KeyboardAvoiding_calculatedContentSizeFromSubviewFrames;
@end
