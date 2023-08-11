//
//  RouterScreenProtocol.swift
//  amomessenger
//
//  Created by Egor Nikitin on 08/06/2023.
//  Copyright © 2023 amoCRM. All rights reserved.
//

protocol RouterScreenProtocol: RouterNavigationViewScreenProtocol & RouterNavigationStackScreenProtocol & RouterSheetScreenProtocol {
  var routeType: RouterScreenPresentationType { get }
}

enum RouterScreenPresentationType {
  case sheet
  case fullScreenCover
  case navigationLink
  
  // To make it work, you have to use NavigationStack
  case navigationDestination
}

