<auth>

    <div class="buttons">
        <button if={ !user } onClick={ logIn }>Log In</button>
        <button if={ user } onclick={goToProfile}>My Profile</button>
        <button if={ user } onClick={ logOut }>Log Out</button>
    </div>

    <script>
        var that = this;
        // this.user = firebase.auth().currentUser;
        firebase.auth().onAuthStateChanged(function (userObj) {
            if (userObj) {
                that.user = userObj;
            } else {
                that.user = null;
            }
            // that.user = firebase.auth().currentUser;
            that.update();
        });
        var user,
            name,
            email,
            photoUrl,
            uid;
        if (user != null) {
            name = user.displayName;
            email = user.email;
            photoUrl = user.photoURL;
            uid = user.uid;
        }

        this.logIn = function(event) {
            var provider = new firebase.auth.GoogleAuthProvider();
            firebase.auth().signInWithPopup(provider).then(function (result) {
                user = result.user;
            }).catch(function (error) {
                console.log('Error:', error.code, error.message);
                console.log('Email of account used:', error.email);
                console.log('Credential type used;', error.credential);
            });
        }

        this.logOut = function(event) {
            firebase.auth().signOut();
            that.update;
        }
        that.goToProfile = function() {
          // that.root.nextElementSibling.tag.goToProf();
          that.root.nextElementSibling._tag.goToProf();
        }

    </script>

    <style>
        .buttons {
            position: fixed;
            top: 1%;
            right: 1%;
            z-index: 99;
        }

    </style>
</auth>
