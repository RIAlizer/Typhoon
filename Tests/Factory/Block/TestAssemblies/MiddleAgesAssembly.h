////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Jasper Blues & Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////



#import <Foundation/Foundation.h>
#import "TyphoonAssembly.h"
#import "QuestProvider.h"

@class TyphoonDefinition;
@class Mock;

@interface MiddleAgesAssembly : TyphoonAssembly <QuestProvider>

- (id)knight;

- (id)cavalryMan;

- (id)defaultQuest;

- (id)environmentDependentQuest;

- (id)anotherKnight;

- (id)yetAnotherKnight;

- (id)serviceUrl;

- (id)knightWithRuntimeDamselsRescued:(NSNumber *)damselsRescued runtimeFoobar:(NSObject *)runtimeObject;

- (id)knightWithRuntimeDamselsRescued:(NSNumber *)damselsRescued runtimeQuestUrl:(NSURL *)url;

- (id)knightWithDefinedQuestUrl;

- (id)questWithRuntimeUrl:(NSURL *)url;

- (id)knightClassMethodInit;

- (id)knightWithMethodInjection;

- (id)knightWithCircularDependencyAndDamselsRescued:(NSNumber *)damselsRescued;

- (id)knightWithPredefinedCircularDependency:(NSNumber *)damselsRescued;

- (id)knightWithFoobar:(NSString *)foobar;

- (id)knightWithFakePropertyQuest;

- (id)knightWithFakePropertyQuestByType;

- (Mock *)mockWithRuntimeBlock:(NSString*(^)())block andRuntimeClass:(Class)aClass;

- (id)knightRuntimeArgumentsFromDefinition;

- (id)knightRuntimeArgumentsFromDefinitionWithRuntimeArg;

- (id)knightRuntimeArgumentsFromDefinitionsSetWithRuntimeArg;

@end