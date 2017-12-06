<forums>
    <div class="forum-content-box row">
      <div class="col-md-8 offset-md-2">
        <div class="forumsHeader">
            <button show={!newPost} class="fixedButton" type="button" onclick={ makeNewPost }>
              <span>
                  <i class="fa fa-plus" aria-hidden="true"></i>
              </span>
            </button>
            <h1>Forums
              <span show={ newPost }> - New Post</span>
              <span show={ showPhys }> - Physical Abuse</span>
              <span show={ showSex }> - Sexual Abuse</span>
              <span show={ showEmo }> - Emotional Abuse</span>
              <span show={ showOthers }> - Others</span>

            </h1>
            <p>Please be respectful throughout these forums, and feel free to share your experiences anonymously. Any hate speech will be deleted.</p>
            <br>
        </div>
        <div show={ showTable } class="container-fluid">
            <div class="row">
                <div class="col">
                    <h2 class="forum-titles" onclick={ chooseCat }>Physical Abuse</h2>
                </div>
                <div class="col">
                    <h2 class="forum-titles" onclick={ chooseCat }>Sexual Abuse</h2>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <h2 class="forum-titles" ref="emo" onclick={ chooseCat }>Emotional Abuse</h2>
                </div>
                <div class="col">
                    <h2 class="forum-titles" onclick={ chooseCat }>Others / Miscellaneous</h2>
                </div>
            </div>
        </div>


        <physical-posts if={ showPhys } each={ chosenCategory }></physical-posts>

        <sexual-posts if={ showSex } each={chosenCategory}></sexual-posts>
        <emotional-posts if={ showEmo } each={chosenCategory}></emotional-posts>
        <other-posts if={ showOthers } each={chosenCategory}></other-posts>

        <full-post if={fullPost} post={postToShow}></full-post>
        <new-post if={ newPost }></new-post>

      </div>
    </div>

    <script>

        var that = this;

        this.on('mount', function() {
          that.showTable = true;
          that.showPhys = false;
          that.showSex = false;
          that.showEmo = false;
          that.showOthers = false;
          that.newPost = false;
          that.fullPost = false;
        })

        that.closePreviews = function(){
          that.showPhys = false;
          that.showSex = false;
          that.showEmo = false;
          that.showOthers = false;
        }

        // that.postToShow = {};
        that.postToShow;

        that.showFullPost = function(e) {
          that.closePreviews();
          that.postToShow = e.item;
          that.fullPost = true;
          that.update();
        }

        that.makeNewPost = function () {
            that.showTable = false;
            that.newPost = true;
            that.closePreviews();
            that.fullPost = false;
        }

        var database = firebase.database();

        that.chosenCategory = [];

        that.chooseCat = function(e) {
          if (e.currentTarget.innerText === "Physical Abuse") {
            var refname = database.ref('publicList/Physical');
            that.getPrevData(refname);
            that.showPhys = true;
            that.update();
          };
          if (e.currentTarget.innerText === "Sexual Abuse") {
            var refname = database.ref('publicList/Sexual');
            that.getPrevData(refname);
            that.showSex = true;
            that.update();
          };
          if (e.currentTarget.innerText === "Emotional Abuse") {
            var refname = database.ref('publicList/Emotional');
            that.getPrevData(refname);
            that.showEmo = true;
            that.update();
          };
          if (e.currentTarget.innerText === "Others / Miscellaneous") {
            var refname = database.ref('publicList/Other');
            that.getPrevData(refname);
            that.showOthers = true;
            that.update();
          };
        }

        that.getPrevData = function(ref) {
          ref.once('value').then(function(snapshot) {
            var data = snapshot.val();
            var array = [];
            for (var key in data) {
              array.push(data[key]);
          }
            that.chosenCategory = array;
            that.showTable = false;
            that.update();
          })
        }

        var postToDelete;

        that.deleteFromFB = function() {
          var privateRef = database.ref(`privateList/${that.postToShow.userID}/${that.postToShow.postID}`);
          var publicRef = database.ref(`publicList/${that.postToShow.category}/${that.postToShow.postID}`);
          privateRef.remove();
          publicRef.remove();
          that.closePreviews();
          that.showTable = true;
          that.fullPost = false;
          that.update();
        }


    </script>

    <style>

        .container-fluid {
            padding: 10px;
        }
        /*.forum-content-box {
            margin: 0px 200px 0px 200px;
        }*/
        .col {
            border: 0.1px dotted black;
            padding-right: 0;
            padding-left: 0;
        }
        .forumsHeader {
            border-bottom: solid 2px #91B3BC;
            padding: 0px;
            position: relative;
        }
        .forumsHeader h1 {
            font-weight: 600;
        }
        .forum-titles {
            font-family: "Raleway", sans-serif;
            font-weight: 600;
            font-size: 22px;
            margin: 7px 0 0 7px;
            text-decoration: underline;
            text-align: center;
            padding: 30px;
        }
        .previews {
            font-size: 13px;
            border-bottom: 0.5px solid #91B3BC;
            border-top: 0.5px solid #91B3BC;
            line-height: 1.3em;
            margin: 5px;
            padding: 5px;
        }
        p {
            margin-bottom: 0;
        }
        i {
            color: #000000;
            margin: 6px 6px 5px 5px;
        }
        .fixedButton {
            position: absolute;
            right: 0%;
            top: 0%;
            border: 1.8px solid #91B3BC;
            border-radius: 100%;
        }

    </style>

</forums>
