//
//  Scenes.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

import UIKit

enum Storyboard: String {
    case SignIn = "SignIn"
    case Home = "Home"
    case Appointment = "Appointment"
    case Sales = "Sales"
    case Treatment = "Treatment"

    //
    case CustomerHome = "CustomerHome"
}

enum Screen: String {
    // MARK: - Account
    case SignInViewController = "SignInViewController"
    case ServerSettingViewController = "ServerSettingViewController"
    case ForgotPasswordViewController = "ForgotPasswordViewController"
    
    case MyTabBarViewController = "MyTabBarViewController"
    case CustomerTabBarViewController = "CustomerTabBarViewController"

    case HomeViewController = "HomeViewController"
    // MARK: - HOME
    case CreateCustomerViewController = "CreateCustomerViewController"
    case CustomerDetailViewController = "CustomerDetailViewController"
    case CustomerDetailMoreViewController = "CustomerDetailMoreViewController"
    case CustomerDetailHistoryViewController = "CustomerDetailHistoryViewController"
    case HomeFilterViewController = "HomeFilterViewController"
    // MARK: - Filter
    case TreatmentViewController = "TreatmentViewController"
    case TreatmentFilterViewController = "TreatmentFilterViewController"
    case DetailTreatmentViewController = "DetailTreatmentViewController"
    case TreatmentEditDetailViewController = "TreatmentEditDetailViewController"
    case TreatmentReportViewController = "TreatmentReportViewController"


    // MARK: - Sales
    case SalesFilterViewController = "SalesFilterViewController"
    case CreateSaleServiceViewController = "CreateSaleServiceViewController"
    case ProductSalesServiceViewController = "ProductSalesServiceViewController"

    // MARK: - Sales Edit
    case EditProductServiceViewController = "EditProductServiceViewController"
    case EditCardServiceViewController = "EditCardServiceViewController"
    case EditSpaServiceViewController = "EditSpaServiceViewController"
    case EditInvoveServiceViewController = "EditInvoveServiceViewController"

    // Appointment
    case CreateAppointmentViewController = "CreateAppointmentViewController"
    case AppointmentFilterViewController = "AppointmentFilterViewController"

    //
    case CustomerHomeNewsViewController = "CustomerHomeNewsViewController"
    case CustomerHomeAppointmentViewController = "CustomerHomeAppointmentViewController"

    case CustomerSocialDetailViewController = "CustomerSocialDetailViewController"

    case CreateCustomerSocialViewController = "CreateCustomerSocialViewController"

    case FilterCustomerSocialViewController = "FilterCustomerSocialViewController"
    case CustomerHomeFilterViewController = "CustomerHomeFilterViewController"
    case CustomerHomeNewsFilterViewController = "CustomerHomeNewsFilterViewController"
    case CustomerProfileViewController = "CustomerProfileViewController"
    
    case ChangePasswordViewController = "ChangePasswordViewController"
    case CustomerSignUpViewController = "CustomerSignUpViewController"
    case MoreWebViewViewController = "MoreWebViewViewController"
    case CustomerSocialViewController = "CustomerSocialViewController"
    case AppointmentViewController = "AppointmentViewController"
}
