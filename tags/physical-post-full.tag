<physical-post-full>
  <div>
    <div class="postFull">
      <!-- { text} -->
      <strong class="post-title">{ opts.post.title }</strong>
      <p class="author">{authorName()}</p>
      <p class="datetime">{opts.post.date} {opts.post.time}</p>
        <p class="post-text">{ opts.post.text }</p>
      </div>
  </div>

  <script>
    var that = this;

    that.authorName = function() {
      if (that.opts.post.anonymous) {
        return "Anonymous";
      } else {
        return that.opts.post.author;
      };
    }

  </script>

  <style>
  .postFull {
    margin: 20px 0px 20px 0px;
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

  </style>

</physical-post-full>
