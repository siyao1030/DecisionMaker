//
//  BubbleView.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 12/3/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleView : UIView

@property int sizeA;
@property NSString * labelA;
@property int sizeB;
@property NSString * labelB;
@property BOOL displaySize;

@property id target;
@property SEL increaseA;
@property SEL increaseB;


//@property UILabel * label;
//@property UILabel * sizeLabel;

-(void)setUpWithSiza:(int)size andLabel:(NSString *)label andChoice:(int)index andShouldDisplaySize:(BOOL)shouldDisplay;

-(void)setUpWithItemALabel:(NSString *)labelA andASize:(int)sizeA andItemBLabel: (NSString *)labelB andBSize:(int)sizeB andShouldDisplaySize:(BOOL)shouldDisplay;
@end
