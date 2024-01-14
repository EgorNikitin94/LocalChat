//
//  SysInitRequest.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/14/24.
//

import Foundation

class SysInitRequest: TCPRequest {
  override var priority: RequestPriority {
    .sysInit
  }
  
  override init() async {
    await super.init()
    
    self.request.payload = .sysInit(SysInit.with({
      $0.appID = "df"
      $0.appSecret = "sd"
      $0.seeesionID = "3232"
    }))
  }
}
