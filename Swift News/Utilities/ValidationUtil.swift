//
//  ValidationUtil.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-04.
//

import UIKit

class ValidationUtil {

    static func getAlertMessageForNews(statusCode: Int) -> String {
        //here we can handle all statusCodes
        if (400...499).contains(statusCode) {
            return "Something went wrong please try again."
        } else {
            return "An error occured please try again."
        }
    }
}
