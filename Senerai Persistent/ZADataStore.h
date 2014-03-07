//
//  ZADataStore.h
//  Senerai Persistent
//
//  Created by Ezekiel Abuhoff on 3/6/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tag;
@class ToDo;

@interface ZADataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readonly, strong, nonatomic) NSArray *toDos;
@property (readonly, strong, nonatomic) NSArray *tags;

+ (instancetype) sharedDataStore;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (ToDo *) createToDoWithName: (NSString *)name;
- (Tag *) createTagWithName: (NSString *)name;
- (void) addTag: (Tag *)tag
         toToDo: (ToDo *)toDo;
- (void) sortToDosByName;
- (void) sortToDosByTag;

- (void) fetchData;

@end
