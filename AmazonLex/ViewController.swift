//
//  ViewController.swift
//  AmazonLex
//
//  Created by PIXERF_SG_WS_12 on 16/4/18.
//  Copyright © 2018 PIXERF_SG_WS_12. All rights reserved.
//

import UIKit
import AWSCore
import AWSLex
import AWSMobileClient

class ViewController: UIViewController {

    @IBOutlet weak var awsLexVoiceButton: AWSLexVoiceButton!
    @IBOutlet weak var responseLbl: UILabel!
    
    override func viewDidLoad() {
        
        // Set the bot configuration details
        // You can use the configuration constants defined in AWSConfiguration.swift file
        let botName = "OrderFlowersOneMOBILEHUB"
        let botRegion: AWSRegionType = .USEast1
        let botAlias = "$LATEST"
        
        // set up the configuration for AWS Voice Button
        let configuration = AWSServiceConfiguration(region: botRegion, credentialsProvider: AWSMobileClient.sharedInstance().getCredentialsProvider())
        let botConfig = AWSLexInteractionKitConfig.defaultInteractionKitConfig(withBotName: botName, botAlias: botAlias)
        
        // register the interaction kit client for the voice button using the AWSLexVoiceButtonKey constant defined in SDK
        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: botConfig, forKey: AWSLexVoiceButtonKey)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        (self.awsLexVoiceButton as AWSLexVoiceButton).delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: AWSLexVoiceButtonDelegate {
    
    func voiceButton(_ button: AWSLexVoiceButton, on response: AWSLexVoiceButtonResponse) {
        DispatchQueue.main.async {
            self.responseLbl.text = "\(response.outputText ?? "")"
        }
    }
    
    func voiceButton(_ button: AWSLexVoiceButton, onError error: Error) {
        DispatchQueue.main.async {
            self.responseLbl.text = "\(error.localizedDescription)"
        }
    }
}
