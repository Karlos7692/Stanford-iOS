//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Karl Christopher Nelson on 4/10/2014.
//  Copyright (c) 2014 Karl Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject


//This is my designated initialiser.
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck cardsToMatch:(NSUInteger)cardsToMatch;

-(void)chooseCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) BOOL hasGameStarted;
@property (nonatomic, readonly) NSString *gameDescription;



@end
