//
//  Factor.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factor : NSObject

@property NSString * title;
@property NSMutableArray * weights;
@property float averageWeight;

-(id)initWithTitle:(NSString *)title;

@end
