<new-post>

<div class="group">

  <form>
    <div class="form-group">
      <input class="form-control" type="text" placeholder="Post Title" ref="postTitle">
    </div>
    <div class="form-group">
      <textarea class="form-control" ref="postText" cols="10" rows="10" placeholder="Your post here..."></textarea>
    </div>
    <div class="form-check">
      <label>
        <input class="form-control" type="checkbox" class="form-check-input" checked ref="anonymous">
        Anonymous
      </label>
    </div>
    <div class="form-group">
      <label>
        <input type="radio" name="category" value="Physical" checked> Physical
      </label>
      <label>
        <input type="radio" name="category" value="Sexual"> Sexual
      </label>
      <label>
        <input type="radio" name="category" value="Emotional"> Emotional
      </label>
      <label>
        <input type="radio" name="category" value="Other"> Other
      </label>
    </div>
    <button class="btn" onclick={ createNewPost }>Post</button>
  </form>
</div>


  <script>

  var that = this;

// get the date
  that.date = function() {
    var d = new Date();
    return `${d.getDate()}/${d.getMonth()}/${d.getFullYear()}`;
    }

// get the time
    that.time = function() {
      var d = new Date();
      var hours = d.getHours();
      var ampm;
      if (hours > 12) {
        hours = hours - 12;
        ampm = "PM";
      } else {
        ampm = "AM"
      };
      return `${hours}:${d.getMinutes()} ${ampm}`;
    }

// make post and send to firebase
  that.createNewPost = function() {
    // current user
    this.user = firebase.auth().currentUser;

    var categoryEl = document.querySelector('[name="category"]:checked');
    var categoryValue = categoryEl.value;

    // make PRIVATE post
    var newPrivatePost = {};
    newPrivatePost.postTitle = that.refs.postTitle.value;
    newPrivatePost.postText = that.refs.postText.value;
    if (this.refs.anonymous.checked) {
      newPrivatePost.anonymous = true;
    } else {
      newPrivatePost.anonymous = false;
    };
    newPrivatePost.category = categoryValue;
    newPrivatePost.date = that.date();
    newPrivatePost.time = that.time();

    var database = firebase.database();
    var privateListRef = database.ref('privateList/' + this.user.uid);

    var newKey = privateListRef.push().key;
    newPrivatePost.postID = newKey;
    privateListRef.child(newKey).set(newPrivatePost);

    // make PUBLIC post
    var newPublicPost = {};
    newPublicPost.postTitle = that.refs.postTitle.value;
    newPublicPost.postText = that.refs.postText.value;
    if (this.refs.anonymous.checked) {
      newPublicPost.anonymous = true;
    } else {
      newPublicPost.anonymous = false;
    };
    newPublicPost.author = this.user.displayName;
    newPublicPost.userID = this.user.uid;
    newPublicPost.date = that.date();
    newPublicPost.time = that.time();
    newPublicPost.category = categoryValue;
    newPublicPost.postID = newKey;
    // MISSING REPLIES

    var publicListRef = database.ref('publicList/' + categoryValue);
    publicListRef.child(newKey).set(newPublicPost);

    that.parent.showTable = true;
    that.parent.newPost = false;
    that.update();

  }



  </script>

  <style>
    .group {
      max-width: 80%;
      margin-left: 15px;
      margin-top: 15px;
    }

  </style>
</new-post>
