//
//  Card.m
//  Matchismo
//
//  Created by Karl Christopher Nelson on 1/10/2014.
//  Copyright (c) 2014 Karl Nelson. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card


static int MATCHED_CONTENTS = 1;

-(int)match:(Card *) card {
    
    int score = 0;
    if([card.contents isEqualToString:self.contents]) {
        score += MATCHED_CONTENTS;
    }
        
    return score;
    
}



@end
