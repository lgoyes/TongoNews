//
//  Regex.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 16/03/21.
//

import Foundation

struct Regex {
    struct Pattern {
        struct Email {
            static let _firstPart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
            static let _serverPart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
            static let full = _firstPart + "@" + _serverPart + "[A-Za-z]{2,8}"
        }
        static let password = "(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}"
    }
    struct Predicate {
        static let email = NSPredicate(format:"SELF MATCHES %@", Regex.Pattern.Email.full)
        static let password = NSPredicate(format: "SELF MATCHES %@", Regex.Pattern.password)
    }
}
