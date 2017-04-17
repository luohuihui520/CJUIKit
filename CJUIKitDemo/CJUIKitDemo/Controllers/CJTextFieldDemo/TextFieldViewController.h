//
//  TextFieldViewController.h
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJTextField.h"
#import "CJAddSubtractTextField.h"

@interface TextFieldViewController : UIViewController

@property (nonatomic, weak) IBOutlet CJTextField *textFiled;
@property (nonatomic, weak) IBOutlet CJAddSubtractTextField *addSubtractTextField;
@property (nonatomic, weak) IBOutlet CJAddSubtractTextField *cannotInputAddSubtractTextField;

@end
