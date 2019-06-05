//
//  ViewController.m
//  TDPlayerLite
//
//  Created by TangYanQiong on 2018/6/5.
//  Copyright © 2018年 TYQ. All rights reserved.
//

#import "ViewController.h"
#import "PlayerAdapter/PlayerManager.h"
@interface ViewController () <PlayerDelegate>
//播放器view
@property (nonatomic, strong) UIView *playerView;
/*!
 *  播放器对象
 */
@property (nonatomic, strong) BasePlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //播放器
    self.playerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.playerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.playerView];
    self.player = [[PlayerManager manager] getPlayerBy:self.playerView];
    self.player.delegate = self;
    [self.player setPlayUrl:@"http://182.138.101.48:5001/nn_vod/nn_x64/aWQ9NWZlOTljZWYwY2Q0Mzk3ZGRlNjI1MDExMTE0OGFlNjMmdXJsX2MxPTZkNmY2OTc2NjU3MzJmMzA2MjYzMzQzODMzNjUzMDY1MzIzMTYzNjYzMTMzMzAzMzYyMzUzNzM3MzkzMjY1NjE2MTM0Mzg2NjY2NjQzMzJlNzQ3MzIwMDAmbm5fYWs9MDFkZTU0YTczNjYxOWZiODdlMzU1NjgxZjEzZGNhYzc4ZCZudHRsPTMmbnBpcHM9MTgyLjEzOC4xMDEuNDg6NTEwMSZuY21zaWQ9MTAwMDAxJm5ncz01NTFlMDQxYTAwMGI5NWYxNWVjZjc1NTg2MDYyMTZiOCZubl91c2VyX2lkPVlZSEQwMDAwMDc3OSZuZHY9MS4wLjAuMC4yLlNDLUpHUy1JUEhPTkUuMC4wX1JlbGVhc2UmbmVhPSZuZXM9/5fe99cef0cd4397dde6250111148ae63.m3u8"];
    [self.player play];
}

#pragma mark - playerDelegate -

- (void)showPlayerState:(TD_PLAYER_STATE)playerState
{
    //根据不同的状态作出相应操作
    switch (playerState) {
        case TD_PLAYER_STATE_READY:
            [self.player play];
            break;
        case TD_PLAYER_STATE_PLAYING:
            break;
        case TD_PLAYER_STATE_PAUSE:
            break;
        case TD_PLAYER_STATE_STOP:
            break;
        case TD_PLAYER_STATE_START_BUFFER:
            break;
        case TD_PLAYER_STATE_END_BUFFER:
            break;
        case TD_PLAYER_STATE_FINISH:
            break;
        case TD_PLAYER_STATE_FAILED:
        case TD_PLAYER_STATE_ERROR:
            [[[UIAlertView alloc] initWithTitle:@"播放错误" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            break;
        case TD_PLAYER_STATE_RETRY:
            break;
        default:
            break;
    }
}

- (void)videoCurrentPlayTime:(NSInteger)playTime {
    
}

- (void)videoCurrentProgress:(CGFloat)progress {
}


@end
