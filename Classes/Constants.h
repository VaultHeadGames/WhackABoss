//
//  Constants.h
//  WhackABoss
//
//  Created by Jonathan Enzinna on 2/6/10.
//  Copyright Vault Head Games 2010. All rights reserved.
//

#define OPENFEINT_PRODUCTKEY @"LfsKTVWw0sk9vi6ECoNjw"
#define OPENFEINT_SECRETKEY @"yjW20MFgmDOsZE4SQIggP75ftCD9axqAMok3jXjBU"

#define VERSION_MAJOR	0
#define VERSION_MINOR	0
#define VERSION_REV		1
#define VERSION_TAG		@"A"

#define TARGET_FPS 29.97

/*
 BASE_DELAY = DIFF_MOD log <TARGET LAST LEVEL>
 LAST_LEVEL = (BASE_DELAY / BASE_DIFF) ^ 10
 */
#define BASELINE_DIFFICULTY_MODIFIER 2
#define BASELINE_POPUP_DELAY 4
