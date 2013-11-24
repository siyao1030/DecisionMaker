//
//  Choice.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Factor.h"

@interface Choice : NSObject

@property NSString* title;
@property NSMutableArray* pros;
@property NSMutableArray* cons;

-(id)initWithTitle:(NSString *)title;
-(void)addToPros:(Factor *)factor;
-(void)addToCons:(Factor *)factor;
@end
