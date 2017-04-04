//
//  ServerCommunication.swift
//  Cheetay
//
//  Created by arbisoft on 12/25/16.
//  Copyright © 2016 Cheetay. All rights reserved.
//

import Foundation

public protocol ServerCommunicationDelegate: class {
    func beforeSendingRequest(sender: Any)
    func afterFetchingResponse(sender: Any, success: Bool, message: String)
}
