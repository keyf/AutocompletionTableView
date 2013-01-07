//
//  ACDViewController.m
//  AutocompletionTableView_Demo
//
//  Created by Gushin Arseniy on 13.03.12.
//  Copyright (c) 2012 Arseniy Gushin. All rights reserved.
//

#import "ACDViewController.h"
#import "AutocompletionTableView.h"

@interface ACDViewController ()
@property (nonatomic, strong) AutocompletionTableView *autoCompleter;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *sampleLabel;

@end

@implementation ACDViewController

@synthesize textField = _textField;
@synthesize sampleLabel = _sampleLabel;
@synthesize autoCompleter = _autoCompleter;

- (AutocompletionTableView *)autoCompleter
{
    if (!_autoCompleter)
    {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:2];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];
        
        _autoCompleter = [[AutocompletionTableView alloc] initWithTextField:self.textField inViewController:self withOptions:options];
        _autoCompleter.autoCompleteDelegate = self;
        _autoCompleter.suggestionsDictionary = [NSArray arrayWithObjects:@"hostel",@"caret",@"carrot",@"house",@"horse", nil];
    }
    return _autoCompleter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set "value changed" event handler for TextField
    [self.textField addTarget:self.autoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (IBAction)caseSwitchChanged:(UISwitch *)sender 
{
    NSMutableDictionary *options = [self.autoCompleter.options mutableCopy];
    [options setValue:[NSNumber numberWithBool:sender.on] forKey:ACOCaseSensitive];
    self.autoCompleter.options = options;
}

- (IBAction)fontSwitchChanged:(UISwitch *)sender 
{
    NSMutableDictionary *options = [self.autoCompleter.options mutableCopy];
    UIFont *cellLabelFont = (sender.on) ? nil : self.sampleLabel.font;
    [options setValue:cellLabelFont forKey:ACOUseSourceFont];
    self.autoCompleter.options = options;
}

- (void)viewDidUnload {
    [self setSampleLabel:nil];
    [self setSampleLabel:nil];
    [super viewDidUnload];
}

#pragma mark - AutoCompleteTableViewDelegate

- (NSArray*) autoCompletion:(AutocompletionTableView*) completer suggestionsFor:(NSString*) string{
    // with the prodided string, build a new array with suggestions - from DB, from a service, etc.
    return [NSArray arrayWithObjects:@"hostel",@"caret",@"carrot",@"house",@"horse", nil];
}

- (void) autoCompletion:(AutocompletionTableView*) completer didSelectAutoCompleteSuggestionWithIndex:(NSInteger) index{
    // invoked when an available suggestion is selected
    NSLog(@"%@ - Suggestion chosen: %d", completer, index);
}

@end
