//
//  LZKeyboardAvoidingScrollView.h
//  SEZB
//
//  Created by 寕小陌 on 2016/12/23.
//  Copyright © 2016年 寜小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+LZKeyboardAvoidingAdditions.h"

@interface LZKeyboardAvoidingScrollView : UIScrollView <UITextFieldDelegate, UITextViewDelegate>
- (void)contentSizeToFit;
- (BOOL)focusNextTextField;
- (void)scrollToActiveTextField;
@end
