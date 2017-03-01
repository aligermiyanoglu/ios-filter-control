//
//  SEFilterProgressView.h
//  SEFilterControl_Sample
//
//  Created by Ali Germiyanoglu on 28/02/2017.
//  Copyright © 2017 Shady Elyaski. All rights reserved.
//

#import <UIKit/UIKit.h>


#define LEFT_OFFSET                         25
#define RIGHT_OFFSET                        25
#define TITLE_SELECTED_DISTANCE             5
#define TITLE_FADE_ALPHA                    .5f

#define KNOB_HEIGHT                         55
#define KNOB_WIDTH                          35

@interface SEFilterProgressView : UIView

@property (nonatomic, strong) UIColor *color;

@property (nonatomic) NSUInteger nodeCount;

- (void)redraw;

- (BOOL)isDrawn;

@end
