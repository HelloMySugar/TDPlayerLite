//
//  BasePlayer.m
//  PlayerManager
//
//  Created by TangYanQiong on 15/8/13.
//  Copyright (c) 2015年 TangYanQiong. All rights reserved.
//

#import "BasePlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface BasePlayer ()
{
    BOOL nowIsPlayStatus;
}
@end

@implementation BasePlayer

- (id)init
{
    if (self = [super init])
    {
        self.retryTimes = 3;//重试次数默认为3次
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(gotoBackground)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(fromBackground)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        //监听耳机插拔状态
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(audioRouteChangeListenerCallback:)
                                                     name:AVAudioSessionRouteChangeNotification
                                                   object:nil];
    }
    return self;
}

- (id)initWithPlayerView:(UIView *)playerView {
    NSLog(@"需要重写该方法");
    return nil;
}

- (void)setPlayerViewFrame:(CGRect)frame {
    NSLog(@"需要重写该方法");
}

- (void)setPlayUrl:(NSString *)playUrl {
    NSLog(@"需要重写该方法");
}

- (void)play {
    NSLog(@"需要重写该方法");
}

- (void)pause {
    NSLog(@"需要重写该方法");
}

- (void)stop {
    NSLog(@"需要重写该方法");
}

- (void)replay {
    NSLog(@"需要重写该方法");
}

- (void)cancel {
    NSLog(@"需要重写该方法");
}

- (void)seekToTime:(CGFloat)seekTime {
    NSLog(@"需要重写该方法");
}

- (NSString *)getNetworkSpeed {
    NSLog(@"需要重写该方法");
    return nil;
}

- (UIImage *)getScreenshot
{
    NSLog(@"需要重写该方法");
    return nil;
}

- (void)close {
    NSLog(@"已调用父类该方法");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionRouteChangeNotification object:nil];
}

#pragma mark - UIApplication Delegate -

- (void)gotoBackground
{
    nowIsPlayStatus = self.isPlaying;
    if (nowIsPlayStatus)
        [self pause];
}

- (void)fromBackground
{
    if (nowIsPlayStatus)
    {
        [self seekToTime:self.currentTime];//为了声画不同步，然后进入后再重新seekto下就好了
    }else
    {
        [self pause];
    }
}

- (void)audioRouteChangeListenerCallback:(NSNotification *)notification
{
    NSDictionary *interuptionDict = notification.userInfo;
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    switch (routeChangeReason) {
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            [self pause];
            break;
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
            [self pause];
            break;
        case AVAudioSessionRouteChangeReasonCategoryChange:
            break;
    }
}

- (void)dealloc
{
    [self close];
}

@end
