//
//  MFMessageComposeViewController+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/20/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import MessageUI

// ******************************* MARK: - Creation

public extension MFMessageComposeViewController {
    /// Creates controller and simplifies its dismissal
    static func create(phone: String) -> MFMessageComposeViewController {
        let vc = MFMessageComposeViewController()
        vc.messageComposeDelegate = vc
        vc.recipients = [phone]
        
        return vc
    }
}

extension MFMessageComposeViewController: MFMessageComposeViewControllerDelegate {
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
