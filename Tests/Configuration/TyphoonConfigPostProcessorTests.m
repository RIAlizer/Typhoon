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

#import <XCTest/XCTest.h>
#import "Typhoon.h"
#import "Knight.h"
#import "OCLogTemplate.h"
#import "TyphoonTestAssemblyConfigPostProcessor.h"

@interface TyphoonConfigPostProcessorTests : XCTestCase
@end

@implementation TyphoonConfigPostProcessorTests
{
    TyphoonConfigPostProcessor *_configurer;
}

- (void)setUp
{
    _configurer = [TyphoonConfigPostProcessor postProcessor];
    [_configurer useResourceWithName:@"SomeProperties.properties"];
    [_configurer useResourceWithName:@"SomeProperties.json"];
    [_configurer useResourceWithName:@"SomeProperties.plist"];

}

- (void)test_parses_property_name_value_pairs
{
    // TODO: replace with an actual automated test.
//    NSDictionary *properties = [_configurer properties];
//    LogTrace(@"Properties: %@", properties);
//    properties = nil;
}

- (void)test_mutates_initializer_values
{
    TyphoonComponentFactory *factory = [[TyphoonComponentFactory alloc] init];
    TyphoonDefinition *knightDefinition = [[TyphoonDefinition alloc] initWithClass:[Knight class] key:@"knight"];
    [knightDefinition useInitializer:@selector(initWithQuest:damselsRescued:) parameters:^(TyphoonMethod *initializer) {
        [initializer injectParameterWith:nil];
        [initializer injectParameterWith:TyphoonConfig(@"damsels.rescued")];
    }];
    [factory registerDefinition:knightDefinition];

    [_configurer postProcessComponentFactory:factory];

    Knight *knight = [factory componentForType:[Knight class]];
    XCTAssertEqual(knight.damselsRescued, 12);

}

- (void)test_mutates_property_values
{
    TyphoonComponentFactory *factory = [[TyphoonComponentFactory alloc] init];
    TyphoonDefinition *knightDefinition = [[TyphoonDefinition alloc] initWithClass:[Knight class] key:@"knight"];
    [knightDefinition injectProperty:@selector(damselsRescued) with:TyphoonConfig(@"damsels.rescued")];
    [factory registerDefinition:knightDefinition];

    [_configurer postProcessComponentFactory:factory];

    Knight *knight = [factory componentForType:[Knight class]];
    XCTAssertEqual(knight.damselsRescued, 12);

}

- (void)test_json_values
{
    TyphoonComponentFactory *factory = [[TyphoonComponentFactory alloc] init];
    TyphoonDefinition *knightDefinition = [[TyphoonDefinition alloc] initWithClass:[Knight class] key:@"knight"];
    [knightDefinition useInitializer:@selector(initWithQuest:damselsRescued:) parameters:^(TyphoonMethod *initializer) {
        [initializer injectParameterWith:nil];
        [initializer injectParameterWith:TyphoonConfig(@"json.damsels_rescued")];
    }];
    [knightDefinition injectProperty:@selector(hasHorseWillTravel) with:TyphoonConfig(@"json.hasHorseWillTravel")];
    [factory registerDefinition:knightDefinition];

    [_configurer postProcessComponentFactory:factory];

    Knight *knight = [factory componentForType:[Knight class]];
    XCTAssertEqual(knight.damselsRescued, (NSUInteger)42);
    XCTAssertEqual(knight.hasHorseWillTravel, (BOOL)YES);
}

- (void)test_plist_values
{
    TyphoonComponentFactory *factory = [[TyphoonComponentFactory alloc] init];
    TyphoonDefinition *knightDefinition = [[TyphoonDefinition alloc] initWithClass:[Knight class] key:@"knight"];
    [knightDefinition useInitializer:@selector(initWithQuest:damselsRescued:) parameters:^(TyphoonMethod *initializer) {
        [initializer injectParameterWith:nil];
        [initializer injectParameterWith:TyphoonConfig(@"plist.damsels")];
    }];
    [knightDefinition injectProperty:@selector(hasHorseWillTravel) with:TyphoonConfig(@"plist.hasHorse")];
    [factory registerDefinition:knightDefinition];

    [_configurer postProcessComponentFactory:factory];

    Knight *knight = [factory componentForType:[Knight class]];
    XCTAssertEqual(knight.damselsRescued, (NSUInteger)28);
    XCTAssertEqual(knight.hasHorseWillTravel, (BOOL)YES);
}

- (void)test_config_as_runtime_argument
{
    TyphoonTestAssemblyConfigPostProcessor *assembly = [[[TyphoonBlockComponentFactory alloc] initWithAssembly:[TyphoonTestAssemblyConfigPostProcessor assembly]] asAssembly];
    [_configurer postProcessComponentFactory:(id)assembly];
    Knight *knight = [assembly knight];
    XCTAssertEqualObjects(knight.quest.imageUrl, [NSURL URLWithString:@"http://google.com/"]);
}

@end