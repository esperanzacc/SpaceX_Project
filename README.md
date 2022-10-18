# SpaceX Project 

#### (iOS 15.0 / With Apollo package 0.53.0 version/ Use MVVM design pattern/ SwiftUI framework)

## Project preview:

![image](https://github.com/esperanzacc/SpaceX_Project/blob/main/spaceX.gif)

## Description:

Use Apollo package which is a platform you can do API calls using GraphQL (asynchronus fetching).

GraphQL: https://api.spacex.land/graphql/

### Work Flow: Install Apollo  -> Fetch the data and Process -> Display

#### First Part: Install Apollo 

---------------------------------

♢ Go to File -> Add Packages and Paste this https://github.com/apollographql/apollo-ios.git and select the version Up to Next Minor (I use 0.53.0 version)

<img width="640" alt="Screen Shot 2022-10-17 at 9 46 00 PM" src="https://user-images.githubusercontent.com/90818221/196337766-b8c2374f-8cbd-4f32-a002-ccd3bd2f30bc.png">

Check Apollo option. Then Click Finish.

<img width="640" alt="Screen Shot 2022-10-17 at 9 46 39 PM" src="https://user-images.githubusercontent.com/90818221/196337761-02263282-1936-41b9-888c-37597220a2df.png">

---------------------------------

♢ Generate the schema.json file (Apollo requires a schema.json file)

Open your terminal and go to your project folder then enter below command

````

npm install -D apollo

````

After that enter 

````

apollo schema:download --endpoint=(paste the GraphQL website) schema.json

````

For example apollo schema:download --endpoint=https://api.spacex.land/graphql/ schema.json

If you succeed you will see ✅Loading..... ✅Saving.....

This will download the schema and save it into the folder.

---------------------------------

♢ Create a GraphQL Query

Usually we will need to use GraphQL query to fetch data. (Apollo requires that each query has a unique name.

So, before paste our query. Type below first and paste your query inside the curly bracket.

query xxxx {

}

<img width="640" alt="Screen Shot 2022-10-17 at 9 54 44 PM" src="https://user-images.githubusercontent.com/90818221/196355355-32f300ce-c898-4508-b796-8a766a7465ed.png">

In the middle of GraphQL, you can find the query depend on which data you want to fetch from the left hand side.

In my project, here is my query file. (Create a blank file and save it as .graphql file.

query GetLaunches($limit: Int!, $offset: Int!) {
  launches(limit: $limit, offset: $offset) {
    id
    details
    mission_name
    rocket {
      rocket_name
    }
    ships {
      home_port
      id
      image
      name
    }
  }
}

---------------------------------

♢ Add run script on build phase

Go to project settings -> build phase -> press + (new run script) and paste below text 

````
# Go to the build root and search up the chain to find the Derived Data Path where the source packages are checked out.
DERIVED_DATA_CANDIDATE="${BUILD_ROOT}"

if [ $ENABLE_PREVIEWS == "NO" ]; then

while ! [ -d "${DERIVED_DATA_CANDIDATE}/SourcePackages" ]; do
  if [ "${DERIVED_DATA_CANDIDATE}" = / ]; then
    echo >&2 "error: Unable to locate SourcePackages directory from BUILD_ROOT: '${BUILD_ROOT}'"
    exit 1
  fi

  DERIVED_DATA_CANDIDATE="$(dirname "${DERIVED_DATA_CANDIDATE}")"
done

# Grab a reference to the directory where scripts are checked out
SCRIPT_PATH="${DERIVED_DATA_CANDIDATE}/SourcePackages/checkouts/apollo-ios/scripts"

if [ -z "${SCRIPT_PATH}" ]; then
    echo >&2 "error: Couldn't find the CLI script in your checked out SPM packages; make sure to add the framework to your project."
    exit 1
fi

cd "${SRCROOT}/${TARGET_NAME}/GraphQL"
"${SCRIPT_PATH}"/run-bundled-codegen.sh codegen:generate --target=swift --includes=./**/*.graphql --localSchemaFile="schema.json" --namespace "GQL" APIs --passthroughCustomScalars

else

  echo "Skip apollo GraphQL generating because of preview mode."

fi

<img width="931" alt="Screen Shot 2022-10-17 at 10 03 15 PM" src="https://user-images.githubusercontent.com/90818221/196339973-946e69e6-0e35-4784-bbd4-319e57bbdec9.png">

````

Try to build your project ( commant+B ) If succeed, congragulations!! It will also generate the API file for you. Drad the file below APIs folder to your project.

<img width="460" alt="Screen Shot 2022-10-17 at 10 10 46 PM" src="https://user-images.githubusercontent.com/90818221/196341079-8b8d4ccb-47ec-482b-9223-549fd8c1c3cc.png">

<img width="640" alt="Screen Shot 2022-10-17 at 10 17 42 PM" src="https://user-images.githubusercontent.com/90818221/196341687-471b4f82-0ebd-4c4c-aee1-e304737b7b23.png">

<img width="640" alt="Screen Shot 2022-10-17 at 10 17 42 PM" src="https://user-images.githubusercontent.com/90818221/196341703-51ec3eff-1975-4b1b-8c9f-d8f1edc640dd.png">

Note: Do not edited anything in the file cuz it is automatically created.

Note: Everytime when you change the query.graphql, the file will be regenerated and you have to drag and drop again.


#### Second Part: Make a network call to fetch data 

---------------------------------

♢ Create a network call

Create a swift file named as NetworkService and paste below text. This will allow you to connect to the server and fetch data with your query.

For example in my project:

```
import Foundation
import Apollo

class NetworkService {
  // use static keyword lets properties and methods that belong to a type rather than to instances of a type.
  static let shared: NetworkService = NetworkService()
  
  // use private(set) limit write access internal, and allow external read.
  private(set) var apolloClient: ApolloClient

  init() {
  // you can change the url to your graphQL url.
    apolloClient = ApolloClient(url: URL(string: "https://api.spacex.land/graphql")!)
  }
}

```

---------------------------------

♢ Create ViewModel: View Model -> manages the state and data that your view portrays. Contains business logic and code to carry out functions to the data.

```

import Foundation
import Apollo

class LaunchViewModel: ObservableObject {

  // @Published keyword: In order for the view to detect data changes in the properties of the viewModel. The view model must mark its properties with the    
     @Published keyword. ( In other words, we should add this keyword before the properties we want to broadcast its changes.
  
  @Published var launches: [GQL.GetLaunchesQuery.Data.Launch] = []

  private let apolloClient: ApolloClient = NetworkService.shared.apolloClient
  
  // Add init() {} -> when the data is fetched, the viewModel will be initialized. 
  init() {
      loadLaunchList()
  }
    
  private func loadLaunchList() {
    
    // GetLaunchesQuery -> change to your queryname+Query
    apolloClient.fetch(query: GQL.GetLaunchesQuery(limit: 100, offset: 0)) { [weak self] (result) in
      guard let self = self else { return }

      switch result {
      case .success(let queryResult):
        guard let launches = queryResult.data?.launches else { return }
        // -> queryResult.data?.launches get array of json
        
        // process the data and save it into the launches variable
        self.launches = launches.compactMap { $0 }
        // compactMap - > Returns an array containing the non-nil results of calling the given transformation with each element of this sequence.
        print("Sucess!")
      case .failure(let error):
        print("error: \(error.localizedDescription)")
      }
    }
  }
}

```

Run your app (command + R) -> In your console, you should see the Success! ( If you want to see the data, you can type print("Sucess! \(queryResult)") )

Note: ViewModel conform ObservableObject protocol -> the view can 'observe' it and pick up any data changes on its properties marked with @published.
Easy to say, which one can be listened.

---------------------------------

♢ Model -> Apollo generated the data type automatically. Thus, I didn't create another model file. 


#### Third Part: Display the data in the view

Before starting to type in the contentView file, you have to think about what do you want to display on your view. (you can draw your mockup view on the paper easiy not pretty but can understand)

For example, in my project, I want to make a launches list and then user can navigate to the second view to see the details.

![IMG_7277](https://user-images.githubusercontent.com/90818221/196349063-8acf728a-c429-4e21-99f7-c321c82b3bf5.jpg)

When you are done with the draft, you can think about which view you will use 

→ Navigation View: can navigate to the other screen.

→ ScrollView: can scroll up and down

.....(etc.)


Here is the code of my first view

```

import SwiftUI

struct LaunchListView: View {
  @ObservedObject var launchModel = LaunchViewModel()
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: true) {
        LazyVStack(alignment: .center) {
          ForEach(launchModel.launches, id: \.id) { launch in
            NavigationLink {
              LaunchDetailView(launches: launch, rocket: launch.rocket, ships: launch.ships?.compactMap { $0 } ?? [])
            } label: {
              HStack {
                Text("Mission: \n \(launch.missionName ?? "")")
                  .font(.title3)
                  .bold()
                  .foregroundColor(.white)
              }
              .frame(width: 180, height: 100)
              .background(Color.blue)
              .cornerRadius(15)
            }
          }.padding(10)
        }.padding(.horizontal)
      }.navigationTitle("Launches List")
    }
  }
}

```

Note: @ObservedObject -> Inside the view, by marking the viewModel with the @ObservedObject property wrapper, you indicate that we want to listen for any published changes from the objece. launchModel is listening to LaunchViewModel().

Here is the code of second view

```

import SwiftUI
struct LaunchDetailView: View {
  
  var launches: GQL.GetLaunchesQuery.Data.Launch?
  var rocket: GQL.GetLaunchesQuery.Data.Launch.Rocket?
  var ships: [GQL.GetLaunchesQuery.Data.Launch.Ship]
  
  var body: some View {
    ScrollView {
      VStack(alignment: .center) {
        launchList
        shipList
        rocketNameView
        VStack(alignment: .center) {
          Text("Details:")
            .font(.headline)
            .bold()
            .padding([.bottom, .top], 10)
          Text(launches?.details ?? "Not Available")
        }.padding(.horizontal)
      }
    }.navigationBarTitle(launches?.missionName ?? "")
  }
  
  @ViewBuilder
  var launchList: some View {
    VStack(alignment: .center) {
      Text("Launch ID:")
        .font(.headline)
        .bold()
        .padding([.bottom, .top], 10)
      Text(launches?.id ?? "")
    }
    VStack(alignment: .center) {
      Text("Mission Name:")
        .font(.headline)
        .bold()
        .padding([.bottom, .top], 10)
      Text(launches?.missionName ?? "")
    }
  }
  
  @ViewBuilder
  var rocketNameView: some View {
    VStack(alignment: .center) {
      Text("Rocket Name:")
        .font(.headline)
        .bold()
        .padding([.bottom, .top], 10)
      Text(rocket?.rocketName ?? "")
    }
  }
  
  @ViewBuilder
  var shipList: some View {
    ForEach(ships, id: \.id) { ship in
      AsyncImage(url: URL(string: ship.image ?? "exclamationmark.circle" )) { image in
        image.resizable()
        image.scaledToFill()
      } placeholder: {
        Image(systemName: "exclamationmark.circle")
      }
      .frame(width: 300, height: 300)
      .clipShape(RoundedRectangle(cornerRadius: 25))
      
      VStack(alignment: .center) {
        Text("Ship Id :")
          .font(.headline)
          .bold()
          .padding([.bottom, .top], 10)
        Text(ship.id ?? "")
      }
      
      VStack(alignment: .center) {
        Text("Ship Name:")
          .font(.headline)
          .bold()
          .padding([.bottom, .top], 10)
        Text(ship.name ?? "")
      }
      
      VStack(alignment: .center) {
        Text("Ship Home_Port:")
          .font(.headline)
          .bold()
          .padding([.bottom, .top], 10)
        Text(ship.homePort ?? "")
      }
    }
  }
}

```

Note: To make my code more readable, if you want to display lots of data on your view, it is better to use @viewBuilder to split into different views.
Note: AsyncImage function is only allowed in iOS 15.0

```
AsyncImage(url: URL(string: ship.image ?? "exclamationmark.circle" )) { image in
        image.resizable()
        image.scaledToFill()
      } placeholder: {
        Image(systemName: "exclamationmark.circle")
      }
      
```
