//
//  ViewController.m
//  Attributor
//
//  Created by Karl Christopher Nelson on 7/10/2014.
//  Copyright (c) 2014 Karl Nelson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString *title =
    [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    
    [title setAttributes:
     @{ NSStrokeWidthAttributeName : @3,
        NSStrokeColorAttributeName : self.outlineButton.tintColor }
        range: NSMakeRange(0, [title length])];
    
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(preferredFontsChanged:)
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
    
    
}
-(void) preferredFontsChanged: (NSNotification *)notification {
    [self usePreferredFonts];
}

-(void) usePreferredFonts {
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}
- (IBAction)changeBodySelectionColourToMatchBackgroundColour:(UIButton *)sender {
    
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}


- (IBAction)outlineBodySelection {
    
    [self.body.textStorage addAttributes:
    @{ NSStrokeWidthAttributeName : @-3,
       NSStrokeColorAttributeName : [UIColor blackColor]
    } range: self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
