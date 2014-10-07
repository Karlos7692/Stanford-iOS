//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Karl Christopher Nelson on 4/10/2014.
//  Copyright (c) 2014 Karl Nelson. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) BOOL hasGameStarted;
@property (nonatomic, readwrite) NSUInteger cardsToMatch;
@property (nonatomic) NSUInteger cardsChosen;
@property (nonatomic, readwrite) NSString *gameDescription;

@end

@implementation CardMatchingGame

-(NSMutableArray *) cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(NSString *)gameDescription {
    if(!_gameDescription) {
        _gameDescription = @"Start Game by touching a card.";
    }
    return _gameDescription;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck cardsToMatch:(NSUInteger) cardsToMatch {
    
    self = [super init];
    
    if(self) {
        BOOL validInit = true;
        for (int i = 0; i < count && validInit; i++) {
            Card *card = [deck drawRandomCard];
            if(card) {
                self.cards[i] = card;
            } else {
                self = nil;
                validInit = false;
            }
        }
        self.cardsToMatch = cardsToMatch;
        self.cardsChosen = 0;
        self.hasGameStarted = false;
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index {
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
    
}



static const int COST_TO_CHOOSE = 1;
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;

-(void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    self.gameDescription = [card.contents stringByAppendingString:@" selected."];
    self.hasGameStarted = true;
    if(!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO;
            self.gameDescription = @"";
            self.cardsChosen--;
        } else {
            card.chosen = YES;
            self.cardsChosen++;
            self.score -= COST_TO_CHOOSE;
            if(self.cardsChosen == self.cardsToMatch) {
                NSMutableArray *chosenCards = [self getAllChosenCards];
                int score = [self matchCardsScore:chosenCards];
                self.score += score;
                [self setMatchedOrResetCards:chosenCards score:score];
            }
            NSLog(@"cardsChosen %lu, cardsToMatch %lu", self.cardsChosen, self.cardsToMatch);
        }
    }

}

-(NSMutableArray *) getAllChosenCards {
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    
    for(Card *card in self.cards) {
        if(card.chosen && !card.matched) {
            [chosenCards addObject:card];
        }
    }
    
    
    return chosenCards;
    
}

-(int) matchCardsScore:(NSMutableArray *) chosenCards {
    int score = 0;
    for(int i=0; i < [chosenCards count] -1; i++) {
        Card *card = chosenCards[i];
        for(int j=i+1; j<[chosenCards count]; j++) {
            Card *comparison = chosenCards[j];
            score += [card match:comparison];
        }
    }
    
    score = score * MATCH_BONUS;
    return score;
    
}


-(void) setMatchedOrResetCards:(NSMutableArray *) chosenCards score:(int)score {
    self.gameDescription = @"";
    if(score == 0) {
        for(Card *chosenCard in chosenCards) {
            chosenCard.chosen = NO;
            self.gameDescription = [self.gameDescription stringByAppendingString:[@" " stringByAppendingString:chosenCard.contents]];
        }
        self.gameDescription = [self.gameDescription stringByAppendingString:@" don't match."];
    } else {
        self.gameDescription = @"Matched";
        for(Card *chosenCard in chosenCards) {
            chosenCard.matched = YES;
            self.gameDescription = [self.gameDescription stringByAppendingString:[@" " stringByAppendingString:chosenCard.contents]];
        }
        self.gameDescription = [self.gameDescription stringByAppendingString:@"."];
        
    }
    if(score == 0) {
        self.score -= MISMATCH_PENALTY;
        
    }
    self.cardsChosen = 0;
    
}



@end
