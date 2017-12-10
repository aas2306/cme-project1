<full-post>
    <div class="postFull">
      <div>
        <!-- { text} -->
        <strong class="post-title">{ opts.post.postTitle }</strong>
        <p class="author">{authorName()}</p>
        <p class="datetime">{opts.post.date} {opts.post.time}</p>
        <p class="category">Categoría: {opts.post.category}</p>
        <p class="post-text">{ opts.post.postText }</p>
      </div>
      <div if={ownedByUser}>
        <span class="deleteBtn" type="button" onclick={deletePost}><i class="fa fa-trash" aria-hidden="true"></i></span>
      </div>
      <div class="replies">
        <p>Comentarios:</p>
        <reply each={replies}></reply>
        <div class="form-group">
          <textarea class="replyTextArea" ref="replyText" placeholder="Your reply here..." rows="4" cols="50"></textarea>
          <label>
            <input class="form-control" type="checkbox" class="form-check-input" ref="anonymous">
            Anónimo
          </label>
          <br>
          <button onclick={createReply}>Publicar Comentario</button>
        </div>
      </div>
    </div>


  <script>
    var that = this;
    this.update();

    that.repliesRef = firebase.database().ref(`publicList/${that.opts.post.category}/${that.opts.post.postID}/replies`);

    that.user = firebase.auth().currentUser;
    if (that.user.uid === that.opts.post.userID) {
      that.ownedByUser = true;
    }

    that.authorName = function() {
      if (that.opts.post.anonymous) {
        return "Anónimo";
      } else {
        return that.opts.post.author;
      };
    }

    that.deletePost = function() {
      var r = confirm("Are you sure you want to delete this post?");
      if (r == true) {
        that.parent.deleteFromFB();
      } else {
        console.log("post will not be deleted");
      }
    }

    that.checkForReplyText = function() {
        if (that.refs.replyText.value == "") {
          return true;
        } else {
          return false;
        }
    }

    // general function for getting replies from FB
    that.replies = [];
    that.getReplies = function(ref){
            ref.on('value', function(snapshot) {
              var data = snapshot.val();
              var array = [];
              for (var key in data) {
                array.push(data[key]);
              }
              that.replies = array;
              that.update();
              console.log(that.replies);
            })
        }

    // call to get replies as soon as tag is mounted
    that.getReplies(that.repliesRef);

    // makes a reply when "add reply" is clicked, calls getReplies in order to update the replies we see
    that.createReply = function() {
      if (that.checkForReplyText()) {
        alert("Reply text cannot be empty.")
        return;
      }
      var reply = {};
      reply.replyText = that.refs.replyText.value;
      reply.userID = that.user.uid;
      reply.author = that.user.displayName;
      if (that.refs.anonymous.checked) {
          reply.anonymous = true;
        } else {
          reply.anonymous = false;
        };
      var newKey = that.repliesRef.push().key;
      reply.replyID = newKey;

      that.addReply(reply, that.repliesRef, newKey);
      that.getReplies(that.repliesRef);

      that.refs.replyText.value = "";
    }

    // adds created reply to FB
    that.addReply = function(replyObj, ref, key) {
      ref.child(key).set(replyObj);
    }

    that.deleteReplyFromFB = function(replyid) {
      var replyRef = firebase.database().ref(`publicList/${that.opts.post.category}/${that.opts.post.postID}/replies/${replyid}`);
      replyRef.remove();
      that.getReplies(that.repliesRef);
    }

  </script>

  <style>
  .postFull {
    margin: 20px 0px 20px 0px;
    position: relative;
  }
  .post-title {
    font-size: 20px;
    color: #5B7D87;
  }
  .post-text {
    font-size: 17px;
    border: 1px solid #2B4251;
    padding: 15px;
    background-color: #c9dbe0;
    margin-top: 10px;
  }
  .datetime{
    align-text: right;
    font-size: 12px;
  }
  .author {
    font-size: 15px;
  }
  .category{
    font-size: 12px;
  }
  .deleteBtn {
    margin: 3px;
    position: absolute;
    right: 0px;
  }
  .replies {
    margin-top: 30px;
    position: relative;
  }
  .form-group {
    margin-left: 10px;
  }
  .replyTextArea {
    border-radius: 1%;
    border-color: grey;
    margin-top: 10px;
  }

  </style>

</full-post>
