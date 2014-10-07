//
//  Deck.h
//  Matchismo
//
//  Created by Karl Christopher Nelson on 1/10/2014.
//  Copyright (c) 2014 Karl Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard:(Card *)card atTop:(BOOL)atTop;

-(void) addCard:(Card *)card;

-(Card *)drawRandomCard;

-(NSUInteger) countCards;

@end
