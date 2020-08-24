//
//  Constants.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 24/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

struct UserDefaultKeys {
    static let key_LoggedInUserData = "userData"
    static let key_userTimeZone = "userTimezone"
}

struct LoginServiceStrings {
    static let keyUserName = "username"
    static let keyPassword = "password"
}

struct GetCountryServiceStrings {
    static let keyCountryCode = "country_code"
    static let keyCountryId = "country_id"
    static let keyCountryName = "country_name"
}

struct GetStateServiceStrings {
    static let keyStateCode = "state_code"
    static let keyStateId = "state_id"
    static let keyStateName = "state_name"
    
}
struct GetDocumentType {
    static let documentTypeID = "document_type_id"
    static let documentType = "document_type"
    static let documentTypeName = "document_type_name"
}
struct GetQuestionType {
    static let answer_detail = "answer_details"
    static let id = "id"
    static let question_id = "question_id"
    static let status = "status"
    
}
struct GetTimeZone {
    static let timeZoneId = "timezone_id"
    static let timeZoneHours = "timezone_hours"
    static let timeZoneName = "timezone_name"
    static let timeZoneCode = "timezone_code"

}
struct GetEventType {
    static let keyEventType = "event_type"
    static let keyEventTypeId = "event_type_id"
    static let keyEventTypeName = "event_type_name"
}
struct GetAddShiftSelectShiftStrings {
    static let keyShiftTaskName = "shift_task_name"
    static let keyShiftTaskId = "shift_task_id"
}
struct GetShiftRankListStrings {
    static let keyRank = "rank"
    static let keyRankValue = "shift_rank"
}

struct DayLight {
    static let day_status = "day_status"
    static let day_id = "day_id"
    
}
