<forums>
    <div class="forum-content-box row">
      <div class="col-md-8 offset-md-2">
        <div class="forumsHeader">
            <div class="fixedButton" show={ !newPost }>
                <button type="button" onclick={ makeNewPost }>
                    <span>
                        <i class="fa fa-plus" aria-hidden="true"></i>
                    </span>
                </button>
            </div>
            <h1>Forums<span show={ newPost }>
                    - New Post</span>
            </h1>
            <p>subtitle here Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
        </div>
        <div show={ showTable } class="container-fluid">
            <div class="row">
                <div class="col">
                    <h2 class="forum-titles" onclick={ physFunc }>Physical Abuse</h2>
                    <!-- <div class="previews">
                        <strong>Title</strong>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...</p>
                    </div>
                    <div class="previews">
                        <strong>Title</strong>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...</p>
                    </div>
                    <div class="previews">
                        <strong>Title</strong>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...</p>
                    </div> -->
                </div>
                <div class="col">
                    <h2 class="forum-titles" onclick={ sexFunc }>Sexual Abuse</h2>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <h2 class="forum-titles" onclick={ emoFunc }>Emotional Abuse</h2>
                </div>
                <div class="col">
                    <h2 class="forum-titles" onclick={ othersFunc }>Others / Miscellaneous</h2>
                </div>
            </div>
        </div>


        <physical-posts if={ showPhys } each={ physicalList }></physical-posts>
        <physical-post-full if={ fullPost } post={ postToShow }></physical-post-full>

        <!-- <sexual if={ showSex }></sexual>
        <emotional if={ showEmo }></emotional>
        <others if={ showOthers }></others> -->

        <new-post if={ newPost }></new-post>

      </div>
    </div>

    <script>

        var that = this;
        that.postToShow = {};

        this.on('mount', function() {
          that.showTable = true;
          that.showPhys = false;
          that.showSex = false;
          that.showEmo = false;
          that.showOthers = false;
          that.newPost = false;
          that.fullPost = false;
        })

        that.showFullPost = function(e) {
          // that.postPreviews = false;
          that.showPhys = false;
          that.postToShow.text = e.item.postText;
          that.postToShow.title = e.item.postTitle;
          that.postToShow.date = e.item.date;
          that.postToShow.time = e.item.time;
          that.postToShow.author = e.item.author;
          that.postToShow.anonymous = e.item.anonymous;
          that.fullPost = true;

          // that.postToShow = e.currentTarget;
          that.update();
          // console.log(e.item);
        }


        // show tags functions
        that.physFunc = function () {
            that.showTable = false;
            that.showPhys = true;
        }
        that.sexFunc = function () {
            that.showTable = false;
            that.showSex = true;
        }
        that.emoFunc = function () {
            that.showTable = false;
            that.showEmo = true;
        }
        that.othersFunc = function () {
            that.showTable = false;
            that.showOthers = true;
        }
        that.makeNewPost = function () {
            that.showTable = false;
            that.newPost = true;
            that.showPhys = false;
            that.fullPost = false;
        }

        // this.user = firebase.auth().currentUser;
        var database = firebase.database()
        var physListRef = database.ref('publicList/Physical');

        this.physicalList = [];

        // var lanternListRef = database.ref('userList'); get lanternList data from Firebase
        physListRef.on('value', function (snapshot) {
            var data = snapshot.val();
            var physArray = [];
            for (var key in data) {
                physArray.push(data[key]);
            }
            that.physicalList = physArray;
            that.update();
        });
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
        button {
            border: 1.5px solid #91B3BC;
            border-radius: 100%;
        }
        .fixedButton {
            position: absolute;
            right: 10%;
            top: 36%;
        }

    </style>

</forums>
