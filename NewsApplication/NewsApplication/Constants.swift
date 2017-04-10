//
//  Constants.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/2/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import UIKit

struct Url {
    static let base = "https://newsapi.org/v1"
    static let articles = "/articles"
    static let source = "/sources"
    static let apiKey = "98770d251fdc4d839e966083932fa600"
    
}

struct Generic {
    static let ok = "Ok"
    static let error = "Error"
    static let success = "Success"
    static let serverSideError = "Server side error occurred"
    static let sessionError = "Session information missing"
    static let apiKey = "apiKey=98770d251fdc4d839e966083932fa600"
}

struct Warnings {
    static let noSourceID = "News Channel not found"
    static let noArticleFound = "Sorry current article is unavailable"
}
