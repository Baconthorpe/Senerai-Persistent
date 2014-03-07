//
//  ZAViewToDoVC.m
//  Senerai Persistent
//
//  Created by Ezekiel Abuhoff on 3/6/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ZAViewToDoVC.h"
#import "ZADataStore.h"
#import "ToDo.h"
#import "Tag.h"

@interface ZAViewToDoVC ()

@property ZADataStore *myData;

@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end

@implementation ZAViewToDoVC

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
    
    self.createdAtLabel.text = [NSString stringWithFormat:@"Created at:\n%@" , [self.myToDo.createdAt description]];
    self.tagLabel.text = [NSString stringWithFormat:@"Tag: %@" , self.myToDo.tag.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
