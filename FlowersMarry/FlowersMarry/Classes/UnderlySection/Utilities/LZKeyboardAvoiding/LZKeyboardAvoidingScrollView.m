//
//  LZKeyboardAvoidingScrollView.m
//  SEZB
//
//  Created by 寕小陌 on 2016/12/23.
//  Copyright © 2016年 寜小陌. All rights reserved.
//

#import "LZKeyboardAvoidingScrollView.h"

@interface LZKeyboardAvoidingScrollView () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, assign) BOOL canBecomFirstResponder;

@end

@implementation LZKeyboardAvoidingScrollView

#pragma mark - Setup/Teardown

- (void)setup {
    
    _canBecomFirstResponder = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lz_KeyboardAvoiding_keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lz_KeyboardAvoiding_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToActiveTextField) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToActiveTextField) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrame)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

-(id)initWithFrame:(CGRect)frame {
    if ( !(self = [super initWithFrame:frame]) ) return nil;
    [self setup];
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self lz_KeyboardAvoiding_updateContentInset];
}

-(void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    [self lz_KeyboardAvoiding_updateFromContentSizeChange];
}

- (void)contentSizeToFit {
    self.contentSize = [self lz_KeyboardAvoiding_calculatedContentSizeFromSubviewFrames];
}

- (BOOL)focusNextTextField {
    return [self lz_KeyboardAvoiding_focusNextTextField];
    
}
- (void)scrollToActiveTextField {
    return [self lz_KeyboardAvoiding_scrollToActiveTextField];
}

- (void)keyboardWillChangeFrame{
    
    _canBecomFirstResponder = NO;
}

- (void)keyboardDidChangeFrame{
    
    _canBecomFirstResponder = YES;
}

#pragma mark - Responders, events

-(void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if ( !newSuperview ) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(lz_KeyboardAvoiding_assignTextDelegateForViewsBeneathView:) object:self];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_canBecomFirstResponder)
        [[self lz_KeyboardAvoiding_findFirstResponderBeneathView:self] resignFirstResponder];

    [super touchesEnded:touches withEvent:event];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ( ![self focusNextTextField] ) {
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(lz_KeyboardAvoiding_assignTextDelegateForViewsBeneathView:) object:self];
    [self performSelector:@selector(lz_KeyboardAvoiding_assignTextDelegateForViewsBeneathView:) withObject:self afterDelay:0.1];
}

@end
