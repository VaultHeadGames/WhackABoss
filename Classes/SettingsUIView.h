//
//  SettingsUIView.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/9/10.
//  Copyright 2010 Vault Head Games. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsUIView : UIViewController {
	IBOutlet UISwitch* switchMusic;
	IBOutlet UISwitch* switchSound;
	IBOutlet UIButton* buttonOpenFeint;
}

@property (nonatomic,retain) UISwitch* switchMusic;
@property (nonatomic,retain) UISwitch* switchSound;
@property (nonatomic,retain) UIButton* buttonOpenFeint;

-(IBAction)buttonOpenFeintClicked:(id)sender;
-(IBAction)switchMusicChanged:(id)sender;
-(IBAction)switchSoundChanged:(id)sender;

@end
