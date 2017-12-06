<user-profile>

  <div class="profile">
    <img id="displayPic" src={user.photoURL} alt="User Display Photo">
    <h3>{user.displayName}</h3>

    <p>My recent posts:</p>
      <div class="post-prev" each={profilePostList}>
        <strong class="post-title cl">{postTitle}</strong>
        <p class="post-text">{checkTextLength(postText)}</p>
        <p class="datetime">{date} {time}</p>
        <p class="category">Category: {category}</p>
      </div>

  </div>


<script>
    var that = this;
    this.user = firebase.auth().currentUser;

    var database = firebase.database()
    var privListRef = database.ref('privateList/' + that.user.uid);
    this.profilePostList = [];

// get private list from firebase - this user's posts
    privListRef.on('value', function (snapshot) {
        var data = snapshot.val();
        var userPosts = [];
        for (var key in data) {
            userPosts.push(data[key]);
        }
        that.profilePostList = userPosts;
        that.update();
    });

    // post text length check
    that.checkTextLength = function(text) {
      if (text.length > 200) {
        return text.substring(0,200) + "...";
      } else {
        return text;
      }
    }
    //
    // that.postTextPrev = that.postText.substring(0, 200);
    // if (that.postText.length > 200) {
    //   that.postTextPrev = that.postTextPrev + "...";
    // }

</script>

<style>
  .profile {
    margin: 10px;
  }
  #displayPic {
    display: inline;
    max-height: 100px;
    border-radius: 100%;
  }
  .post-prev {
    margin: 10px;
    border: 1px solid black;
    padding: 15px;
  }
  .post-title {
    font-size: 20px;
    text-decoration: underline;
    color: #5B7D87;
  }
  .post-text {
    font-size: 17px;
  }
  .datetime{
    font-size: 12px;
  }
  .category{
    font-size: 12px;
  }
</style>
</user-profile>
