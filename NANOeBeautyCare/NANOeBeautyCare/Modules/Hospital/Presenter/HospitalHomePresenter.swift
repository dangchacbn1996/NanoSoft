//
//  HospitalHomePresenter.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 17/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

protocol HospitalHomeVC: BaseView {
    func initData(data:[ViewHospitalMain])
    func reloadData()
}

class HospitalHomePresenter: BasePresenter<HospitalHomeVC> {
    private let service = CustomerHomeService()
    private let hosService = HospitalService()
    
    // MARK - Private Function
    private let group = DispatchGroup()

    private let groupDataList = DispatchGroup()

    var requestNewCustomer = NewCustomerRequest()
    var requestEmployeeByMajor = EmployeeMajorRequest()
    var requestSuggestionCustomer = SuggestionCustomerRequest()
    var requestAgencyCustomer = AgencyCustomerRequest()

    var data: [ViewHospitalMain] = []
    var dataNews: [NewCustomerHomeOptionalResponse] = []
    var dataMajor: [ResponseMajorModel] = []
    var dataDoctorByMajor: [ResponseDoctorByMajorModel] = []
    var dataService: [ResponseComboServiceModel] = []
    var dataSuggestion: [ResponseProductModel] = []
    var dataContact: [AgencyCustomerHomeOptionalResponse] = []
    
    var serviceAvailable: [CustomerHomeService.HospitalServiceKindResponse] = []
//    var dataAgency: [AgencyCustomerHomeOptionalResponse] = []


    func initDataPresent() {
        self.getServiceSystemCatalog()
        group.notify(queue: .main) {
            Loading.stopAnimation()
        }

        self.services()
        groupDataList.notify(queue: .main) {
            Loading.stopAnimation()
            self.data.removeAll()
            
            let cellIntro = CellViewHospitalMain((identifier: HospitalIntroduceTableViewCell.id, height: nil, model: CellDataHospitalMain(type: .Introduce, newCustomer: self.dataNews, majorHospital: self.dataMajor, doctorByMajor: self.dataDoctorByMajor, serviceHospital: self.dataService, suggestionCustomer: self.dataSuggestion)))
            
            let cellBooking = CellViewHospitalMain((identifier: HospitalBookingTableViewCell.id, height: nil, model: CellDataHospitalMain(type: .DoctorByMajor, newCustomer: self.dataNews, majorHospital: self.dataMajor, doctorByMajor: self.dataDoctorByMajor, serviceHospital: self.dataService, suggestionCustomer: self.dataSuggestion)))
            
            let cellFunction = CellViewHospitalMain((identifier: HospitalProductTypeTableViewCell.id, height: nil, model: CellDataHospitalMain(type: .Function, newCustomer: self.dataNews, majorHospital: self.dataMajor, doctorByMajor: self.dataDoctorByMajor, serviceHospital: self.dataService, suggestionCustomer: self.dataSuggestion)))
            
            let cellService = CellViewHospitalMain((identifier: HospitalServiceTableViewCell.id, height: nil, model: CellDataHospitalMain(type: .Service, newCustomer: self.dataNews, majorHospital: self.dataMajor, doctorByMajor: self.dataDoctorByMajor, serviceHospital: self.dataService, suggestionCustomer: self.dataSuggestion)))
            
            let cellNews = CellViewHospitalMain((identifier: HospitalNewsTableViewCell.id, height: nil, model: CellDataHospitalMain(type: .News, newCustomer: self.dataNews, majorHospital: self.dataMajor, doctorByMajor: self.dataDoctorByMajor, serviceHospital: self.dataService, suggestionCustomer: self.dataSuggestion)))
            
            let cellContact = CellViewHospitalMain((identifier: HospitalContactTableViewCell.id, height: nil, model: CellDataHospitalMain(type: .none, newCustomer: self.dataNews, majorHospital: self.dataMajor, doctorByMajor: self.dataDoctorByMajor, serviceHospital: self.dataService, suggestionCustomer: self.dataSuggestion)))

            self.data.append(ViewHospitalMain(nil, nil, [cellIntro]))
            self.data.append(ViewHospitalMain(nil, nil, [cellBooking]))
            self.data.append(ViewHospitalMain(nil, nil, [cellFunction]))
            self.data.append(ViewHospitalMain(nil, nil, [cellService]))
            self.data.append(ViewHospitalMain(nil, nil, [cellNews]))
            self.data.append(ViewHospitalMain(nil, nil, [cellContact]))
            
//            self.data.append(ViewCustomerHome(nil, nil, [cellHospitalNews]))
//            self.data.append(ViewCustomerHome(nil, nil, [cellAgency]))
            self.viewController?.initData(data: self.data)
            self.viewController?.reloadData()
        }
    }
    
    func services() {
        groupDataList.enter()
        self.hosService.hospitalDetail(model: HospitalService.HospitalDetailRequest(MaCongTy: "PK_CONGNGHE4.0")) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: ResponseHospitalDetailModel.self, response: response, status, code) { model in
                DataManager.shared.companyModel = model.data
//                self.dataContact = [model.data]
                self.groupDataList.leave()
            } failureBlock: { fail in
                let model = ResponseHospitalDetailModel()
                let cache = UserDefaults.standard.df.fetch(forKey: String(describing: ServerSettingResponse.self), type: ServerSettingResponse.self)
                for item in (cache?.data ?? []) {
                    if item.maCongTy == "PK_CONGNGHE4.0" {
                        model.MaCongTy = item.maCongTy
                        model.DiaChiCongTy = item.diaChiCongTy
                        model.DienThoai = item.dienThoai
                        model.Fax = item.fax
                        model.Email = item.email
                        model.Domain = item.domain
                        model.URL = item.url
                        model.TenCongTy = item.tenCongTy
                        model.TenThuongHieu = item.tenThuongHieu
                        model.MST = item.mst
                        model.Logo = item.logo
                        model.KeyGen = item.keyGen
//                        self.dataContact = [model]
                        DataManager.shared.companyModel = model
                    }
                }
                self.groupDataList.leave()
            }

        }
        
        groupDataList.enter()
        HospitalService().hospitalNotiReadCount(callBack: { response, status, code in
            SessionManager.shared.countNoti = (response as? [HospitalNotifyCount])?.first?.TotalCount ?? 0
//            SessionManager.shared.countNoti = 5
            self.groupDataList.leave()
        })
        
        groupDataList.enter()
        self.service.agencyCustomerService(requestData: self.requestAgencyCustomer, callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [AgencyCustomerHomeOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                self.dataContact = repo.data ?? []
                self.groupDataList.leave()
            }) { (repo) in
            }
        })
        
        groupDataList.enter()
        self.service.getHospitalServices(requestData: CustomerHomeService.HospitalServicesRequest(IDKhachHang: UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)?.id), callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [CustomerHomeService.HospitalServiceKindResponse].self, response: response, status, code, successBlock: { (repo) in
//                self.serviceAvailable = repo.data ?? []
                self.groupDataList.leave()
            }) { (repo) in
            }
        })
        
        groupDataList.enter()
        self.service.newCustomerService(requestData: self.requestNewCustomer, callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [NewCustomerHomeOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                self.dataNews = repo.data ?? []
                self.groupDataList.leave()
            }) { (repo) in
            }
        })

//        groupDataList.enter()
//        self.service.suggestionCustomerService(requestData: self.requestSuggestionCustomer, callBack: { (response, status, code) in
//            self.service.handleArrayStatus(modelOptionalResponse: [SuggestionCustomerHomeOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
//                self.dataSuggestion = repo.data ?? []
//                self.groupDataList.leave()
//            }) { (repo) in
//            }
//        })
        
        //Comment do chua co data
        groupDataList.enter()
        self.service.hosGetListFunction(requestData: HosProductRequest(TenLoaiDichVu: "", Id: 0, page_size: 100, page_num: 1), callBack: { (response, status, code) in
//            self.service.handleArrayStatus(modelOptionalResponse: [ResponseProductModel].self, response: response, status, code, successBlock: { (repo) in
//                self.dataSuggestion = repo.data ?? []
//                self.groupDataList.leave()
//            }) { (repo) in
//            }

            self.service.handleArrayStatus(modelOptionalResponse: [ResponseProductModel].self, response: response, status, code, successBlock: { (repo) in
                self.dataSuggestion = repo.data ?? []
                self.groupDataList.leave()
            }, failureBlock: { (repo) in
                self.dataSuggestion = repo.data ?? []
                self.groupDataList.leave()
            }, isShowErrorMessage: true)
        })

        groupDataList.enter()
        self.service.hosGetListMajor(requestData: self.requestSuggestionCustomer, callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [ResponseMajorModel].self, response: response, status, code, successBlock: { (repo) in
                self.dataMajor = repo.data ?? []
                self.groupDataList.leave()
            }) { (repo) in
            }
        })
        
        groupDataList.enter()
        self.service.hosGetListService(requestData: HosServiceRequest(TenGoi: "", Id: 0, page_size: 1, page_num: 1000), callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [ResponseComboServiceModel].self, response: response, status, code, successBlock: { (repo) in
                SessionManager.shared.listServicePackage = repo.data ?? []
                self.dataService = repo.data ?? []
                self.groupDataList.leave()
            }) { (repo) in
            }
        })

        groupDataList.enter()
        self.service.agencyCustomerService(requestData: self.requestAgencyCustomer, callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [AgencyCustomerHomeOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                self.dataContact = repo.data ?? []
                self.groupDataList.leave()
            }) { (repo) in
            }
        })
    }
    
    func getEmployeeByMajor(major: ResponseMajorModel, success: @escaping (([ResponseDoctorByMajorModel]) -> Void)) {
        self.dataDoctorByMajor = []
//        success(self.dataDoctorByMajor)
        if let id = major.Id {
            let idMajor = Int(id)
                self.requestEmployeeByMajor.IdKhoa = idMajor
                self.service.hosGetListDoctorByMajor(requestData: self.requestEmployeeByMajor, callBack: { (response, status, code) in
                    self.service.handleArrayStatus(modelOptionalResponse: [ResponseDoctorByMajorModel].self, response: response, status, code, successBlock: { (repo) in
//                        self.dataDoctorByMajor = repo
                        self.dataDoctorByMajor = repo.data ?? []
                        success(repo.data ?? [])
//                        self.dataMajor = repo.data ?? []
//                        self.groupDataList.leave()
                    }) { (repo) in
                        self.dataDoctorByMajor = []
                        success([])
                    }
                })
            
        }
    }
    
    func getProductDetail(product: ResponseProductModel, success: @escaping (([ResponseProductListSubModel]) -> Void)) {
        self.service.hosGetListSubFunction(requestData: HosProductListSubFuntionRequest(page_num: 1, page_size: 1000, TenDichVu: "", MaLoaiDichVu: product.MaLoaiDichVu ?? "")) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [ResponseProductListSubModel].self, response: response, status, code, successBlock: { (repo) in
                let result = repo.data ?? []
                success(result)
            }) { (repo) in
            }
        }
    }
    
//    func getServiceDetail(service: ResponseComboServiceModel, success: @escaping ((ModelBaseService<[ResponseComboDetailModel]>) -> Void)) {
//        if let id = service.IDComboGoiDVSP {
////            let idMajor = Int(id)
////                self.requestEmployeeByMajor.IdKhoa = idMajor
//            self.service.hosGetServiceDetail(requestData: HosServiceDetailRequest(Id: id, TenDichVu: ""), callBack: { (response, status, code) in
//                self.service.handleArrayStatus(modelOptionalResponse: [ResponseComboDetailModel].self, response: response, status, code, successBlock: { (repo) in
////                    let result = ResponseComboDetailModel.demoData()
////                    success(result)
//                    success(repo)
//                }) { (repo) in
////                    repo.msg
//                }
//            })
//        }
//    }
    
    func isTTSAvailable() -> Bool {
        for item in serviceAvailable {
            if item.MaLoaiDichVu == "TTS" {
                return true
            }
        }
        return false
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

extension HospitalHomePresenter {
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
