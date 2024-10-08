//
//  RouterScreenProtocol.swift
//  amomessenger
//
//  Created by Egor Nikitin on 08/06/2023.
//  Copyright © 2023 amoCRM. All rights reserved.
//

protocol RouterScreenProtocol: RouterNavigationStackScreenProtocol & RouterSheetScreenProtocol {
  var routeType: RouterScreenPresentationType { get }
}

enum RouterScreenPresentationType {
  case sheet
  case fullScreenCover
  case navigationDestination
}

