//
//  FormDataHelper.swift
//  RESTAPI
//
//  Created by Hoen on 2023/03/31.
//

import Foundation
import Util

struct FormDataHelper {
    private let boundary: String
    
    private let formBody = NSMutableData()
    
    let formUrl: URL
    
    init(formUrl: URL, boundary: String) {
        self.boundary = boundary
        self.formUrl = formUrl
    }
    
    func addTextField(named name: String, value: String) {
        self.formBody.append(textFormField(named: name, value: value))
    }
    
    func addDataField(named name: String, formData: FormData) {
        self.formBody.append(dataFormField(named: name, formData: formData))
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: formUrl)

        request.httpMethod = "POST"
        self.formBody.append("--\(boundary)--")
        request.httpBody = self.formBody as Data                

        return request
    }
    
    private func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"

        return fieldString
    }
    
    private func dataFormField(named name: String, formData: FormData) -> Data {
        let fieldData = NSMutableData()

        fieldData.append("--\(boundary)\r\n")
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(formData.fileName)\"\r\n")
        fieldData.append("Content-Type: \(formData.mimeType)\r\n")
        fieldData.append("\r\n")
        fieldData.append(formData.data)
        fieldData.append("\r\n")

        return fieldData as Data
    }
}
