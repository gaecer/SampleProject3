# Test app
### Created by Gaetano Cerniglia on Mar 2020.
###  Copyright © 2020 Gaetano Cerniglia. All rights reserved.

This app will display a search input text on the first screen. Once the search has started, the app will try to recover data from the Pixabay API, if successful, the app will memorize the query searched and show the search results page.
The search page will start downloading the images and store the downloaded images in a cache. Before starting a new search and before showing an image, the app will try to recover the cached data. The cache has a limit and is automatically cleared when the limit is reached or when the app receives a memory alert.

Time spent: less than 1 day

## Tech notes

    - Language Swift 5
    - Support iOS: 13.0+
    - Pattern: MVVM-C
    - Combine Apple Framework is used to bind the Model with the UI
    - Apple NSCache is used to manage the Cache
    - Approach: SOLID
    - Dependency Manager: No Dependency
    
## Features

    = Cache of the search results 
    = Cache of the downloaded images
    
## Additional information

    - The app handle errors and responses with completition escaping blocks and enumerations
    - The cache is managed by the NSCache Class, setup with a limit checking eventually memory wornings
    - MVVM-C design pattern applied following a SOLID approach

## Improvements
    
    - We could use a Database to store the results before to quit the app
    - All the classes should be mocked to improve the quality of the tests
    - The test should cover 100% of the app
    - The images can be optimised before to be stored
    - Some animation could improve the UX
    - The coordinato can be improved to handle bigger UI
