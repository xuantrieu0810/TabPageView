//
//  ViewController.swift
//  ScrollView
//
//  Created by huent18 on 4/6/21.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var image:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tapGesture.numberOfTapsRequired = 2
        tapGesture.numberOfTouchesRequired = 1
        imageView.image = UIImage.init(named: "demo")
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        
        let scale = min(scrollView.zoomScale * 2, scrollView.maximumZoomScale)
            if scale != scrollView.zoomScale { // zoom in
                let point = tapGesture.location(in: imageView)

                let scrollSize = scrollView.frame.size
                let size = CGSize(width: scrollSize.width / scrollView.maximumZoomScale,
                                  height: scrollSize.height / scrollView.maximumZoomScale)
                let origin = CGPoint(x: point.x - size.width / 2,
                                     y: point.y - size.height / 2)
                scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
            } else if scrollView.zoomScale > 1 { // zoom out
                scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: tapGesture.location(in: imageView)), animated: true)
            }
    }
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = scrollView.convert(center, from: imageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
}//end class

extension SecondViewController: UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
