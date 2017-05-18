//
//  SmallScaleHeadView.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/18.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "SmallScaleHeadView.h"

@implementation SmallScaleHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor cyanColor];
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.portraitButton];
    [self addSubview:self.nameLabel];
    
    self.backgroundImageView.image = [UIImage imageNamed:@"bg.jpg"];
    [self.portraitButton setImage:[UIImage imageNamed:@"header.jpg"] forState:UIControlStateNormal];
    [self.nameLabel setText:@"昵称"];
    
    
    self.originHeight = 200;
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    self.backgroundImageView.frame = CGRectMake(0, 0, width, height);
    
    self.portraitButton.frame = CGRectMake(0, 0, 100, 100);
    self.portraitButton.center = CGPointMake(width/2, height/2);
    self.portraitButton.layer.cornerRadius = CGRectGetHeight(self.portraitButton.frame)/2;
    
//    self.pullUpMinHeight = 64;
    if (height >= self.originHeight) {
        
    } else if (height > self.pullUpMinHeight && height <= self.originHeight) {
        CGFloat kHeaderMinWidth = 40; // 头像最小的大小
        CGFloat kHeaderWidth = 100; // 头像最大的大小

        //未移动时候，头像高度 kHeaderWidth，     移动到最后头像高度kHeaderMinWidth)
        //未移动时候，整体高度 self.originHeight，移动到最后高度 64
        //即整体移动到最多的(self.originHeight-minHeight)时候，头像的大小减少到最大的(kHeaderWidth-kHeaderMinWidth)
        //则整体每移动1像素，头像的大小减少要 (kHeaderWidth-kHeaderMinWidth)/(self.originHeight-self.pullUpMinHeight-20)
        CGFloat kEachPixel = (kHeaderWidth-kHeaderMinWidth)/(self.originHeight-self.pullUpMinHeight+20); //整体每移动1像素，头像的大小减少了多少

        CGFloat headerChangeHeight = (self.originHeight-height) * kEachPixel;//头像改变的大小
        CGFloat headerLastHeight = kHeaderWidth - headerChangeHeight;
        self.portraitButton.frame = CGRectMake(0, 0, headerLastHeight, headerLastHeight);
        self.portraitButton.center = CGPointMake(width/2, (height-20)/2+20);
        self.portraitButton.layer.cornerRadius = CGRectGetHeight(self.portraitButton.frame)/2;
        
        [self fixHeaderImageViewWithReachtop:NO];
        
    } else { //height <= 44
        self.portraitButton.frame = CGRectMake(0, 0, 40, 40);
        self.portraitButton.center = CGPointMake(width/2, height/2);
        self.portraitButton.layer.cornerRadius = CGRectGetHeight(self.portraitButton.frame)/2;
        
        [self fixHeaderImageViewWithReachtop:YES];
    }
}

- (void)fixHeaderImageViewWithReachtop:(BOOL)reachtop {
    UIViewController *viewController = [self getBelongViewControllerForView:self];
    if (viewController.navigationController) {
        if (reachtop) {
            self.portraitButton.hidden = YES;
            
            // 移到navigationBar上
            UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
            titleView.backgroundColor = [UIColor clearColor];
            [titleView addSubview:self.navigationBarPortraitButton];
            
            viewController.navigationItem.titleView = titleView;
            
        } else {
            self.portraitButton.hidden = NO;
            
            [self.navigationBarPortraitButton removeFromSuperview];
            viewController.navigationItem.titleView = nil;
        }
    }
}

- (nullable UIViewController *)getBelongViewControllerForView:(UIView *)view {
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]) {
            return (UIViewController *)responder;
        }
    return nil;
}

#pragma mark - getter methods
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImageView.clipsToBounds = YES;
    }
    
    return _backgroundImageView;
}

- (UIButton *)portraitButton {
    if (!_portraitButton) {
        _portraitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_portraitButton addTarget:self action:@selector(portraitAction) forControlEvents:UIControlEventTouchUpInside];
        _portraitButton.clipsToBounds = YES;
    }
    
    return _portraitButton;
}

- (UIButton *)navigationBarPortraitButton {
    if (!_navigationBarPortraitButton) {
        _navigationBarPortraitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_navigationBarPortraitButton addTarget:self action:@selector(portraitAction) forControlEvents:UIControlEventTouchUpInside];
        _navigationBarPortraitButton.clipsToBounds = YES;
        
        UIImage *image = [_portraitButton.imageView.image copy];
        [_navigationBarPortraitButton setImage:image forState:UIControlStateNormal];
        _navigationBarPortraitButton.frame = CGRectMake(0, 0, 40, 40);
        _navigationBarPortraitButton.layer.cornerRadius = CGRectGetHeight(_navigationBarPortraitButton.frame)/2;
    }
    
    return _navigationBarPortraitButton;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _nameLabel;
}

#pragma mark - 点击方法
- (void)portraitAction {
    NSLog(@"点击了头像");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
