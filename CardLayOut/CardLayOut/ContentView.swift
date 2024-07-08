import SwiftUI
struct ContentView: View {
    @State private var profile: Profile?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let profile = profile {
                    // Main Profile Section
                    MainProfileSection(profile: profile)
                    
                    // Interests Section
                    if !profile.usersInterestList.isEmpty {
                        InterestsSection(interests: profile.usersInterestList)
                    }
                    
                    // Images and other sections
                    ForEach(profile.photoList, id: \.positionInPics) { photo in
                        ImageSection(imageURL: photo.imageUrl)
                        insertNextSection(profile: profile)
                    }
                    
                    // Like/Dislike Section
                    LikeDislikeSection()
                } else {
                    Text("Loading...")
                }
            }
            .padding()
            .onAppear {
                APIService().fetchProfile { profile in
                    self.profile = profile
                }
            }
        }
        .font(.custom("Nunito", size: 18))
        .foregroundColor(Color("#e56e00"))
        .background(Color("#0075F2"))
    }
    
    @ViewBuilder
    private func insertNextSection(profile: Profile) -> some View {
        if !profile.usersInterestList.isEmpty {
            InterestsSection(interests: profile.usersInterestList)
        } else if !profile.usersQuestionsList.isEmpty {
            QuestionSection(question: profile.usersQuestionsList[0].question, answer: profile.usersQuestionsList[0].answer)
        } else if let location = profile.city as String? {
            LocationSection(location: location)
        }
    }
}

// MARK: - Main Profile Section
struct MainProfileSection: View {
    let profile: Profile
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let profilePic = profile.photoList.first(where: { $0.profilePic })?.imageUrl {
                AsyncImage(url: URL(string: profilePic)) { image in
                    image.resizable()
                         .frame(width: 100, height: 100)
                         .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                .overlay(
                    profile.verified ? Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.blue)
                        .offset(x: 35, y: 35) : nil
                )
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            
            Text("\(profile.fullName), \(profile.age)")
                .font(.title)
                .bold()
            
            if let aboutMe = profile.aboutMe {
                Text(aboutMe)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// MARK: - Interests Section
struct InterestsSection: View {
    let interests: [UserInterest]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Interests")
                .font(.headline)
            
            ForEach(interests, id: \.interestTitle) { interest in
                HStack {
                    AsyncImage(url: URL(string: interest.iconUrl)) { image in
                        image.resizable()
                             .frame(width: 24, height: 24)
                             .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    Text(interest.interestTitle)
                }
                .padding(5)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// MARK: - Image Section
struct ImageSection: View {
    let imageURL: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
                     .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .padding()
    }
}

// MARK: - Question Section
struct QuestionSection: View {
    let question: String
    let answer: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Question")
                .font(.headline)
            
            Text(question)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(answer)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// MARK: - Location Section
struct LocationSection: View {
    let location: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Location")
                .font(.headline)
            
            Text(location)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// MARK: - Like/Dislike Section
struct LikeDislikeSection: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Text("Like")
            }
            .padding()
            .background(Color.green)
            .cornerRadius(10)
            
            Button(action: {}) {
                Text("Dislike")
            }
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            
            Button(action: {}) {
                Text("Superlike")
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            
            Button(action: {}) {
            }
        }
    }
}
