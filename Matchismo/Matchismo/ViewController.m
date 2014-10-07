//
//  ViewController.m
//  Matchismo
//
//  Created by Karl Christopher Nelson on 1/10/2014.
//  Copyright (c) 2014 Karl Nelson. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *gameDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentationControl;

@property (nonatomic, strong) CardMatchingGame *game;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}
- (IBAction)chooseGameMode:(UISegmentedControl *)sender {
    [self newGame];
}

- (IBAction)newGame {
    [self resetGame];
    [self updateUI];
    [self setGameDescriptionLabelText];
    self.gameModeSegmentationControl.enabled = true;
}

-(void) updateUI{
    
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.gameModeSegmentationControl.enabled = !self.game.hasGameStarted;
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score  : %ld", self.game.score];
    [self setGameDescriptionLabelText];
}

-(NSString *) titleForCard:(Card *) card {
    
    return card.isChosen ? card.contents : @"";
    
}

-(UIImage *) backgroundImageForCard:(Card *) card {
    
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
    
    
}


-(CardMatchingGame *) game {
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] cardsToMatch:(self.gameModeSegmentationControl.selectedSegmentIndex +2)];
    }
    return _game;
}

-(void) resetGame {
    NSLog(@"Cards to choose %lu", (self.gameModeSegmentationControl.selectedSegmentIndex +2));
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] cardsToMatch:(self.gameModeSegmentationControl.selectedSegmentIndex +2)];
}

-(PlayingCardDeck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}


-(void) setGameDescriptionLabelText {
    self.gameDescriptionLabel.text = self.game.gameDescription;
}


@end
