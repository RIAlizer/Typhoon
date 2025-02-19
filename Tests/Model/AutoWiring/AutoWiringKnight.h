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
#import "Knight.h"
#import "TyphoonAutoInjection.h"


@interface AutoWiringKnight : Knight

@property (nonatomic, strong) InjectedProtocol(Quest) quest;

@end