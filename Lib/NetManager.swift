//
//  NetManager.swift
//  TestSSLPin
//
//  Created by Mac on 04.09.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation
import TrustKit

class NetManager: NSObject {
    
    static let shared = NetManager()
    
    private lazy var session: URLSession = {
        URLSession(configuration: URLSessionConfiguration.ephemeral,
                                         delegate: self,
                                         delegateQueue: OperationQueue.main)
    }()
    
    func loadURL(url: URL, completion: @escaping (String) -> Void) {
        
        // Load a URL with a good pinning configuration
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                // Display Error Alert
                completion("Pinning validation failed for \(url.absoluteString)\n\n\(error.debugDescription)")
                return
            }
            
            // Display Success Alert
            completion("Pinning validation succeeded for \(url.absoluteString)")
        }
        
        task.resume()
    }
    
}

extension NetManager: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Call into TrustKit here to do pinning validation
        if TrustKit.sharedInstance().pinningValidator.handle(challenge, completionHandler: completionHandler) == false {
            // TrustKit did not handle this challenge: perhaps it was not for server trust
            // or the domain was not pinned. Fall back to the default behavior
            completionHandler(.performDefaultHandling, nil)
        }
    }
    
}
