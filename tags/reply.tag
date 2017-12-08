<reply>
  <div class="wholereply">
    <p style="font-size: 13px; color: #5B7D87;">{authorName()}:</p>
    <p>{replyText}</p>
    <div if={ownedByUser}>
      <span class="deleteReplyBtn" type="button" onclick={deleteReply}><i class="fa fa-trash" aria-hidden="true"></i></span>
    </div>
  </div>

<script>
var that = this;

that.user = firebase.auth().currentUser;
if (that.user.uid === that.userID) {
  that.ownedByUser = true;
}

that.authorName = function() {
  if (that.anonymous) {
    return "Anonymous";
  } else {
    return that.author;
  };
}

that.deleteReply = function() {
  var r = confirm("Are you sure you want to delete this?");
  if (r == true) {
    that.parent.deleteReplyFromFB(that.replyID);
  } else {
    console.log("post will not be deleted");
  }
}

</script>

<style>
  .wholereply {
    margin: 10px;
    border: 1px solid black;
    padding: 15px;
    position: relative;
  }
  .deleteReplyBtn {
    position: absolute;
    right: 5px;
    bottom: 5px;
  }

</style>
</reply>
