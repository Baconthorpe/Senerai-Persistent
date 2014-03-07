//
//  Tag.h
//  Senerai Persistent
//
//  Created by Ezekiel Abuhoff on 3/6/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ToDo;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *toDos;
@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addToDosObject:(ToDo *)value;
- (void)removeToDosObject:(ToDo *)value;
- (void)addToDos:(NSSet *)values;
- (void)removeToDos:(NSSet *)values;

@end
