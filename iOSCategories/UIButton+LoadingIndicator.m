//
//  UIButton+LoadingIndicator.m
//  UIButton LoadingIndicator
//
//  Created by anchen on 15/7/10.
//  Copyright © 2015年 anchen. All rights reserved.
//

#import "UIButton+LoadingIndicator.h"
#import <objc/runtime.h>

static NSString *const A_loadingIndicatorViewKey  = @"loadIndicatorView";
static NSString *const A_buttonTitleKey = @"titleKey";

@implementation UIButton (LoadingIndicator)

- (void)showLoadingIndicator{

    CGRect _sFrame = self.bounds;
    
    UIActivityIndicatorView *lIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    lIndicator.center = CGPointMake(_sFrame.size.width / 2, _sFrame.size.height / 2);
    [lIndicator startAnimating];
    
    NSString *buttonText = self.titleLabel.text;
    
    /*
     objc_setAssociatedObject 把某个对象关联到某个静态变量，静态变量的值是唯一的
     */
    objc_setAssociatedObject(self, &A_loadingIndicatorViewKey, buttonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &A_buttonTitleKey, lIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.enabled = NO;
    [self setTitle:@"" forState:UIControlStateNormal];
    [self addSubview:lIndicator];
}

- (void)hidenLoadingIndicator{
    
    self.enabled = YES;

    /*
     objc_getAssociatedObject 根据静态变量取出对应的值
     */
    NSString *currentButtonText = (NSString *)objc_getAssociatedObject(self, &A_loadingIndicatorViewKey);
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &A_buttonTitleKey);
    
    [indicator removeFromSuperview];
    [self setTitle:currentButtonText forState:UIControlStateNormal];
}

@end
