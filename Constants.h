//
//  Constants.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#if TARGET_OS_IPHONE
    #define LEADERBOARDIDENTIFIER (@"ic5456")
#else
    #define LEADERBOARDIDENTIFIER (@"icmac5456")
#endif

typedef NS_ENUM(uint32_t, CategoryType) {
    
    HEROCATEGORY       = 0x1 << 1,
    SHURIKENCATEGORY   = 0x1 << 2,
    LEFTCATEGORY       = 0x1 << 3,
    GROUNDCATEGORY     = 0x1 << 4,
    OBSTACLECATEGORY   = 0x1 << 5,
    SHIELDCATEGORY     = 0x1 << 6,
    PAINKILLERCATEGORY = 0x1 << 7,
    GEMCATEGORY        = 0x1 << 8
};

typedef NS_ENUM(uint32_t, KeyType) {
    
    F_KEY = 0x03,
    SPACE   = 0x31
};

typedef NS_ENUM(uint8_t, ParallaxType) {
    
    kParallaxTypeUp = 0,
    kParallaxTypeDown,
    kParallaxTypeRight,
    kParallaxTypeLeft,
    
    kPBParallaxBackgroundDefaultSpeedDifferential = 1,
    kPBParallaxBackgroundDefaultSpeed = 8
};

typedef NS_ENUM(uint8_t, DifficultyType) {
    
    EASY = 20,
    MEDIUM = 15,
    HARD = 10,
    IMPOSSIBLE =5
};