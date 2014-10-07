//
//  PlayingCard.m
//  Matchismo
//
//  Created by Karl Christopher Nelson on 1/10/2014.
//  Copyright (c) 2014 Karl Nelson. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()

@end

@implementation PlayingCard

+(NSArray *) validSuits {
    return @[@"♣︎",@"♥︎",@"♦︎",@"♠"];
}

+(NSArray *) validRanks {
    return @[@"?", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K", @"A"];
}

+(NSUInteger) maxRank {
    return [[PlayingCard validRanks] count] -1;
}

-(NSString *) contents {
    
    NSArray *ranks = [PlayingCard validRanks];
    return [ranks[self.rank]  stringByAppendingString:self.suit];
}


@synthesize suit = _suit;

- (NSString *) suit {
    NSString *suit = [PlayingCard validRanks][0];
    if(_suit) {
        suit = _suit;
    }
    return suit;
}

-(void)setSuit:(NSString *)suit {
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(int) match:(PlayingCard *) card {
    int score = 0;
    if ([card.suit isEqualToString:self.suit]) {
        score += 1;
    }
    if(card.rank == self.rank) {
        score += 4;

    }

    return score;
}




@end
