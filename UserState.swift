//
//  UserState.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 8/5/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

class UserState {
    var name: String = NSUserDefaults.standardUserDefaults().stringForKey("myName") ?? "User" {
        didSet {
            NSUserDefaults.standardUserDefaults().setObject(name, forKey:"myName")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var highScore: Int = NSUserDefaults.standardUserDefaults().integerForKey("myHighScore") ?? 0 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(highScore, forKey:"myHighScore")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
