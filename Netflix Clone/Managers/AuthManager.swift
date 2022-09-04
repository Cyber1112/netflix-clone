//
//  AuthManager.swift
//  Netflix Clone
//
//  Created by Khakim Zhumagaliyev on 03.09.2022.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init(){
        
    }
    
    var isSignedIn: Bool {
        return false
    }
    
}
