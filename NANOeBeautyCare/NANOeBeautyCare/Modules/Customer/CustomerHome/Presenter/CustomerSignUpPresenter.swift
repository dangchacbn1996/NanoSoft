//
//  CustomerSignUpPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 22/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerSignUpVC: BaseView {
    func initData(data:ViewCustomerSignUp)
    func reloadData()

    func alertCreateMessage(text: String)
}


class CustomerSignUpPresenter: BasePresenter<CustomerSignUpVC> {
    private let service = CustomerSignUpService()
    
    // MARK - Private Function
    var createRequestModel = CustomerSignUpRequest(hoTen: "", ngaySinh: "", idGioiTinh: 0, dienThoai: "", maQuanHuyen: "", maTinhThanh: "", diaChi: "", email: "", idLoaiKh: 0, idNgheNghiep: 0, idNguonDen: 0, idNguonGioiThieu: 0, faceBook: "", ghiChu: "", anhKhachHang: "", soCmndTheCccd: "", mucDichDen: "", hoChieu: "", linkFaceHoiThoai: "", maCongTy: Common.BRAND_NUMBER, matKhau: "", congTy: "")
    
    
    func initDataPresent() {
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
    
    
    func district(idx: String, callBack: @escaping (_ status: Bool) -> Void) {
        self.service.provinceCodeCatalog(maTinhThanh: idx, callBack: callBack)
    }
    
    func services() {
            self.createService()
    }
    
    func createService() {
        self.service.createCustomerService(requestData: createRequestModel) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CustomerSignUpOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                self.viewController?.alertCreateMessage(text: repo.msg ?? "")
            }) { (repo) in
                
            }
        }
    }
    
    func uploadImage(image: UIImage) {
        self.service.postUploadImage(request: UploadFile(fileType: .Image, fileName: "khach_hang.jpg", withName: "khach_hang", mimeType: "image/jpeg", image: image), callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [UploadResponseDatum].self, response: response, status, code, successBlock: { (repo) in
                print("SUCCEESS")
                self.createRequestModel.anhKhachHang = repo.data?.first?.url ?? ""
            }, failureBlock: { (repo) in
                print("FAILURE")
            }, isShowErrorMessage: false)
        }) { (progress) in
            print("uploadImage_progress")
            print(progress)
        }
    }
}

extension CustomerSignUpPresenter {
    func systemCatalog() {
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
        }
    }

    func systemGenderCatalog() {
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
        }
    }

    func systemProvincesCatalog() {
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
        }
    }

    func systemStatusCatalog() {
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
        }
    }
    func systemAppointmentScheduleCatalog() {
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
        }
    }

    func systemEmployeeGroupCatalog() {
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
        }
    }

    func systemReferralCatalog() {
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
        }
    }
    func systemCustomerTypeCatalog() {
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
        }
    }

    func systemOccupationCatalog() {
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
        }
    }

    func systemMemberRatingCatalog() {
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
        }
    }

    func systemSocialCatalog() {
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
        }
    }

    func systemSourceToCatalog() {
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
        })
    }

    func systemEmployeeAndSearchCatalog() {
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
        }
    }

    func systemServiceCatalog() {
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
        }
    }
}
