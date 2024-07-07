//
//  AdManager.swift
//  sentnt
//
//  Created by Mohamet amine Ndiaye on 26/01/2024.
//

import Foundation
import IronSource

class AdManager: NSObject, LevelPlayInterstitialDelegate {
    


    
    func didLoad(with adInfo: ISAdInfo!) {
     
        
    }
    
    func didFailToLoadWithError(_ error: Error!) {
     
    }
    
    func didOpen(with adInfo: ISAdInfo!) {
        
    }
    
    func didShow(with adInfo: ISAdInfo!) {
        
    }
    
    func didFailToShowWithError(_ error: Error!, andAdInfo adInfo: ISAdInfo!) {
        
    }
    
    func didClick(with adInfo: ISAdInfo!) {
        
    }
    
    func didClose(with adInfo: ISAdInfo!) {
        loadInterstitial()
    }
    
    static let shared = AdManager()

    override init() {
        super.init()
        IronSource.setLevelPlayInterstitialDelegate(self)

    }

    func loadInterstitial() {
        IronSource.loadInterstitial()
    }
    
    func showInterstitial(from viewController: UIViewController) {
        if IronSource.hasInterstitial() {
            IronSource.showInterstitial(with: viewController)
        }
    }

    
}
