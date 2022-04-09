//
//  DownloadPdf.swift
//  IndividualStudyPlan
//
//  Created by Dossymkhan Zhulamanov on 08.04.2022.
//

import Foundation
import PDFKit

func savePdf(urlString: String, fileName: String) {
       DispatchQueue.main.async {
           let url = URL(string: urlString)
           let pdfData = try? Data.init(contentsOf: url!)
           let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
           let pdfNameFromUrl = "individualStudyPlan-\(fileName).pdf"
           let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
           do {
               try pdfData?.write(to: actualPath, options: .atomic)
               print("pdf successfully saved!")
           } catch {
               print("Pdf could not be saved")
           }
       }
   }


func showSavedPdf(url: String, fileName: String) {
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("\(fileName).pdf") {
                        let pdf = PDFView()
                        pdf.document = PDFDocument(url: url)
                        print("File exists")
                }
            }
        } catch {
            print("could not locate pdf file !!!!!!!")
        }
    }
}
