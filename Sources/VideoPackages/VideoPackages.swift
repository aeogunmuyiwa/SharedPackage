//
//  File.swift
//  
//
//  Created by Adebayo  Ogunmuyiwa on 2020-12-13.
//

import Foundation
import AVFoundation
struct VideoPackages {
    /*
    1.Get global background queue so that our code runs in the background and won’t affect the main queue anymore
    2.Create an object of AVAsset class and pass the video URL as parameter
    3.Now create AVAssetImageGenerator class object which will generate the video thumbnail CGImage
    4.Mark appliesPreferredTrackTransform property as true so that the orientation of thumbnail will be correct
    5.Time of video where thumbnail will be picked
    6.Get the CGImage using copyCGImage function of AVAssetImageGenerator class
    7.Convert CGImage into UIImage
    8 & 9.Get the main queue and pass the thumbnail image in completion closure
    10.If something went wrong print the error
    11.Return nil in case of failure
 */
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
}
