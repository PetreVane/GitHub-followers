# GitHub-followers
Simple (storyBoard free) iOS app which lists your Github followers. 
This app uses Sean Allen's take-home project, as starting point. 
But it diverges from Sean implementation in various ways. 

Status: Completed. 

What's similar to Sean's project:
- the visual interface is similar 
- used the same assets
- app functionalities are the same (for now): 
  - fetching data, used a collectionView with diffable dataSource
  - used tableView for favorites
- the general feel of the app is similar to Sean's project


What's different from Sean's project:
- implemented a CacheManager
- PersistenceManager uses FileManager to write to a local plist file, instead of UserDefaults 
- followed Coordinators design pattern instead of MVC
- delegated responsability of presenting ViewControllers to a concrete Router (protocol) implementation
- relied heavily on delegation pattern, when passing data from viewControllers to coordinators
- delegated networking responsability of cells (UICollectionViewCell & UITableViewCell) to a default implementation of Composer protocol
- added documentation for 95 % of the project
- and many other small changes



Sean Allen take-home project is available here: https://seanallen.teachable.com/



<img width="401" alt="image" src="https://user-images.githubusercontent.com/22425017/75874154-76466000-5e11-11ea-9ecc-27b40e1537ff.png">

<img width="405" alt="image" src="https://user-images.githubusercontent.com/22425017/75874267-a988ef00-5e11-11ea-95ac-7889c38243e2.png">

<img width="383" alt="image" src="https://user-images.githubusercontent.com/22425017/75874727-a4786f80-5e12-11ea-8d6f-26213bdd318f.png">
