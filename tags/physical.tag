<physical>
  <div>
    <physical-post show={postPreviews} each={ opts.physicals }></physical-post>

    <!-- <div if={fullPost} class="full-post">
      <physical-post-full></physical-post-full>
    </div> -->

  </div>


  <script>
    var that = this;
    that.postPreviews = true;

    that.showFullPost = function(e) {
      // that.postPreviews = false;
      that.parent.showPhys = false;
      that.parent.fullPost = true;
      that.parent.postToShow = e.currentTarget;
      that.parent.update();
      console.log(that.parent);
    }

console.log(this);

  </script>

  <style>

  </style>
</physical>
