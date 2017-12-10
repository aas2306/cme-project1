<physical-posts>

  <div class="post-prev" onclick={parent.showFullPost}>
    <strong class="post-title">{ postTitle }</strong>
    <p class="post-text">{ postTextPrev }</p>
    <p class="author">{authorName()}</p>
    <p class="datetime">{date} {time}</p>
  </div>


  <script>
    var that = this;

    that.authorName = function() {
      if (that.anonymous) {
        return "Anónimo";
      } else {
        return that.author;
      };
    }

// preview length check
    that.postTextPrev = that.postText.substring(0, 200);
    if (that.postText.length > 200) {
      that.postTextPrev = that.postTextPrev + "...";
    }


  </script>

  <style>
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
    align-text: right;
    font-size: 12px;
  }
  .author {
    font-size: 13px;
  }

  </style>

</physical-posts>
