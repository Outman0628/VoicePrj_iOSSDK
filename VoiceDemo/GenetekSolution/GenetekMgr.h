//
//  GenetekMgr.m
//  VoiceDemo
//
//  Created by David on 2019/12/23.
//  Copyright © 2019 genetek. All rights reserved.
//

#import <AgoraRtmKit/AgoraRtmKit.h>

typedef NS_ENUM(NSInteger, LoginStatus) {
    LoginStatusOnline = 0,
    LoginStatusOffline
};

@interface GenetekMgr : NSObject
+ (void) InitSoloution: (NSString *) appId;
+ (AgoraRtmKit * _Nullable)kit;
+ (LoginStatus)status;
+ (void)setStatus:(LoginStatus)status;
+ (void)phoneCall: (NSString *)remoteUid  UserID:(NSString *) userId;
+ (void)sendMsg: (NSString *)remoteUid  UserID:(NSString *) userId  MSG:(NSString *) msg;
+ (void)updateDelegate:(id <AgoraRtmDelegate> _Nullable)delegate;
@end
