//
//  DetailViewController.swift

//

import UIKit
import SafariServices

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var overviewDetail: UITextView!
    @IBOutlet weak var CircularProgress: CircularProgressView!
    @IBOutlet weak var actorsCollection: UICollectionView!
    @IBOutlet weak var trailersCollection: UICollectionView!
 
    
    // MARK: - Properties
    var movie: Movie!
    let client = Service()
    var movieID: Int?
    var cast:[Cast]?
    var videoList:[Videos]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //backgroundImage.addBlurEffect()
        imageGradient()
        
       self.perform(#selector(animateProgress), with: nil, afterDelay: 0.5)
        
        // MARK: Movie Data
        guard movie != nil else { return }
        
        titleLabel.text = movie.title
        overviewDetail.text = movie.overview
        releaseDate.text = ("Release Date: " + (movie.release_date?.convertDateString())!)
        
        //Runtime
        client.movieDetail(movieID: (movieID)!) { (movieRes:Movie) in
            self.movie = movieRes
            DispatchQueue.main.async {
                if let runtime = self.movie.runtime{
                    self.runTime.text = "Runtime: \(runtime) min"
                }
                
            }
        }
        
        // Movie Average
        if let average = movie.vote_average {
            let rating = String(format:"%.1f", average)
            ratingLabel.text = "\(rating)"
        }
        
        // Movie Poster
        if let posterPath = movie.poster_path {
            let _ = client.taskForGETImage(ImageKeys.PosterSizes.DETAIL_POSTER, filePath: posterPath) { (data, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.moviePosterImage.image = image
                    }
                }
            }
        }
        // Movie Backdrop 
        if let bannerPath = movie.backdrop_path {
            let _ = client.taskForGETImage(ImageKeys.PosterSizes.BACK_DROP, filePath: bannerPath) { (data, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.backgroundImage.image = image
                    }
                }
            }
        }
        
        // Display cast
        client.movieCredits(movieID: (movieID)!) { (credits: Credits) in
            
            if let cast = credits.cast{
                self.cast = cast
            }
            
            DispatchQueue.main.async {
                if self.cast?.count == 0{
                   // self.castViewHeight.constant = 0.0
                }
                self.actorsCollection.reloadData()
            
            }
        }
        
        // Display Trailers
        client.movieVideos(movieID: (movieID)!) { (videos: VideoInfo) in
            if let allVideos = videos.results{
                self.videoList = allVideos
                DispatchQueue.main.async {
                    if self.videoList?.count == 0 {
                        //self.videoViewHeight.constant = 0.0
                    }
                    self.trailersCollection.reloadData()
                }
            }
        }
        
    }
    
    // Status bar will be white
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    var gradient: CAGradientLayer!
    
    func imageGradient() {
        gradient = CAGradientLayer()
        gradient.frame = backgroundImage.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0.6, 0.8, 1]
        backgroundImage.layer.mask = gradient
    }

    /// Animation for average score
    @objc func animateProgress() {
        
        let cP = self.view.viewWithTag(101) as! CircularProgressView
        cP.setProgressWithAnimation(duration: 0.7, value: 0.2)
        cP.trackColor = UIColor.white
        
        let average = movie.vote_average!
        let one = 1.0...1.9
        let two = 2.0...2.9
        let three = 3.0...3.9
        let four = 4.0...4.9
        let five = 5.0...5.9
        let six = 6.0...6.9
        let seven = 7.0...7.9
        let eight = 8.0...8.9
        let nine = 9.0...9.9
        let ten = 10.0
        
        if one ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.1)
            cP.progressColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if two ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.2)
            cP.progressColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if three ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.3)
            cP.progressColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if four ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.4)
            cP.progressColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else if five ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.5)
            cP.progressColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else if six ~= average {
           cP.setProgressWithAnimation(duration: 0.7, value: 0.6)
            cP.progressColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else if seven ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.7)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if eight ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.8)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if nine ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.9)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if ten ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 1.0)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.0)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
    }
    // MARK: Actions
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

// MARK: NOTE - May add cast later.
//        if collectionView == self.actorsCollection{
//            if let number = self.cast?.count{
//                return number
//            }
//            else{
//                return 0
//            }
//        }
        if collectionView == self.trailersCollection{
            if let number = self.videoList?.count {
                return number
            }
            else{
                return 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let trailerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trailerCell", for: indexPath) as! TrailersCell

        
        if collectionView == self.trailersCollection {
            let video_one = self.videoList![indexPath.row]
        
      
        }
        
        return trailerCell
        
   }
}
