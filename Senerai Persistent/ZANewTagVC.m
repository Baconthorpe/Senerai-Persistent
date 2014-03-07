//
//  ZANewTagVC.m
//  Senerai Persistent
//
//  Created by Ezekiel Abuhoff on 3/6/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ZANewTagVC.h"
#import "ZADataStore.h"

@interface ZANewTagVC ()

@property ZADataStore *myData;

@property (weak, nonatomic) IBOutlet UITextField *nameField;


@end

@implementation ZANewTagVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.myData = [ZADataStore sharedDataStore];
    
    self.nameField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(id)sender
{
    [self.myData createTagWithName:self.nameField.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextField Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameField resignFirstResponder];
    
    return YES;
}

@end
