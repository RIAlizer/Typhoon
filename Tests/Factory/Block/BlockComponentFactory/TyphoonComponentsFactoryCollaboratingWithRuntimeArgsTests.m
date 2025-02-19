//
//  TyphoonComponentsFactoryCollaboratingWithRuntimeArgsTests.m
//  Typhoon
//
//  Created by Aleksey Garbarev on 19.05.14.
//
//

#import "TyphoonBlockComponentFactory.h"
#import <XCTest/XCTest.h>
#import "CollaboratingMiddleAgesAssembly.h"
#import "MiddleAgesAssembly.h"
#import "Knight.h"

@interface TyphoonComponentsFactoryCollaboratingWithRuntimeArgsTests : XCTestCase

@end

@implementation TyphoonComponentsFactoryCollaboratingWithRuntimeArgsTests {
    CollaboratingMiddleAgesAssembly *assembly;
}

- (void)setUp
{
    [super setUp];

    assembly = [[[TyphoonBlockComponentFactory alloc] initWithAssemblies:@[
        [CollaboratingMiddleAgesAssembly assembly],
        [MiddleAgesAssembly assembly]
    ]] asAssembly];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)test_collaborating_assembly_with_runtime_args
{
    Knight *knight = [assembly knightWithCollaboratingFoobar:@"Hello"];

    Knight *fried = [knight.friends anyObject];

    XCTAssertTrue([fried.foobar isEqual:@"Hello"]);
}

@end
