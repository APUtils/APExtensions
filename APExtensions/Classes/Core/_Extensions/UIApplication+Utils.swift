//
//  UIApplication+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 7/14/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit
import MessageUI


public extension UIApplication {
    
    // ******************************* MARK: - Types
    
    typealias Attachment = (data: Data, mimeType: String, fileName: String)
    
    // ******************************* MARK: - Class Methods
    
    /// Initiates call to `phone`
    public static func makeCall(phone: String) {
        let urlString = "telprompt://\(phone)"
        guard let url = URL(string: urlString) else { return }
        
        shared.openURL(url)
    }
    
    /// Tries to send email with MFMailComposeViewController first. If can't uses mailto: url scheme.
    /// - parameter to: Addressee's email
    /// - parameter title: Optional email title
    /// - parameter body: Optional email body
    /// - parameter attachments: Optional array of typles with data, mime type and file name. Will be ignored if MFMailComposeViewController can not be used.
    public static func sendEmail(to: String, title: String? = nil, body: String? = nil, attachments: [Attachment]? = nil) {
        if MFMailComposeViewController.canSendMail() {
            sendEmailUsingMailComposer(to: to, title: title, body: body, attachments: attachments ?? [])
        } else {
            sendEmailUsingMailto(to: to, title: title, body: body)
        }
    }
    
    /// Sends email with MFMailComposeViewController. Won't do anything if `MFMailComposeViewController.canSendMail()` returns false.
    /// - parameter to: Addressee's email
    /// - parameter title: Optional email title
    /// - parameter body: Optional email body
    /// - parameter attachments: Typles with data, mime type and file name.
    public static func sendEmailUsingMailComposer(to: String, title: String? = nil, body: String? = nil, attachments: [Attachment] = []) {
        guard let vc = MFMailComposeViewController.create(to: [to]) else { return }
        
        vc.setSubject(title ?? "")
        vc.setMessageBody(body ?? "", isHTML: false)
        attachments.forEach({
            vc.addAttachmentData($0.0, mimeType: $0.1, fileName: $0.2)
        })
        
        g_rootViewController.present(vc, animated: true, completion: nil)
    }
    
    /// Sends email using mailto: url scheme. Won't do anything if URL can not be composed.
    /// - parameter to: Addressee's email
    /// - parameter title: Optional email title
    /// - parameter body: Optional email body
    public static func sendEmailUsingMailto(to: String, title: String? = nil, body: String? = nil) {
        guard var urlComponents = URLComponents(string: "mailto:\(to)") else { return }
        
        if let title = title {
            let item = URLQueryItem(name: "subject", value: title)
            urlComponents.addQueryItem(item)
        }
        
        if let body = body {
            let item = URLQueryItem(name: "body", value: body)
            urlComponents.addQueryItem(item)
        }
        
        guard let url = urlComponents.url else { return }
        
        shared.openURL(url)
    }
}
