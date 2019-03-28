//
//  RepoModel.swift
//  MaticServices
//
//  Created by Sam Kad on 3/27/19.
//  Copyright © 2019 Sam Kad. All rights reserved.
//

import UIKit

struct RepoModel: Codable {

    var name:String?
    var description:String?
    var owner:Owner?
    var stargazers_count:Int?
}

struct Owner:Codable{
    var login:String?
    var avatar_url:String?
}
