//
//  PerfectSharedInstanceClass.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/1/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerfectSharedInstanceClass : NSObject <NSCopying>

+ (PerfectSharedInstanceClass *)sharedInstance;


@end
