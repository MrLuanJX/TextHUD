//
//  TextHUD.h
//  TextHUD
//
//  Created by hogo0211 on 2021/11/24.
//

#import <UIKit/UIKit.h>

@interface TextHUD : UIView

+ (TextHUD*)showInWindowWithDuration:(NSInteger)duration Text:(NSString*)text;
+ (TextHUD*)showIn:(UIView*)view text:(NSString*)text;
+ (TextHUD*)showIn:(UIView*)view Duration:(NSInteger)duration Text:(NSString*)text;
+ (TextHUD *)hideIn:(UIView *)view;
+ (TextHUD*)dismiss;

@end
