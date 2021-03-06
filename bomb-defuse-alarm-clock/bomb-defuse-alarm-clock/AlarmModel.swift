//
//  AlarmModel.swift
//  bomb-defuse-alarm-clock
//
//  Created by Jason Chow on 12/5/18.
//  Copyright © 2018 Jason Chow Justin Shee. All rights reserved.
//

import Foundation
import UserNotifications
import AVFoundation


struct Time{
    var time: String
}


func sendTimeToBomb(setTimeInput: String){
    //let countdown = Time(time: setTimeInput)
    
    
}


//Converts time from UIDatePicker to hh:mm format
func convertTimeLabel(setTimeInput: String) -> String{
    
    let setTimeString = setTimeInput
    
    let formatter = DateFormatter()
    let formatterPrint = DateFormatter()
    
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    formatterPrint.dateFormat = "hh:mm a"
    
    let date = formatter.date(from: setTimeString)
    let adjustedTime = formatterPrint.string(from: (date!))
    print("alarm created, time: " + adjustedTime)
    return adjustedTime
}

func convertTimeForCountdown(setTimeInput: String) -> String{
    let setTimeString = setTimeInput
    
    let formatter = DateFormatter()
    let formatterPrint = DateFormatter()
    
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    formatterPrint.dateFormat = "HH:mm:ss"

    let date = formatter.date(from: setTimeString)
    let adjustedTime = formatterPrint.string(from: (date!))
    return adjustedTime
}

func convertTimeAlarm(setTimeInput: String){
    
    let setTimeString = setTimeInput
    
    let formatter = DateFormatter()
    let formatterHour = DateFormatter()
    let formatterMinute = DateFormatter()
    
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    formatterHour.dateFormat = "HH"
    formatterMinute.dateFormat = "mm"
    
    let date = formatter.date(from: setTimeString)
    
    let alarmInHours = formatterHour.string(from: date!)
    let alarmInMinutes = formatterMinute.string(from: date!)
    
    alarmNotification(hour: alarmInHours, minute: alarmInMinutes)
}

func convertTimeHours(setTimeInput: String) -> String{
    let setTimeString = setTimeInput
    
    let formatter = DateFormatter()
    let formatterHour = DateFormatter()
    
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    formatterHour.dateFormat = "HH"
    
    let date = formatter.date(from: setTimeString)
    
    let alarmInHours = formatterHour.string(from: date!)
    
    return alarmInHours
}

func converTimeMinutes(setTimeInput: String) -> String{
    let setTimeString = setTimeInput
    
    let formatter = DateFormatter()
    let formatterMinute = DateFormatter()
    
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    formatterMinute.dateFormat = "mm"
    
    let date = formatter.date(from: setTimeString)
    
    let alarmInMinutes = formatterMinute.string(from: date!)
    
    return alarmInMinutes
}

func alarmNotification(hour: String, minute: String){
    
    let hourInt = Int(hour)
    let minuteInt = Int(minute)
    
    let content = UNMutableNotificationContent()
    content.title = NSString.localizedUserNotificationString(forKey: "Alarm", arguments: nil)
    content.body = NSString.localizedUserNotificationString(forKey: "WAKE UP, DEFUSE THE BOMB", arguments: nil)
    
    //default sound, don't use, use for testing
    //content.sound = UNNotificationSound.default
    
    let sound: UNNotificationSound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "alarm-sound.wav"))
    content.sound = sound
    
    var dateInfo = DateComponents()
    dateInfo.hour = hourInt
    dateInfo.minute = minuteInt
    
    print("Alert created for time: " + hour + ":" + minute)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
    
    let request = UNNotificationRequest(identifier: "Alarm", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

}

func receivedNotification(center: UNUserNotificationCenter, didReceiveNotificationResponse response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
    
    print("didReceive")
    completionHandler()
}

func clearNotifcations(){
    let center = UNUserNotificationCenter.current()
    center.removeAllPendingNotificationRequests()
}

 var musicSound: AVAudioPlayer = AVAudioPlayer()

func bombSound(){
    
    do {
        let musicFile = Bundle.main.path(forResource: "alarm-sound", ofType: "wav")
        try musicSound = AVAudioPlayer(contentsOf: NSURL (fileURLWithPath: musicFile!) as URL)
    }
    catch {
        print(error)
    }
    
    musicSound.prepareToPlay()
    musicSound.play()
    
    let session = AVAudioSession.sharedInstance()
    do{
        try session.setCategory(.playback, mode: .default)
        try session.setActive(true)
    
    }
    catch{
        print(error)
    }
    
}

func stopBombSound(){
    musicSound.stop()
}






