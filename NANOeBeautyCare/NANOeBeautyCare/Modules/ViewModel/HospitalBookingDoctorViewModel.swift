//
//  HospitalBookingDoctorViewModel.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 14/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

protocol HospitalBookingDoctorVC: BaseView {
    func initData(data:[ViewCustomerHome])
    func reloadData()
}

import Foundation
class HospitalBookingDoctorViewModel: BasePresenter<HospitalBookingDoctorVC> {
    private let service = CustomerHomeService()
    
    // MARK - Private Function
    private let group = DispatchGroup()

    private let groupDataList = DispatchGroup()
    private var idNhomNhanVien: Int = 0 {
        didSet {
            services()
        }
    }

    var doctorsData: [ModelOptionResponseEmployeeAndSearchCatalogDatum] = []

    func initDataPresent() {
//        self.getServiceSystemCatalog()
        group.notify(queue: .main) {
            Loading.stopAnimation()
        }

        self.services()
        groupDataList.notify(queue: .main) {
            Loading.stopAnimation()
            self.viewController?.reloadData()
        }
    }
    
    func setIdNhom(index: Int) {
        self.idNhomNhanVien = index
    }
    
    func services() {
        groupDataList.enter()
        self.service.systemEmployeeAndSearchCatalog(idNhomNhanVien: idNhomNhanVien) { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseEmployeeAndSearchCatalog else {
                    return
                }
                if repo.code == 1 {
                    self.doctorsData = repo.data ?? []
                }
            }
            self.groupDataList.leave()
        }
    }
}

//extension HospitalHomeViewModel {
//    func systemCatalog() {
//        group.enter()
//        self.service.systemCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseSystemCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseSystemCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        }
//    }
//
//    func systemGenderCatalog() {
//        group.enter()
//        self.service.systemGenderCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseSystemGenderCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseSystemGenderCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        }
//    }
//
//    func systemProvincesCatalog() {
//        group.enter()
//        self.service.systemProvincesCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseProvincesCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseProvincesCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        }
//    }
//
//    func systemStatusCatalog() {
//        group.enter()
//        self.service.systemStatusCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseStatusCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseStatusCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        }
//    }
//    func systemAppointmentScheduleCatalog() {
//        group.enter()
//        self.service.systemAppointmentScheduleCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseAppointmentScheduleCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseAppointmentScheduleCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        }
//    }
//
//    func systemEmployeeGroupCatalog() {
//        group.enter()
//        self.service.systemEmployeeGroupCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseEmployeeGroupCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseEmployeeGroupCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        }
//    }
//
//    func systemReferralCatalog() {
//        group.enter()
//        self.service.systemReferralCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseReferralCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseReferralCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        }
//    }
//    func systemCustomerTypeCatalog() {
//        group.enter()
//        self.service.systemCustomerTypeCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseCustomerTypeCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseCustomerTypeCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        }
//    }
//
//    func systemOccupationCatalog() {
//        group.enter()
//        self.service.systemOccupationCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseOccupationCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseOccupationCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        }
//    }
//
//    func systemMemberRatingCatalog() {
//        group.enter()
//        self.service.systemMemberRatingCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseMemberRatingCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseMemberRatingCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        }
//    }
//
//    func systemSocialCatalog() {
//        group.enter()
//        self.service.systemSocialCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseSocialCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseSocialCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        }
//    }
//
//    func systemSourceToCatalog() {
//        group.enter()
//        self.service.systemSourceToCatalog(maTinhThanh: "", callBack: { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseSourceToCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseSourceToCatalog.self))
//                    //                    let model = <#transformationResponse#>(model: repo)
//                    //                       self.viewController?.initData(data: model)
//                } else {
//                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
//                    //
//                    //                    })
//                }
//            } else {
//                //                self.service.showError(response: response)
//            }
//            self.group.leave()
//        })
//    }
//
//    func systemEmployeeAndSearchCatalog() {
//        group.enter()
//        self.service.systemEmployeeAndSearchCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseEmployeeAndSearchCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseEmployeeAndSearchCatalog.self))
//                } else {
//                }
//            } else {
//            }
//            self.group.leave()
//        }
//    }
//
//    func systemServiceCatalog() {
//        group.enter()
//        self.service.systemServiceCatalog { (response, status, code) in
//            if status == true {
//                guard let repo = response as? ModelOptionResponseServiceCatalog else {
//                    return
//                }
//                if repo.code == 1 {
//                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseServiceCatalog.self))
//                } else {
//                }
//            } else {
//            }
//            self.group.leave()
//        }
//    }
//}
