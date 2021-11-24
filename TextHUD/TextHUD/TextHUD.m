//
//  TextHUD.m
//  TextHUD
//
//  Created by hogo0211 on 2021/11/24.
//

#import "TextHUD.h"
#import "BorderLabel.h"
#import <Masonry/Masonry.h>

//字体类型
#define Font_Bold @"PingFangSC-Semibold"
#define Font_Medium @"PingFangSC-Medium"
#define Font_Regular @"PingFangSC-Regular"

/**字体*/
#define LBFontNameSize(name,s) [UIFont fontWithName:name size:(LBScreenW > 374 ? (LBScreenW > 375 ?s * 1.1 : s) :s / 1.1)]

/**判断字符串是否为空*/
#define LBNULLString(string) ((string == nil) ||[string isEqualToString:@""] ||([string length] == 0)  || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 ||[string isEqual:[NSNull null]])
// window窗口
#ifdef __IPHONE_13_0
#define LBkWindow [UIApplication sharedApplication].keyWindow
#else
#define LBkWindow [UIApplication sharedApplication].windows[0]
#endif
/********************屏幕宽和高*******************/
#define LBScreenW [UIScreen mainScreen].bounds.size.width
#define LBScreenH [UIScreen mainScreen].bounds.size.height
//根据屏幕宽度计算对应View的高
#define LBFit(value) ((value * LBScreenW) / 375.0f)

@interface TextHUD()

@property(nonatomic, strong)BorderLabel* textLabel;
@property(nonatomic, strong)UIView* bgView;

@end

@implementation TextHUD

//显示
+ (TextHUD*)showIn:(UIView*)view text:(NSString*)text {
    [self hideIn:view];
    [self hideIn:LBkWindow];
    TextHUD *hud = [[TextHUD alloc] initWithFrame:view.bounds];
    hud.userInteractionEnabled = NO;
    hud.textLabel.text = LBNULLString(text)?@"":text;
    [hud shakeToShow:hud];
    [view addSubview:hud];
    return hud;
}

//显示
+ (TextHUD*)showIn:(UIView*)view Duration:(NSInteger)duration Text:(NSString*)text {
    [self hideIn:view];
    [self hideIn:LBkWindow];
    TextHUD *hud = [[TextHUD alloc] initWithFrame:view.bounds];
    hud.userInteractionEnabled = NO;
    hud.textLabel.text = LBNULLString(text)?@"":text;
    [hud shakeToShow:hud];
    [view addSubview:hud];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration<=0?2:duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideIn:view];
    });
    
    return hud;
}

+ (TextHUD*)showInWindowWithDuration:(NSInteger)duration Text:(NSString*)text {
    [self hideIn:LBkWindow];
    TextHUD *hud = [[TextHUD alloc] initWithFrame:LBkWindow.bounds];
    hud.userInteractionEnabled = NO;
    hud.textLabel.text = LBNULLString(text)?@"":text;
    [hud shakeToShow:hud];
    [LBkWindow addSubview:hud];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration<=0?2:duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideIn:LBkWindow];
    });
    
    return hud;
}

+ (TextHUD*)dismiss {
    TextHUD *hud = nil;
    for (TextHUD *subView in LBkWindow.subviews) {
        if ([subView isKindOfClass:[TextHUD class]]) {
            [UIView animateWithDuration:0.20 animations:^{
                subView.alpha = 0;
                subView.bgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [subView removeFromSuperview];
            }];
           hud = subView;
        }
    }
    return hud;
}

//隐藏
+ (TextHUD *)hideIn:(UIView *)view {
    TextHUD *hud = nil;
    for (TextHUD *subView in view.subviews) {
        if ([subView isKindOfClass:[TextHUD class]]) {
            [UIView animateWithDuration:0.20 animations:^{
                subView.alpha = 0;
                subView.bgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [subView removeFromSuperview];
            }];
           hud = subView;
        }
    }
    return hud;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.textLabel];
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo (self);
    }];
    
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.textLabel.superview);
        make.bottom.right.mas_equalTo(self.textLabel.superview);
    }];
}

- (BorderLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [BorderLabel new];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.font = LBFontNameSize(Font_Regular, 14);
        _textLabel.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _textLabel.numberOfLines = 0;
        _textLabel.preferredMaxLayoutWidth = LBScreenW - LBFit(80);
        _textLabel.text = @"这是一个纯文本的HUD";
        [_textLabel sizeToFit];
    }
    return _textLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.75f];
        _bgView.layer.cornerRadius = 8;
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

/* 显示提示框的动画 */
- (void)shakeToShow:(UIView*)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.05;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7,1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0,1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (void)dealloc {
    NSLog(@"dealloc__%@",self.class);
}

@end

