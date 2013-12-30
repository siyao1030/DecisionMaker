//
//  Factor.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factor : NSObject <NSCopying,NSCoding>

@property NSString * title;
@property NSMutableArray * weights;
@property NSMutableArray * comparedWith;
@property float averageWeight;
@property BOOL isPro;
//@property int uniqueID;

-(id)initWithTitle:(NSString *)title andIsPro:(BOOL)isPro;
-(BOOL)alreadyComparedWithFactor:(Factor *)otherFactor;
-(void)updateAverageWeight;
- (void)resetStats;

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;



@end
