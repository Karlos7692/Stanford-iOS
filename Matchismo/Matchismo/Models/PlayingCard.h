//
//  PlayingCard.h
//  Matchismo
//
//  Created by Karl Christopher Nelson on 1/10/2014.
//  Copyright (c) 2014 Karl Nelson. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *) validSuits;
+(NSArray *) validRanks;
+(NSUInteger) maxRank;


@end
