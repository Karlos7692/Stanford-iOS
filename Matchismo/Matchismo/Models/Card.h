//
//  Card.h
//  Matchismo
//
//  Created by Karl Christopher Nelson on 1/10/2014.
//  Copyright (c) 2014 Karl Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(int)match:(Card *)card;

@end
