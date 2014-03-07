//
//  ZANewToDoVC.m
//  Senerai Persistent
//
//  Created by Ezekiel Abuhoff on 3/6/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ZANewToDoVC.h"
#import "ZADataStore.h"
#import "Tag.h"
#import "ToDo.h"

@interface ZANewToDoVC ()

@property ZADataStore *myData;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITableView *tagTable;


@property (strong, nonatomic) Tag *selectedTag;

@end

@implementation ZANewToDoVC

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
    
    self.tagTable.dataSource = self;
    self.tagTable.delegate = self;
    self.nameField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.myData fetchData];
    [self.tagTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.myData.tags count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"toDoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Tag *thisTag = self.myData.tags[indexPath.row];
    cell.textLabel.text = thisTag.name;
    
    if (thisTag == self.selectedTag)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedTag = self.myData.tags[indexPath.row];
    
    [self.tagTable reloadData];
}

#pragma mark - Button Methods

//- (IBAction)cancelButton:(id)sender
//{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}

- (IBAction)doneButton:(id)sender
{
    if (![self.nameField.text isEqualToString:@""] && self.selectedTag != nil)
    {
        ToDo *newTodo = [self.myData createToDoWithName:self.nameField.text];
        [self.myData addTag:self.selectedTag toToDo:newTodo];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITextField Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameField resignFirstResponder];
    return YES;
}

@end
