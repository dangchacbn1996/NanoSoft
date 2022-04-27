//
//  CustomerHomePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerHomeVC: BaseView {
    func initData(data:[ViewCustomerHome])
    func reloadData()
}


class CustomerHomePresenter: BasePresenter<CustomerHomeVC> {
    private let service = CustomerHomeService()
    
    // MARK - Private Function
    private let group = DispatchGroup()

    private let groupDataList = DispatchGroup()

    var requestNewCustomer = NewCustomerRequest()
    var requestSuggestionCustomer = SuggestionCustomerRequest()
    var requestAgencyCustomer = AgencyCustomerRequest()

    var data: [ViewCustomerHome] = []
    var dataNews: [NewCustomerHomeOptionalResponse] = []
    var dataSuggestion: [SuggestionCustomerHomeOptionalResponse] = []
    var dataAgency: [AgencyCustomerHomeOptionalResponse] = []


    func initDataPresent() {
        self.getServiceSystemCatalog()
        group.notify(queue: .main) {
            Loading.stopAnimation()
        }

        self.services()
        groupDataList.notify(queue: .main) {
            Loading.stopAnimation()
            self.data.removeAll()
            let cellSugesstion = CellViewCustomerHome((identifier: HomeCustomTableViewCell.identfier, height: 270.0.auto(), model: CellDataCustomerHome(type: .Suggestion, newCustomer: self.dataNews, suggestionCustomer: self.dataSuggestion, agencyCustomer: self.dataAgency)))

            let cellNews = CellViewCustomerHome((identifier: NewsCustomTableViewCell.identfier, height: 270.0.auto(), model: CellDataCustomerHome(type: .News, newCustomer: self.dataNews, suggestionCustomer: self.dataSuggestion, agencyCustomer: self.dataAgency)))
            
//            let cellHospitalNews = CellViewCustomerHome((identifier: HospitalNewsTableViewCell.id, height: 270.0.auto(), model: CellDataCustomerHome(type: .News, newCustomer: self.dataNews, suggestionCustomer: self.dataSuggestion, agencyCustomer: self.dataAgency)))

            let cellAgency = CellViewCustomerHome((identifier: AgencyCustomTableViewCell.identfier, height: 205.auto(), model: CellDataCustomerHome(type: .Agency, newCustomer: self.dataNews, suggestionCustomer: self.dataSuggestion, agencyCustomer: self.dataAgency)))

            self.data.append(ViewCustomerHome(nil, nil, [cellSugesstion]))
            self.data.append(ViewCustomerHome(nil, nil, [cellNews]))
//            self.data.append(ViewCustomerHome(nil, nil, [cellHospitalNews]))
            self.data.append(ViewCustomerHome(nil, nil, [cellAgency]))
            self.viewController?.initData(data: self.data)
            self.viewController?.reloadData()
        }
    }
    
    func services() {
        groupDataList.enter()
        self.service.newCustomerService(requestData: self.requestNewCustomer, callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [NewCustomerHomeOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                self.dataNews = repo.data ?? []
                self.groupDataList.leave()
            }) { (repo) in
            }
        })

        groupDataList.enter()
        self.service.suggestionCustomerService(requestData: self.requestSuggestionCustomer, callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [SuggestionCustomerHomeOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                self.dataSuggestion = repo.data ?? []
                self.groupDataList.leave()
            }) { (repo) in
            }
        })

        groupDataList.enter()
        self.service.agencyCustomerService(requestData: self.requestAgencyCustomer, callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [AgencyCustomerHomeOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                self.dataAgency = repo.data ?? []
                self.groupDataList.leave()
            }) { (repo) in
            }
        })
    }
    func getServiceSystemCatalog() {
        //        Loading.startAnimation()
        self.systemCatalog()
        self.systemGenderCatalog()
        self.systemProvincesCatalog()
        self.systemStatusCatalog()
        self.systemAppointmentScheduleCatalog()
        self.systemEmployeeGroupCatalog()
        self.systemReferralCatalog()
        self.systemCustomerTypeCatalog()
        self.systemOccupationCatalog()
        self.systemMemberRatingCatalog()
        self.systemSocialCatalog()
        self.systemSourceToCatalog()
        self.systemEmployeeAndSearchCatalog()
        self.systemServiceCatalog()
    }


}

extension CustomerHomePresenter {
    func systemCatalog() {
        group.enter()
        self.service.systemCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseSystemCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseSystemCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        }
    }

    func systemGenderCatalog() {
        group.enter()
        self.service.systemGenderCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseSystemGenderCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseSystemGenderCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        }
    }

    func systemProvincesCatalog() {
        group.enter()
        self.service.systemProvincesCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseProvincesCatalog else {
                    return
                }
                if repo.code == 1 {
                    if let list = repo.data {
                        SessionManager.shared.listProvince = list
                    }
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseProvincesCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        }
    }

    func systemStatusCatalog() {
        group.enter()
        self.service.systemStatusCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseStatusCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseStatusCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        }
    }
    func systemAppointmentScheduleCatalog() {
        group.enter()
        self.service.systemAppointmentScheduleCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseAppointmentScheduleCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseAppointmentScheduleCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        }
    }

    func systemEmployeeGroupCatalog() {
        group.enter()
        self.service.systemEmployeeGroupCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseEmployeeGroupCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseEmployeeGroupCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        }
    }

    func systemReferralCatalog() {
        group.enter()
        self.service.systemReferralCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseReferralCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseReferralCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        }
    }
    func systemCustomerTypeCatalog() {
        group.enter()
        self.service.systemCustomerTypeCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseCustomerTypeCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseCustomerTypeCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        }
    }

    func systemOccupationCatalog() {
        group.enter()
        self.service.systemOccupationCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseOccupationCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseOccupationCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        }
    }

    func systemMemberRatingCatalog() {
        group.enter()
        self.service.systemMemberRatingCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseMemberRatingCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseMemberRatingCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        }
    }

    func systemSocialCatalog() {
        group.enter()
        self.service.systemSocialCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseSocialCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseSocialCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        }
    }

    func systemSourceToCatalog() {
        group.enter()
        self.service.systemSourceToCatalog(maTinhThanh: "", callBack: { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseSourceToCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseSourceToCatalog.self))
                    //                    let model = <#transformationResponse#>(model: repo)
                    //                       self.viewController?.initData(data: model)
                } else {
                    //                    self.service.showErrorString(text: repo.msg ?? "", action: {
                    //
                    //                    })
                }
            } else {
                //                self.service.showError(response: response)
            }
            self.group.leave()
        })
    }

    func systemEmployeeAndSearchCatalog() {
        group.enter()
        self.service.systemEmployeeAndSearchCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseEmployeeAndSearchCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseEmployeeAndSearchCatalog.self))
                } else {
                }
            } else {
            }
            self.group.leave()
        }
    }

    func systemServiceCatalog() {
        group.enter()
        self.service.systemServiceCatalog { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseServiceCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseServiceCatalog.self))
                } else {
                }
            } else {
            }
            self.group.leave()
        }
    }
}
